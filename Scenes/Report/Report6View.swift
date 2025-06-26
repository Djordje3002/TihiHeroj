import SwiftUI
import FirebaseFirestore
import SwiftUIFlowLayout

struct Report6View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var text = ""
    @State private var tags = [
        Tag(title: "гурање"), Tag(title: "штипање"), Tag(title: "гребање"), Tag(title: "гађање"),
        Tag(title: "чупање"), Tag(title: "уједање"), Tag(title: "шутирање"), Tag(title: "ударање"),
        Tag(title: "пљување"), Tag(title: "дављење"), Tag(title: "напад оружјем"), Tag(title: "омаловажавање"),
        Tag(title: "оговарање"), Tag(title: "вређање"), Tag(title: "ругање"), Tag(title: "псовање"),
        Tag(title: "имитирање"), Tag(title: "уцењивање"), Tag(title: "претње"), Tag(title: "подсмевање"),
        Tag(title: "игнорисање"), Tag(title: "неприхватање"), Tag(title: "манипулисање"), Tag(title: "добацивање"),
        Tag(title: "сексуално додиривање"), Tag(title: "свлачење"), Tag(title: "силовање"), Tag(title: "инцест"),
        Tag(title: "слање узнемирујућих порука"), Tag(title: "снимање и слање непримерених / претећих видео записа"),
        Tag(title: "слање експлицитних / претећих снимака и слика"), Tag(title: "дечија порнографија")
    ]
    
    var isFormValid: Bool {
        tags.contains { $0.selected }
    }
    
    private var textInput: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.thunder200, lineWidth: 1)
                    )
                TextEditor(text: $text)
                    .frame(minHeight: 44, maxHeight: 44)
                    .padding(8)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.thunder950)
            }
            Text("(Опционо поље)")
                .font(.system(size: 12))
                .foregroundColor(.thunder500)
                .padding(.leading, 14)
        }
        .padding(.top, 8)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ReportTopNav(path: $path, screenNumber: 6)
            
            ScrollView {
                VStack(spacing: 20) {
                    TitleView(text: "Који је облик насиља?")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "14. Изабери појмове који најближе описују ситуацију која се догодила",
                            mandatoryText: "(Обавезно)"
                        )
                        FlowLayout(mode: .scrollable, items: tags, itemSpacing: 4) { tag in
                            TagView(tag: Binding(
                                get: { tag },
                                set: { newTag in
                                    if let index = tags.firstIndex(where: { $0.id == tag.id }) {
                                        tags[index] = newTag
                                    }
                                }
                            ))
                        }
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "15. Уколико горе наведени појмови не одговарају догађају, молимо да у празно поље унесеш неки други појам",
                            mandatoryText: nil
                        )
                        textInput
                    }
                    
                    NextStepButton(
                        isEnabled: isFormValid,
                        action: {
                            viewModel.report.kindOfViolence = tags.filter { $0.selected }.map { $0.title }
                            viewModel.report.customKindOfViolence = text
                            if !path.contains(.reportScreen7) {
                                path.append(.reportScreen7)
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
    return Report6View(path: .constant([]))
        .environmentObject(viewModel)
}

struct Tag: Identifiable {
    let id = UUID()
    let title: String
    var selected = false
}
