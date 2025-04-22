//
//  AR_Furniture_AppApp.swift
//  AR Furniture App
//
//  Created by Davaughn Williams on 3/28/25.
//

import SwiftUI

@main
struct AR_Furniture_AppApp: App {
    
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
