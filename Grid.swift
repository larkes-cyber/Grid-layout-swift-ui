//
//  Grid.swift
//  FaceUpApp
//
//  Created by Admin on 16.08.2022.
//  Copyright © 2022 Admin. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item:Identifiable, ItemView:View {
    
    var items:[Item]
    var viewForItem:(Item) -> ItemView
    
    init(_ items:[Item], viewForItem: @escaping (Item) -> ItemView){
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader{props in
            self.body(for: GridLayout(itemCount: self.items.count, in: props.size))
        }
    }
    
    func body(for layout:GridLayout) -> some View{
        ForEach(items){item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item:Item, in layout:GridLayout) -> some View{
        
        let index = self.index(for: item)
        
        return viewForItem(item)
            .frame(width:layout.itemSize.width,height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
    func index(for item:Item) -> Int{
        
        for i in 0..<items.count{
            if items[i].id == item.id{
                return i
            }
        }
        
        return 0
        
    }
    
}
