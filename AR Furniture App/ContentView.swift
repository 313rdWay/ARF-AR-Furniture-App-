//
//  ContentView.swift
//  AR Furniture App
//
//  Created by Davaughn Williams on 3/28/25.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    @State private var isControlsVisible: Bool = true
    @State private var showBrowse: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            if self.placementSettings.selectedModel == nil {
                ControlView(isControlsVisible: $isControlsVisible, showBrowse: $showBrowse)
            } else {
                PlacementView()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}

#Preview {
    ContentView()
        .environmentObject(PlacementSettings())
}
