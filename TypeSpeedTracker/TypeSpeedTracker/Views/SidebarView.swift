import SwiftUI
import Foundation

struct NavLink : Identifiable {
    let label: String
    let nav: Page
    let icon: String
    var id: String { label }
}

struct Sidebar: View {
    @EnvironmentObject var viewRouter: ViewRouter

    let navLinks = [
        NavLink(label: "Start A Game", nav: .typingchallenge, icon: "plus"),
        NavLink(label: "Past Games", nav: .pastgameslist, icon: "clock.arrow.circlepath"),
        NavLink(label: "Progress Overview", nav: .pastgamesgraph, icon: "chart.line.uptrend.xyaxis")
    ];

    var body: some View {
        VStack (spacing: 20) {
                ForEach(navLinks) { link in
                    SidebarTab(navLink: link)
                }
        }.frame(width:225)

    }
}

struct SidebarTab : View {
    var navLink : NavLink
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        Button(action:{
            if (navLink.nav != viewRouter.currentPage) {
                withAnimation(.spring()) {
                    viewRouter.currentPage = navLink.nav
                }
            }
        }, label: {
            HStack {
                Image(systemName: navLink.icon).foregroundColor(Color.white.opacity(0.7))
                    .opacity(navLink.nav == viewRouter.currentPage ? 0.5 : 1.0)
                Text(navLink.label).foregroundColor(Color.white.opacity(0.7))
                    .opacity(navLink.nav == viewRouter.currentPage ? 0.5 : 1.0)
                    .onTapGesture {
                    if (navLink.nav != viewRouter.currentPage) {
                        viewRouter.currentPage = navLink.nav
                    }
            }
        }

        }).buttonStyle(PlainButtonStyle()).frame(width:225, height:25)
    }
}
