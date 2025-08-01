import SwiftUI
import FirebaseFirestore

struct Report9View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var wantToReceiveNotification: Bool = false
    @State private var place = ""
    @State private var phone = "" 
    
    var isFormValid: Bool {
        !place.isEmpty && !phone.isEmpty 
    }
    
    private var notificationSelector: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(YesNoOption.allCases, id: \.self) { option in
                RadioButtonView(title: option.displayText, isSelected: wantToReceiveNotification == option.value) {
                    wantToReceiveNotification = option.value
                }
            }
        }
    }
    
    private enum YesNoOption: String, CaseIterable {
        case yes = "Да"
        case no = "Не"
        
        var displayText: String { rawValue }
        var value: Bool { self == .yes }
    }
    
    public func formatPhoneNumber(_ number: String) -> String {
        var cleanedNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if cleanedNumber.hasPrefix("0") && cleanedNumber.count > 1 {
            cleanedNumber = "+381" + String(cleanedNumber.dropFirst())
        } else if !cleanedNumber.hasPrefix("+381") && cleanedNumber.count == 9 {
            cleanedNumber = "+381" + cleanedNumber
        }
        return cleanedNumber
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ReportTopNav(path: $path, screenNumber: 9)
            
            ScrollView {
                VStack(spacing: 20) {
                    TitleView(text: "Обавештење о статусу пријаве")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "21. Да ли желиш да добијаш обавештења о овој пријави?",
                            mandatoryText: "(Обавезно)"
                        )
                        notificationSelector
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "22. Наведи мејл адресу",
                            mandatoryText: "(Обавезно)"
                        )
                        InputView(
                            label: "Мејл адреса",
                            text: $place,
                            iconName: "mail-icon",
                            bottomText: "(Обавезно поље)"
                        )
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "23. Наведи број телефона",
                            mandatoryText: "(Обавезно)"
                        )
                        InputView(
                            label: "Број телефона",
                            text: $phone,
                            iconName: "telephone-icon",
                            bottomText: "(Обавезно поље)"
                        )
                    }
                    
                    NextStepButton(
                        isEnabled: isFormValid,
                        action: {
                            viewModel.report.wantToReceiveNotification = wantToReceiveNotification
                            viewModel.report.emailToReceiveNotification = place
                            viewModel.report.mobilePhoneNumberToReceiveNotification = formatPhoneNumber(phone)
                            if !path.contains(.reportScreen10) {
                                path.append(.reportScreen10)
                            }
                        },
                        title: Text("Следећи корак"),
                        arrow: true
                    )
                }
                .padding(.vertical)
            }
            .background(Color.thunder100)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    Report9View(path: .constant([]))
        .environmentObject(ReportViewModel())
}

