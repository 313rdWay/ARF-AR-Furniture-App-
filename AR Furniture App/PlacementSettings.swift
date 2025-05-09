//
//  PlacementSettings.swift
//  AR Furniture App
//
//  Created by Davaughn Williams on 4/22/25.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    // When the user selects a model in BrowseView, this property is set.
    @Published var selectedModel: FurnitureModel? {
        willSet(newValue) {
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    // When the user taps confirms in PlacementView, the value of selectedModel is assigned to confirmModel
    @Published var confirmedModel: FurnitureModel? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            print("Setting confirmedModel to \(model.name)")
        }
    }
}
