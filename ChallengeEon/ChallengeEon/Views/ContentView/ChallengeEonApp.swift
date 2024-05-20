//
//  ChallengeEonApp.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 16/05/24.
//

import SwiftUI

@main
struct ChallengeEonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
