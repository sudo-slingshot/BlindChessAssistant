//
//  RulesChoice.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct RulesChoice: View {
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var placement = false
    var body: some View {
            VStack{
                CircleRobotImage()
                NavigationLink(destination: PlacementView()){
                    RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.gray).overlay(Text("Placement des pièces").offset(x: 25).foregroundColor(.primary)).overlay(CirclePlacementImage().offset(x: -130))
                }
                NavigationLink(destination: MouvementView()){
                    RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.gray).overlay(Text("Mouvement des pièces").offset(x: 25).foregroundColor(.primary)).overlay(CircleImageMouvement().offset(x: -130))
                }
            }.offset(y: -150)
        }
    }

struct RulesChoice_Previews: PreviewProvider {
    static var previews: some View {
        RulesChoice()
    }
}
