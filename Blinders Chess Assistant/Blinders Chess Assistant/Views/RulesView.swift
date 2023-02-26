//
//  RulesView.swift
//  
//
//  Created by Yohann Le Clech on 29/01/2023.
//

import SwiftUI
import AVFAudio
import AVFoundation
import SwiftSpeech

struct RulesView: View {
    
    let speechSynthesizer = AVSpeechSynthesizer()
    @State private var text = "Push To Speak"
    @State private var mouvement = false
    @State private var placement = false
    @State private var game = false
    
    //TTS Fuction
    private func TTS(speech: String){
        let speech2 = AVSpeechUtterance(string: speech)
        speech2.pitchMultiplier = 1.0
        speech2.rate = 0.5
        speech2.voice = AVSpeechSynthesisVoice(language: "fr")
         
        speechSynthesizer.speak(speech2)
    }
    
    
    
    var body: some View {
        ZStack{
            StaticGradientView()
            VStack{
                RulesCircleImageBig().frame(maxHeight: .infinity, alignment: .top)
                VStack{
                    Text("Règles du jeu").font(.title).foregroundColor(.primary).frame(maxHeight: .infinity, alignment: .bottom)
                    
                    //Onboarding vocal triggers
                    NavigationLink("MouvementView", destination: MouvementView(), isActive: $mouvement).hidden()
                    
                    NavigationLink("PlacementView", destination: PlacementView(), isActive: $placement).hidden()
                    
                    NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
                    
                    
                }.offset(y:-200)
                
                
                //Recording button section
                VStack{
                    Text(text).font(.system(size: 25, weight: .bold, design: .default))
                    SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{session in
                        speechSynthesizer.stopSpeaking(at: .immediate)
                        let systemSoundID: SystemSoundID = 1113
                        AudioServicesPlaySystemSound(systemSoundID)
                    }.onRecognizeLatest(update: $text).onStopRecording{session in
                        let systemSoundID: SystemSoundID = 1114
                        AudioServicesPlaySystemSound(systemSoundID)
                        
                        if (text.contains("mouvement")){
                            mouvement = true
                        }
                        if (text.contains("place")){
                            placement = true
                        }
                        
                        if (text.contains("partie")){
                            game = true
                        }
                        
                    }
                }.frame(maxHeight: .infinity, alignment: .bottom).onAppear{
                    let rulesspeech = "Voulez vous vous enquérir des règles du jeu d'échecs, du placement des pièces sur l'échiquer ou des mouvements autorisés?"
                    TTS(speech: rulesspeech)
                }.onDisappear{
                    speechSynthesizer.stopSpeaking(at: .immediate)
                }
            }
        }
    }
    
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
