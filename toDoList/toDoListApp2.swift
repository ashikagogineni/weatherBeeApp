//
//  toDoListApp2.swift
//  toDoList
//
//  Created by Ashika on 7/19/23.
//

import SwiftUI

struct toDoListApp2: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
