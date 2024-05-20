//
//  ContentView.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 16/05/24.
//

import SwiftUI
import CoreData

enum ViewTypes {
    case home
    case categories
}

class SidebarNavigationManager : ObservableObject {
    @Published var viewType : ViewTypes = .home
}


struct ContentView: View {
    @StateObject var navigationManager = SidebarNavigationManager()
    @State private var isSideBarOpened = false

    var body: some View {
        ZStack {
            VStack {
                switch navigationManager.viewType {
                case .home:
                    Home(viewModel: HomeViewModel())
                case .categories:
                    Categories(viewModel: CategoriesViewModel())
                }
            }.frame(maxWidth: .infinity)
            
            Sidebar(navigationManager: navigationManager, isSidebarVisible: $isSideBarOpened)
        }
        .onAppear() {
            UIView.setAnimationsEnabled(false)
        }
    }
}
