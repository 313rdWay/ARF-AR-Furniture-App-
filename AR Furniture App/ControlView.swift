//
//  ControlView.swift
//  AR Furniture App
//
//  Created by Davaughn Williams on 4/8/25.
//

import SwiftUI

struct ControlView: View {

    @Binding var isControlsVisible: Bool
    @Binding var showBrowse: Bool

    var body: some View {
        VStack {
            
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            
            Spacer()
            
            if isControlsVisible {
                ControlButtonBar(showBrowse: $showBrowse)
            }
        }
    }
}

struct ControlVisibilityToggleButton: View {
    
    @Binding var isControlsVisible: Bool
    
    var body: some View {
        HStack {
            
            Spacer()
            
            ZStack {
                Color.black.opacity(0.25)
                
                Button {
                    print("Control Visibily Toggle Button pressed.")
                    self.isControlsVisible.toggle()
                } label: {
                    Image(systemName: self.isControlsVisible ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                        .buttonStyle(PlainButtonStyle())
                }

            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}

struct ControlButtonBar: View {
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        
        HStack {
            
            // MostRecentlyPlaced Button
            ControlButton(systemIconName: "clock.fill") {
                print("MostRecentlyPlaced button pressed.")
            }
            
            Spacer()
            
            // Browse Button
            ControlButton(systemIconName: "square.grid.2x2") {
                print("Browse button pressed.")
                self.showBrowse.toggle()
            }
            .sheet(isPresented: $showBrowse) {
                // BrowseView
                BrowseView(showBrowse: $showBrowse)
            }
            
            Spacer()
            
            // Settings Button
            ControlButton(systemIconName: "slider.horizontal.3") {
                print("Settings button pressed")
            }
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}

struct ControlButton: View {
    
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: systemIconName)
                .foregroundStyle(.white)
                .font(.system(size: 35))
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 50, height: 50)
    }
}

//#Preview {
//    ControlView()
//}
