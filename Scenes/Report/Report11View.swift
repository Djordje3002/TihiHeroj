import SwiftUI
import FirebaseFirestore

struct Report11View: View {
    @Environment(\.dismiss) var dismiss
    @Binding var path: [AppScreen]
    @EnvironmentObject var viewModel: ReportViewModel // Inject view model
    
    var body: some View {
        VStack {
            VStack {
                Image("Gif")
                    .padding(.top, 80)
                Text("Браво, само тако настави!")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .padding(.vertical, 24)
                Text("Ваша пријава је успешно евидентирана. Направили сте храбар и веома важан корак у даљем решавању проблема.")
                    .padding(.horizontal)
                    .font(.system(size: 17))
                    .foregroundColor(.thunder500)
                    .lineSpacing(6.8)
                Spacer()
            }
            .padding()
            
            NextStepButton(
                isEnabled: true,
                action: {
                    path.append(.contentView(selectedTab: .chat))
                },
                title: Text("Настави даље"),
                arrow: true
            )
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    @StateObject var viewModel = ReportViewModel()
    return Report11View(path: .constant([]))
        .environmentObject(viewModel)
}
