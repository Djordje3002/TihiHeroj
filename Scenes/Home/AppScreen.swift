
import Foundation

enum AppScreen: Hashable {
    case HomeScreen
    case reportScreen0
    case reportScreen1
    case reportScreen2
    case reportScreen3
    case reportScreen4
    case reportScreen5
    case reportScreen6
    case reportScreen7
    case reportScreen8
    case reportScreen9
    case reportScreen10
    case reportScreen11
    case contentView(selectedTab: TabBarItem)
    case language
    case organization
    case termsandconditions(url: URL)
    case privacypolicy(url: URL)
    case licenses
    case news(NewsModel)
}

