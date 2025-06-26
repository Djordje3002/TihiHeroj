import SwiftUI
import FirebaseFirestore

struct Report5View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var victimSelection: VictimOption = .kid
    @State private var extraInfoText = ""
    @State private var hasAdditionalVictims: Bool = false 
    
    var isFormValid: Bool {
        true
    }
    
    private var victimSelector: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(VictimOption.allCases, id: \.self) { option in
                RadioButtonView(title: option.displayText, isSelected: victimSelection == option) {
                    victimSelection = option
                }
            }
        }
    }
    
    private var additionalVictimsSelector: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(YesNoOption.allCases, id: \.self) { option in
                RadioButtonView(title: option.displayText, isSelected: hasAdditionalVictims == option.value) {
                    hasAdditionalVictims = option.value
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ReportTopNav(path: $path, screenNumber: 5)
            
            ScrollView {
                VStack(spacing: 20) {
                    TitleView(text: "Ко је жртва насиља?")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "11. Насиље претрпео/ла:",
                            mandatoryText: "(Обавезно)"
                        )
                        victimSelector
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "12. Знаш ли нешто више о лицу које je претрпело насиље (име, надимак или неки други податак)?",
                            mandatoryText: nil
                        )
                        TextEditorView(text: $extraInfoText, bottomText: "(Опционо поље)", maxHeight: 105, minHeight: 105)
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "13. Да ли је још неко претрпео насиље?",
                            mandatoryText: "(Обавезно)"
                        )
                        additionalVictimsSelector
                    }
                    
                    NextStepButton(
                        isEnabled: isFormValid,
                        action: {
                            switch victimSelection {
                            case .kid: viewModel.report.victim = "child"
                            case .adult: viewModel.report.victim = "adult"
                            case .unknown: viewModel.report.victim = "unknown"
                            }
                            viewModel.report.extraInfoAboutVictim = extraInfoText
                            viewModel.report.existAdditionalVictims = hasAdditionalVictims
                            if !path.contains(.reportScreen6) {
                                path.append(.reportScreen6)
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
    Report5View(path: .constant([]))
        .environmentObject(ReportViewModel())
}

