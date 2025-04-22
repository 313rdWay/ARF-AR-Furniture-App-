//
//  FurnitureModel.swift
//  AR Furniture App
//
//  Created by Davaughn Williams on 4/8/25.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case table
    case chair
    case decor
    case light
    
    var label: String {
        get {
            switch self {
            case .table:
                return "Tables"
            case .chair:
                return "Chairs"
            case .decor:
                return "Decor"
            case .light:
                return "Lights"
            }
        }
    }
}

class FurnitureModel {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
//        self.cancellable = ModelEntity.loadModelAsync(named: filename)
        self.cancellable = ModelEntity.loadModelAsync(named: filename)

            .sink(receiveCompletion: { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename). Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
                
            }, receiveValue: { modelEntity in
                
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded.")
            })
    }
    
}

struct Models {
    var all: [FurnitureModel] = []
    
    init() {
        // Tables
        let diningTable = FurnitureModel(name: "dinnerTable", category: .table, scaleCompensation: 0.32/100)
        let workTable = FurnitureModel(name: "workTable", category: .table, scaleCompensation: 0.32/100)
        let tableBook = FurnitureModel(name: "tableBook", category: .table, scaleCompensation: 0.32/100)
        
        self.all += [diningTable, workTable, tableBook]
        
        // Chairs
        let redChair = FurnitureModel(name: "redChair", category: .chair, scaleCompensation: 0.32/100)
        let woodenChair = FurnitureModel(name: "woodenChair", category: .chair, scaleCompensation: 0.32/100)
        
        self.all += [redChair, woodenChair]
        
        // Decor
        let redGuitar = FurnitureModel(name: "redGuitar", category: .decor, scaleCompensation: 0.32/100)
        let retroTV = FurnitureModel(name: "retroTV", category: .decor, scaleCompensation: 0.32/100)
        let nikeSneaker = FurnitureModel(name: "nikeSneaker", category: .decor, scaleCompensation: 0.32/100)
        let fridge = FurnitureModel(name: "fridge", category: .decor, scaleCompensation: 0.32/100)
        
        self.all += [redGuitar, retroTV, nikeSneaker, fridge]
        
        // Lights
        let ceilingLights = FurnitureModel(name: "ceilingLights", category: .light, scaleCompensation: 0.32/100)
        let titanicLamp = FurnitureModel(name: "titanicLamp", category: .light, scaleCompensation: 0.32/100)
        
        self.all += [ceilingLights, titanicLamp]
    }
    
    func get(category: ModelCategory) -> [FurnitureModel] {
        return all.filter( {$0.category == category} )
    }
    
}
