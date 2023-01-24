//
//  RectangleView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation

struct RectangleView: View {
    
    //Variables for vocal triggers
    
    @State private var text = "Push To Speak"
    @State private var mouvement = false
    @State private var placement = false
    @State private var game = false
    var body: some View {
        NavigationView{
            VStack{
                
                //Header display, for robot head & greeting message
                
                VStack(alignment: .center){
                    CircleRobotImage()
                    Text("Bonjour 👋🏻").font(.title).foregroundColor(.primary)
                    HStack{
                        Text("Je suis votre assistant virtuel pour vous apprendre a jouer aux échecs").foregroundColor(.secondary).font(.subheadline)
                    }
                    Divider()
                }
                
                //Visual menu
                
                NavigationLink(destination: RulesChoice()){
                    RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.gray).overlay(Text("Commencer une partie").offset(x:25).foregroundColor(.primary)).overlay(CircleImage().offset(x: -130))
                }
                
                NavigationLink(destination: RulesChoice()){
                    RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.gray).overlay(Text("Consulter les règles").offset(x:25).foregroundColor(.primary)).overlay(RulesCircleImage().offset(x: -130))
                }
                
                //Onboarding vocal triggers
                NavigationLink("MouvementView", destination: MouvementView(), isActive: $mouvement).hidden()
                
                NavigationLink("PlacementView", destination: PlacementView(), isActive: $placement).hidden()
                
                NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
                
                //Recording button section
                
                Text(text).font(.system(size: 25, weight: .bold, design: .default))
                SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{session in
                    let systemSoundID: SystemSoundID = 1113
                    AudioServicesPlaySystemSound(systemSoundID)
                }.onRecognizeLatest(update: $text).onStopRecording{session in
                    let systemSoundID: SystemSoundID = 1114
                    AudioServicesPlaySystemSound(systemSoundID)
                    
                    //processing vocal speech to text treatment for view changes
                    
                    if (text.contains("mouvement")){
                        mouvement = true
                    }
                    if (text.contains("placement")){
                        placement = true
                    }
                    
                    if (text.contains("partie")){
                        game = true
                    }
                    
                    
                }
            }
            
            
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.height).onAppear{
            SwiftSpeech.requestSpeechRecognitionAuthorization()
        }
    }
}
    
    struct RectangleView_Previews: PreviewProvider {
        static var previews: some View {
            RectangleView()
        }
    }
