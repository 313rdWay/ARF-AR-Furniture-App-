//
//  CustomARView.swift
//  AR Furniture App
//
//  Created by Davaughn Williams on 4/22/25.
//

import RealityKit
import ARKit
import FocusEntity

class CustomARView: ARView {
    
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
    }
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
