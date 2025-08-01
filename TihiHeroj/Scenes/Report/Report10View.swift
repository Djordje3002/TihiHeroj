import SwiftUI
import FirebaseFirestore

struct Report10View: View {
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel // Inject view model
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ReportTopNav(path: $path, screenNumber: 10)
            ScrollView {
                VStack {
                    TitleView(text: "Услови коришћења")
                    HStack {
                        Image("Frame")
                        Text("Услови и одредбе")
                            .padding(.leading)
                        Spacer()
                        Button(action: {
                            // Placeholder for navigating to terms and conditions (e.g., WebView)
                            path.append(.termsandconditions(url: URL(string: "https://example.com/terms")!))
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    HStack {
                        Image("Frame")
                        Text("Политика приватности")
                            .padding(.leading)
                        Spacer()
                        Button(action: {
                            // Placeholder for navigating to privacy policy (e.g., WebView)
                            path.append(.privacypolicy(url: URL(string: "https://example.com/privacy")!))
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
            
            NextStepButton(
                isEnabled: true,
                action: {
                    path.append(.reportScreen11)
                },
                title: Text("Прихвати"),
                arrow: false
            )
        }
        .background(Color.thunder100)
    }
}

#Preview {
    @StateObject var viewModel = ReportViewModel()
    return Report10View(path: .constant([]))
        .environmentObject(viewModel)
}
