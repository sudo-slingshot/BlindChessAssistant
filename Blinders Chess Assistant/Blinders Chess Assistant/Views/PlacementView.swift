//
//  PlacementView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct PlacementView: View {
    var body: some View {
        VStack{
            ChessBack().offset(y:-220).edgesIgnoringSafeArea(.all)
            
            CirclePlacementImageBig().offset(y: -320)
            VStack(alignment: .leading){
                Text("Placement des pièces").font(.title).foregroundColor(.primary)
                HStack{
                    Text("All the rules").font(.subheadline).foregroundColor(.secondary)
                }
            }.offset(y: -310)
        }
    }
}

struct PlacementView_Previews: PreviewProvider {
    static var previews: some View {
        PlacementView()
    }
}
