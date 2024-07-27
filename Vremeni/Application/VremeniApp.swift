//
//  VremeniApp.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 23.07.2024.
//

import SwiftUI

@main
struct VremeniApp: App {

    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ShopView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
