//
//  TomodachiApp.swift
//  Tomodachi
//
//  Created by Daffa Yagrariksa on 22/11/22.
//

import SwiftUI

@main
struct TomodachiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
