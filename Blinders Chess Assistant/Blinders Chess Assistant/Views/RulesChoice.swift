//
//  RulesChoice.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFAudio
import AVFoundation

struct RulesChoice: View {
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var placement = false
    @State private var mouvement = false
    @State private var game = false
    
    
    //Text to speech function
    private func TTS(speech: String){
        let speech2 = AVSpeechUtterance(string: speech)
        speech2.pitchMultiplier = 1.0
        speech2.rate = 0.5
        speech2.voice = AVSpeechSynthesisVoice(language: "fr")
         
        speechSynthesizer.speak(speech2)
    }
    
    
    var body: some View {
        //ZStack is here to integrate a gradient background behind the navigation view
        ZStack{
            //Gradient background
            StaticGradientView()
            VStack{
                VStack{
                    HorseImage()
                    Text("Règles des échecs 📝").font(.title)
                    
                    NavigationLink(destination: RulesView()){
                        RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.clear).overlay(Text("Principe du jeu").offset(x: 25).foregroundColor(.primary)).overlay(RulesCircleImage().offset(x: -130))
                    }
                    
                    NavigationLink(destination: PlacementView()){
                        RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.clear).overlay(Text("Placement des pièces").offset(x: 25).foregroundColor(.primary)).overlay(CirclePlacementImage().offset(x: -130))
                    }
                    NavigationLink(destination: MouvementView()){
                        RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.clear).overlay(Text("Mouvement des pièces").offset(x: 25).foregroundColor(.primary)).overlay(CircleImageMouvement().offset(x: -130))
                    }.onAppear{
                        let rulesspeech = "Voulez vous vous enquérir du principe du jeu d'échecs, du placement des pièces sur l'échiquer ou des mouvements autorisés?"
                        
                        TTS(speech: rulesspeech)
                    }.onDisappear{
                        speechSynthesizer.stopSpeaking(at: .immediate)
                    }
                    
                    //Vocal triggers for speech recognition
                    
                    NavigationLink("MouvementView", destination: MouvementView(), isActive: $mouvement).hidden().frame(height:0)
                    
                    NavigationLink("PlacementView", destination: PlacementView(), isActive: $placement).hidden().frame(height:0)
                    
                    NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden().frame(height:0)
                    
                    NavigationLink("RulesView", destination: RulesView(), isActive: $rules).hidden().frame(height:0)
                    
                }
                
                //Speech recognition button
                VStack{
                    Text(text).font(.system(size: 25, weight: .bold, design: .default))
                    SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{session in
                        speechSynthesizer.stopSpeaking(at: .immediate)
                        let systemSoundID: SystemSoundID = 1113
                        AudioServicesPlaySystemSound(systemSoundID)
                    }.onRecognizeLatest(update: $text).onStopRecording{session in
                        let systemSoundID: SystemSoundID = 1114
                        AudioServicesPlaySystemSound(systemSoundID)
                        
                        //processing vocal speech to text treatment for view changes
                        
                        if text.contains("mouvement")||text.contains("Mouvement"){
                            mouvement = true
                        }
                        if text.contains("place")||text.contains("Place"){
                            placement = true
                        }
                        
                        if text.contains("partie")||text.contains("Partie")||text.contains("Commencer"){
                            game = true
                        }
                        
                        if text.contains("Règles") || text.contains("règles"){
                            rules = true
                        }
                        
                    }//aligning button to the bottom of the screen
                }.frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

struct RulesChoice_Previews: PreviewProvider {
    static var previews: some View {
        RulesChoice()
    }
}
