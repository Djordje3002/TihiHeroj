import SwiftUI

struct SliderView: View {
    @State private var currentPage = 0
    private var onboarding = OnboardingModel()

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height

            let cardWidth = screenWidth * 0.85
            let cardHeight = screenHeight * 1.25
            let imageSize = cardWidth * 1
            let fontSizeTitle = min(22, screenWidth * 0.06)
            let fontSizeDescription = min(16, screenWidth * 0.045)
            let dotSize = min(8, screenWidth * 0.02)

            VStack {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(0..<onboarding.screens.count, id: \.self) { index in
                                VStack {
                                    Image(onboarding.screens[index].image)
                                        .resizable()
                                        .frame(width: imageSize, height: imageSize)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))

                                    Spacer()

                                    VStack(alignment: .leading) {
                                        Text(onboarding.screens[index].title)
                                            .font(.system(size: fontSizeTitle, weight: .semibold))
                                            .padding(.bottom)

                                        Text(onboarding.screens[index].description)
                                            .font(.system(size: fontSizeDescription, weight: .regular))
                                            .foregroundColor(.gray)
                                            .lineSpacing(8)
                                    }
                                    .padding(.horizontal)

                                    Spacer()
                                }
                                .frame(width: cardWidth, height: cardHeight)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 5, y: 5)
                                .scrollTransition(
                                    topLeading: .interactive,
                                    bottomTrailing: .interactive,
                                    axis: .horizontal
                                ) { effect, phase in
                                    effect
                                        .scaleEffect(max(0.9, 1 - abs(phase.value) * 0.1))
                                }
                                .id(index)
                                .overlay {
                                    GeometryReader { geo in
                                        Color.clear
                                            .onChange(of: geo.frame(in: .global).minX) { oldValue, newValue in
                                                let cardWidthWithPadding = cardWidth + 16
                                                let offset = -newValue
                                                let currentIndex = Int(round(offset / cardWidthWithPadding))
                                                if currentIndex != currentPage && currentIndex >= 0 && currentIndex < onboarding.screens.count {
                                                    currentPage = currentIndex
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .padding(.bottom)
                    .safeAreaPadding(.horizontal, screenWidth * 0.05)
                    .scrollClipDisabled()
                    .scrollTargetBehavior(.viewAligned)
                }

                HStack(spacing: 12) {
                    ForEach(0..<onboarding.screens.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? .lilac600 : Color.gray.opacity(0.3))
                            .frame(width: dotSize, height: dotSize)
                    }
                }
            }
        }
    }
}

#Preview {
    SliderView()
}
