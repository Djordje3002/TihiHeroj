import SwiftUI

struct HomeScreenView: View {
    @State var isActive = false
    @State private var sliderOffset: CGFloat = 0
    @State private var buttonOffset: CGFloat = 0
    @State private var path: [AppScreen] = []
    @StateObject private var reportViewModel = ReportViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack(path: $path) {
                VStack(spacing: 0) {
                    navigation
                        .padding(.bottom, 32)
                    
                    SliderView()
                        .frame(height: geometry.size.height * 0.6)
                        .offset(y: sliderOffset)
                        .onAppear {
                            sliderOffset = geometry.safeAreaInsets.top + geometry.size.height
                            withAnimation(.easeInOut(duration: 1)) {
                                sliderOffset = 0
                            }
                        }
                    
                    Spacer()

                    NextStepButton(
                        isEnabled: true,
                        action: {
                            path.append(.reportScreen0) // Navigate to ReportView
                        },
                        title: Text("Започни пријаву"),
                        arrow: false
                    )
                }
                .frame(maxHeight: .infinity)
                .navigationBarHidden(true)
                .navigationDestination(for: AppScreen.self) { route in
                    switch route {
                    case .HomeScreen:
                        HomeScreenView()
                    case .reportScreen0:
                        ReportView(path: $path)
                    case .reportScreen1:
                        Report1View(path: $path)
                    case .reportScreen2:
                        Report2View(path: $path)
                    case .reportScreen3:
                        Report3View(path: $path)
                    case .reportScreen4:
                        Report4View(path: $path)
                    case .reportScreen5:
                        Report5View(path: $path)
                    case .reportScreen6:
                        Report6View(path: $path)
                    case .reportScreen7:
                        Report7View(path: $path)
                    case .reportScreen8:
                        Report8View(path: $path)
                    case .reportScreen9:
                        Report9View(path: $path)
                    case .reportScreen10:
                        Report10View(path: $path)
                    case .reportScreen11:
                        Report11View(path: $path)
                    case .contentView(let selectedTab):
                        ContentView(selectedTab: selectedTab, path: $path)
                    case .language:
                        LanguageView()
                    case .organization:
                        Organization()
                    case .privacypolicy(let url):
                        WebView(url: url)
                    case .termsandconditions(let url):
                        WebView(url: url)
                    case .licenses:
                        LicenceView()
                    case .news(let newsModel):
                        NewsDetailView(news: newsModel)
                    }
                }
            }
            .environmentObject(reportViewModel)
        }
    }
    
    private var navigation: some View {
        HStack {
            Image("NavLogo")
            Spacer()
            Button(action: {
                path.append(.contentView(selectedTab: .documents))
            }) {
                Text("Истражи")
                    .fontWeight(.regular)
                    .foregroundColor(.lilac500)
            }
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeScreenView()
}
