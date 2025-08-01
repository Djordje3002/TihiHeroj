import SwiftUI
import FirebaseFirestore

struct Report7View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var text = ""
    @State private var images: [UIImage] = []
    @State private var isImagePickerPresented = false
    @State private var isCustomActionSheetPresented = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var isFormValid: Bool {
        !text.isEmpty
    }

    private var imageGrid: some View {
        VStack(alignment: .leading, spacing: 10) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(images.indices, id: \.self) { index in
                    Image(uiImage: images[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 99, height: 99)
                        .clipped()
                        .cornerRadius(8)
                        .overlay(
                            Button(action: {
                                images.remove(at: index)
                            }) {
                                Image("cancelcircle")
                                    .foregroundColor(.thunder500)
                            }
                            .offset(x: 16, y: -16),
                            alignment: .topTrailing
                        )
                }
                
                if images.count < 9 {
                    Button(action: {
                        isCustomActionSheetPresented = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.thunder200.opacity(0.2))
                                .frame(width: 99, height: 99)
                            Image("add-picture")
                                .foregroundColor(.lilac600)
                        }
                    }
                }
            }
            
            Text("(Максимална величина свих фајлова заједно је 20MB, дозвољено је додати до 9 фајлова, дозвољене екстензије су: jpg, png, gif, pdf, mp4, m4v, mov)")
                .font(.system(size: 13))
                .foregroundColor(.thunder500)
        }
        .padding(.vertical)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ReportTopNav(path: $path, screenNumber: 7)
            
            ScrollView {
                VStack(spacing: 20) {
                    TitleView(text: "Опис догађаја")
                    
                    CardView {
                        CardQuestionView(
                            questionText: "16. Опиши догађај",
                            mandatoryText: "(Обавезно)"
                        )
                        TextEditorView(text: $text, bottomText: "(Опционо поље)", maxHeight: 169, minHeight: 169)
                    }
                    
                    CardView {
                        CardQuestionView(
                            questionText: "17. Уколико постоји фотографија, снимак или неки други доказ о извршеном насиљу, додај их овде:",
                            mandatoryText: nil
                        )
                        imageGrid
                    }
                    
                    NextStepButton(
                        isEnabled: isFormValid,
                        action: {
                            viewModel.report.description = text
                            viewModel.report.attachments = images.map { image in
                                Attachment(type: "photo", url: "") // Placeholder; upload to Firebase Storage needed
                            }
                            if !path.contains(.reportScreen8) {
                                path.append(.reportScreen8)
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
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(images: $images, sourceType: sourceType)
            }
            .sheet(isPresented: $isCustomActionSheetPresented) {
                CustomActionSheet(
                    isPresented: $isCustomActionSheetPresented,
                    onCamera: {
                        sourceType = .camera
                        isImagePickerPresented = true
                    },
                    onGallery: {
                        sourceType = .photoLibrary
                        isImagePickerPresented = true
                    },
                    onDocuments: {
                        print("Document picker not implemented yet")
                    }
                )
                .presentationDetents([.height(245)])
            }
        }
    }
}

#Preview {
    @StateObject var viewModel = ReportViewModel()
    return Report7View(path: .constant([]))
        .environmentObject(viewModel)
}
