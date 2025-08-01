import SwiftUI
import FirebaseFirestore

struct Report4View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var perpetratorSelection: PerpetratorOption = .kid
    @State private var extraInfoText = ""
    @State private var hasAdditionalPerpetrators: Bool = false
    
    var isFormValid: Bool {
        true 
    }
    
    private var perpetratorSelector: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(PerpetratorOption.allCases, id: \.self) { option in
                RadioButtonView(title: option.displayText, isSelected: perpetratorSelection == option) {
                    perpetratorSelection = option
                }
            }
        }
    }
    
    private var additionalPerpetratorsSelector: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(YesNoOption.allCases, id: \.self) { option in
                RadioButtonView(title: option.displayText, isSelected: hasAdditionalPerpetrators == option.value) {
                    hasAdditionalPerpetrators = option.value
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
    
    var body: some View {
        VStack(spacing: 0) {
            ReportTopNav(path: $path, screenNumber: 4)
            
            ScrollView {
                VStack(spacing: 20) {
                    TitleView(text: "Ко је извршио насиље?")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "8. Насиље је извршио/ла:",
                            mandatoryText: "(Обавезно)"
                        )
                        perpetratorSelector
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "9. Знаш ли нешто више о лицу које je извршило насиље (име, надимак или неки други податак)?",
                            mandatoryText: nil
                        )
                        TextEditorView(text: $extraInfoText, bottomText: "(Опционо поље)", maxHeight: 105, minHeight: 105)
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "10. Да ли је још неко учествовао у насиљу?",
                            mandatoryText: "(Обавезно)"
                        )
                        additionalPerpetratorsSelector
                    }
                    
                    NextStepButton(
                        isEnabled: isFormValid,
                        action: {
                            switch perpetratorSelection {
                            case .kid: viewModel.report.perpetrator = "child"
                            case .adult: viewModel.report.perpetrator = "adult"
                            case .unknown: viewModel.report.perpetrator = "unknown"
                            }
                            viewModel.report.extraInfoAboutPerpetrator = extraInfoText
                            viewModel.report.existAdditionalPerpetrators = hasAdditionalPerpetrators
                            if !path.contains(.reportScreen5) {
                                path.append(.reportScreen5)
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
    Report4View(path: .constant([]))
        .environmentObject(ReportViewModel())
}
