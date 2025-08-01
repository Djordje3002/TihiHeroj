import SwiftUI
import FirebaseFirestore

struct Report1View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss

    @State private var isAnonimus: Bool = true
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var mailadress: String = ""
    @State private var phonenumber: String = ""

    private enum YesNoOption: String, CaseIterable {
        case yes = "Да"
        case no = "Не"
        
        var displayText: String { self.rawValue }
    }

    private var circlesyesorno: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(YesNoOption.allCases, id: \.self) { option in
                HStack(spacing: 0) {
                    Image(isAnonimus == (option.rawValue == "Да") ? "radiobutton" : "graybutton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .onTapGesture {
                            isAnonimus = (option.rawValue == "Да")
                        }
                    Text(option.displayText)
                        .foregroundColor(.black)
                        .fixedSize()
                }
                .padding(.vertical, 0)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ReportTopNav(path: $path, screenNumber: 1)

            ScrollView {
                VStack {
                    TitleView(text: "Ко подноси пријаву?")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "1. Да ли желиш да будеш анониман/а?",
                            mandatoryText: "(Обавезно)"
                        )
                        circlesyesorno
                    }

                    if !isAnonimus {
                        CardView {
                            CardQuestionView(questionText: "2. Како се зовеш?", mandatoryText: nil)
                            InputView(label: "Име", text: $firstName, iconName: "name-tag", bottomText: "(Обавезно поље)")
                            InputView(label: "Презиме", text: $lastName, iconName: "name-tag", bottomText: "(Обавезно поље)")
                        }

                        CardView {
                            CardQuestionView(questionText: "3. Ако је потребно да добијемо више информација о догађају који пријавиш, како да те контактирамо?", mandatoryText: "(Једно поље се мора попунити)")
                            InputView(label: "Мејл адреса", text: $mailadress, iconName: "mail-icon", bottomText: "(Обавезно поље)")
                            InputView(label: "Број телефона", text: $phonenumber, iconName: "telephone-icon", bottomText: "(Обавезно поље)")
                        }
                    }
                }
                .padding(.bottom, 20)
            }


            VStack {
                NextStepButton(
                    isEnabled: viewModel.isReport1FormValid(
                        selection: isAnonimus,
                        firstName: firstName,
                        lastName: lastName,
                        email: mailadress,
                        phoneNumber: phonenumber
                    ),
                    action: {
                        viewModel.saveReport1Data(
                            selection: isAnonimus,
                            firstName: firstName,
                            lastName: lastName,
                            email: mailadress,
                            phoneNumber: phonenumber
                        )
                        if !path.contains(.reportScreen2) {
                            path.append(.reportScreen2)
                        }
                    },
                    title: Text("Следећи корак"),
                    arrow: true
                )
                .background(.thunder100) // Ensure background color
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: -2)
            }
        }
        .navigationBarHidden(true)
        .background(Color.thunder100)
    }
}

#Preview {
    @StateObject var viewModel = ReportViewModel()
    return Report1View(path: .constant([]))
        .environmentObject(viewModel)
}
