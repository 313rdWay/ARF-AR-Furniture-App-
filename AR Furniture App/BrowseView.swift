//
//  BrowseView.swift
//  AR Furniture App
//
//  Created by Davaughn Williams on 4/8/25.
//

import SwiftUI

struct BrowseView: View {
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                // Gridviews for thumbnails
                ModelsByCategoryGrid(showBrowse: $showBrowse)
            }
            .navigationBarTitle(Text("Browse"), displayMode: .large)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showBrowse.toggle()
            })      {
                Text("Done").bold()
            })
        }
    }
}

struct ModelsByCategoryGrid: View {
    
    @Binding var showBrowse: Bool
    let models = Models()
    
    var body: some View {
        VStack {
            ForEach(ModelCategory.allCases, id: \.self) { category in
                
                // Only display grid if category contains items
                let modelsByCategory = models.get(category: category)
                if !modelsByCategory.isEmpty {
                    HorizontalGrid(showBrowse: $showBrowse, title: category.label, items: modelsByCategory)
                }            }
        }
    }
}

struct HorizontalGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    var title: String
    var items: [FurnitureModel]
    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment: .leading) {
            Separator()
            
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(0..<items.count) { index in
                        
                        let model = items[index]
                        
                        ItemButton(model: model) {
                            model.asyncLoadModelEntity()
                            self.placementSettings.selectedModel = model
                            print("BrowseView: selected \(model.name) for placement")
                            self.showBrowse = false
                        }
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
                
            }
        }
    }
}

struct ItemButton: View {
    
    let model: FurnitureModel
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8.0)
        }

        
    }
}

struct Separator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}
