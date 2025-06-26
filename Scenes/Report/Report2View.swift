import SwiftUI
import FirebaseFirestore

struct Report2View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selection: FrequencyOption = .once
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    
    var isFormValid: Bool {
        selection != nil
    }
    
    private var frequencySelector: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(FrequencyOption.allCases, id: \.self) { option in
                RadioButtonView(title: option.displayText, isSelected: selection == option) {
                    selection = option
                }
            }
        }
    }
    
    
    
    var body: some View {
        VStack() {
            ReportTopNav(path: $path, screenNumber: 2)
            
            ScrollView {
                VStack(spacing: 20) {
                    TitleView(text: "Кaдa се догодило насиље?")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "4. Насиље се десило:",
                            mandatoryText: "(Обавезно)"
                        )
                        frequencySelector
                    }
                    
                    CardView {
                        VStack(spacing: 10) {
                            DateTimeInputView(
                                label: "Датум",
                                iconName: "calendar-icon",
                                selectedValue: $selectedDate,
                                showPicker: $showDatePicker,
                                formatter: Formatters.dateFormatter,
                                pickerHeight: 513,
                                isDate: true
                            )
                            
                            DateTimeInputView(
                                label: "Време",
                                iconName: "clock-icon",
                                selectedValue: $selectedTime,
                                showPicker: $showTimePicker,
                                formatter: Formatters.timeFormatter,
                                pickerHeight: 387,
                                isDate: false
                            )
                        }
                    }
                    
                    NextStepButton(
                        isEnabled: isFormValid,
                        action: {
                            switch selection {
                            case .once: viewModel.report.numberOfRepetitionOfViolence = "once"
                            case .severalTime: viewModel.report.numberOfRepetitionOfViolence = "severalTime"
                            case .often: viewModel.report.numberOfRepetitionOfViolence = "often"
                            }
                            viewModel.report.publishedTimestamp = selectedDate.timeIntervalSince1970
                            if !path.contains(.reportScreen3) {
                                path.append(.reportScreen3)
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
    Report2View(path: .constant([]))
        .environmentObject(ReportViewModel())
}
