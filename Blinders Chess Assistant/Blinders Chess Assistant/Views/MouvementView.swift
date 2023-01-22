//
//  MouvementView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct MouvementView: View {
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var placement = false
    var body: some View {
        VStack{
            ChessBack().offset(y:-220).edgesIgnoringSafeArea(.all)
            
            CircleImageMouvementBig().offset(y: -320)
            VStack(alignment: .leading){
                Text("Mouvement des pièces").font(.title).foregroundColor(.primary)
                HStack{
                    Text("Tous les mouvements des pièces d'échecs").font(.subheadline).foregroundColor(.secondary)
                }
            }.offset(y: -310)
        }
    }
}

struct MouvementView_Previews: PreviewProvider {
    static var previews: some View {
        MouvementView()
    }
}
