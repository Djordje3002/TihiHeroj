import SwiftUI
import FirebaseFirestore


struct Report8View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var alreadyReported: Bool = false
    @State private var text = ""
    @State private var selectedIndices: [Int] = []
    
    let options = [
        "Школи", "Центру за социјални рад", "Полицији", "Јавном тужилаштву",
        "Удружењу грађана", "Здравственој установи", "Инспекцији рада",
        "Комуналној милицији", "Центру за заштиту жртава трговине људима",
        "Националном контакт центру за безбедност деце на интернету", "Неком другом"
    ]
    
    var isFormValid: Bool {
        !text.isEmpty && !selectedIndices.isEmpty
    }
    
    private var alreadyReportedSelector: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(YesNoOption.allCases, id: \.self) { option in
                RadioButtonView(title: option.displayText, isSelected: alreadyReported == option.value) {
                    alreadyReported = option.value
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
            ReportTopNav(path: $path, screenNumber: 8)
            
            ScrollView {
                VStack(spacing: 20) {
                    TitleView(text: "Пријава насиља")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "18. Да ли си неком већ пријавио/ла насиље?",
                            mandatoryText: "(Обавезно)"
                        )
                        alreadyReportedSelector
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "19. Коме?",
                            mandatoryText: "(Обавезно)"
                        )
                        CheckboxListView(options: options, selectedIndices: $selectedIndices)
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "20. Напиши нещо више о пријави (број пријаве, име лица коме је пријављено)",
                            mandatoryText: "(Обавезно)"
                        )
                        TextEditorView(text: $text, bottomText: "(Опционо поље)", maxHeight: 169, minHeight: 169)
                    }
                    
                    NextStepButton(
                        isEnabled: isFormValid,
                        action: {
                            viewModel.report.alreadyReported = alreadyReported
                            viewModel.report.whomReported = selectedIndices.map { options[$0] }
                            viewModel.report.extraInfoOfReport = text
                            if !path.contains(.reportScreen9) {
                                path.append(.reportScreen9)
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
    Report8View(path: .constant([]))
        .environmentObject(ReportViewModel())
}
