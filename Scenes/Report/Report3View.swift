import SwiftUI
import FirebaseFirestore

struct Report3View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss

    @State private var place: String = ""
    
    @State private var selection: LocationOption = .institutionOfEducation
    
    var isFormValid: Bool {
        !place.isEmpty && selection != nil
    }
    
    private var locationSelector: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(LocationOption.allCases, id: \.self) { option in
                RadioButtonView(title: option.displayText, isSelected: selection == option) {
                    selection = option
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            ReportTopNav(path: $path, screenNumber: 3)
            
            ScrollView {
                VStack(spacing: 20) {
                    TitleView(text: "Где се догодило насиље?")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "6. У ком месту/граду?",
                            mandatoryText: "(Обавезно)"
                        )
                        InputView(
                            label: "Место",
                            text: $place,
                            iconName: "location-icon",
                            bottomText: "(Обавезно поље)"
                        )
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "7. Где се десило:",
                            mandatoryText: "(Обавезно)"
                        )
                        locationSelector
                    }
                    
                    NextStepButton(
                        isEnabled: isFormValid,
                        action: {
                            viewModel.report.city = place
                            switch selection {
                            case .institutionOfEducation: viewModel.report.place = "policePlace"
                            case .online: viewModel.report.place = "online"
                            case .home: viewModel.report.place = "home"
                            case .policePlace : viewModel.report.place = "publicPlace"
                            case .otherInstitution: viewModel.report.place = "otherInstitution"
                            }
                            if !path.contains(.reportScreen4) {
                                path.append(.reportScreen4)
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
    @StateObject var viewModel = ReportViewModel()
    return Report3View(path: .constant([]))
        .environmentObject(viewModel)
}
