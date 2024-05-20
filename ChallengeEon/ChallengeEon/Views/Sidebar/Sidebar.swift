//
//  Sidebar.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 16/05/24.
//

import SwiftUI

var secondaryColor: Color =
              Color(.init(
                red: 100 / 255,
                green: 174 / 255,
                blue: 255 / 255,
                alpha: 1))

struct MenuItem: Identifiable {
    var id: Int
    var icon: String
    var text: String
}

var userActions: [MenuItem] = [
    MenuItem(id: 4001, icon: "homekit", text: "Home"),
    MenuItem(id: 4002, icon: "doc.text", text: "Categorias"),
]

struct Sidebar: View {
    @ObservedObject var navigationManager : SidebarNavigationManager
    @Binding var isSidebarVisible: Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    var bgColor: Color =
    Color(.init(
        red: 52 / 255,
        green: 70 / 255,
        blue: 182 / 255,
        alpha: 1))
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(isSidebarVisible ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
            .onTapGesture {
                isSidebarVisible.toggle()
            }
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                bgColor
                MenuChevron
                
                VStack(alignment: .leading, spacing: 20) {
                    userProfile
                    Divider()
                    MenuLinks(navigationManager: navigationManager, isSidebarVisible: $isSidebarVisible, items: userActions)
                    Divider()
                }
                .padding(.top, 80)
                .padding(.horizontal, 40)
            }
            .frame(width: sideBarWidth)
            .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)
            
            Spacer()
        }
    }
    
    var userProfile: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(
                    url: URL(
                        string: "https://picsum.photos/100")) { image in
                            image
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.blue, lineWidth: 2)
                                }
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(3 / 2, contentMode: .fill)
                        .shadow(radius: 4)
                        .padding(.trailing, 18)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Rafael")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title3)
                    Text(verbatim: "rafasa@gmail.com")
                        .foregroundColor(secondaryColor)
                        .font(.caption)
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    var MenuChevron: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(bgColor)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: isSidebarVisible ? -18 : -10)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
            
            Image(systemName: "chevron.right")
                .foregroundColor(secondaryColor)
                .rotationEffect(
                    isSidebarVisible ?
                    Angle(degrees: 180) : Angle(degrees: 0))
                .offset(x: isSidebarVisible ? -4 : 8)
                .foregroundColor(.blue)
        }
        .offset(x: sideBarWidth / 2, y: 80)
        .animation(.default, value: isSidebarVisible)
    }
    
    struct MenuLinks: View {
        @ObservedObject var navigationManager : SidebarNavigationManager
        @Binding var isSidebarVisible: Bool
        var items: [MenuItem]
        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                ForEach(items) { item in
                    menuLink(navigationManager: navigationManager, isSidebarVisible: $isSidebarVisible, icon: item.icon, text: item.text)
                }
            }
            .padding(.vertical, 14)
            .padding(.leading, 8)
        }
    }
    
    struct menuLink: View {
        @ObservedObject var navigationManager : SidebarNavigationManager
        @Binding var isSidebarVisible: Bool
        var icon: String
        var text: String
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(secondaryColor)
                    .padding(.trailing, 18)
                Text(text)
                    .foregroundColor(.white)
                    .font(.body)
            }
            .onTapGesture {
                isSidebarVisible.toggle()
                if text == userActions.first?.text {
                    if navigationManager.viewType != .home {
                        navigationManager.viewType = .home
                    }
                } else {
                    if navigationManager.viewType != .categories {
                        navigationManager.viewType = .categories
                    }
                }
            }
            
        }
    }
}
