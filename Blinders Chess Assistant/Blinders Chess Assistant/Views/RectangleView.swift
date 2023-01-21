//
//  RectangleView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI

struct RectangleView: View {
    
    var body: some View {
        NavigationView{
            VStack{
                    VStack(alignment: .center){
                        CircleRobotImage()
                        Text("Bonjour 👋🏻").font(.title).foregroundColor(.primary)
                        HStack{
                            Text("Je suis votre assistant virtuel pour vous apprendre a jouer aux échecs").foregroundColor(.secondary).font(.subheadline)
                        }
                        Divider()
                    }
                    NavigationLink(destination: RulesChoice()){
                        RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.gray).overlay(Text("Commencer une partie").offset(x:25).foregroundColor(.primary)).overlay(CircleImage().offset(x: -130))
                    }
                    
                    NavigationLink(destination: RulesChoice()){
                        RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.gray).overlay(Text("Consulter les règles").offset(x:25).foregroundColor(.primary)).overlay(RulesCircleImage().offset(x: -130))
                    }
                }.offset(y: -150)
                
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.height)
        }
    }
    
    struct RectangleView_Previews: PreviewProvider {
        static var previews: some View {
            RectangleView()
        }
    }
