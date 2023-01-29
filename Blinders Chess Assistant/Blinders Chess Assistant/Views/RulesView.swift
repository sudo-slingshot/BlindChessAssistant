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
        VStack{
            ChessBack().offset(y:-135).edgesIgnoringSafeArea(.all)
            
            RulesCircleImageBig().offset(y: -220)
            VStack(alignment: .leading){
                Text("Règles du jeu").font(.title).foregroundColor(.primary)
                HStack{
                    Text("Principe du jeu d'échecs").font(.subheadline).foregroundColor(.secondary)
                }
                
                //Onboarding vocal triggers
                NavigationLink("MouvementView", destination: MouvementView(), isActive: $mouvement).hidden()
                
                NavigationLink("PlacementView", destination: PlacementView(), isActive: $placement).hidden()
                
                NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
            
                
            }.offset(y:-200)
            
            
            //Recording button section
            
            Text(text).font(.system(size: 25, weight: .bold, design: .default))
            SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{session in
                speechSynthesizer.stopSpeaking(at: .immediate)
                let systemSoundID: SystemSoundID = 1113
                AudioServicesPlaySystemSound(systemSoundID)
            }.onRecognizeLatest(update: $text).onStopRecording{session in
                let systemSoundID: SystemSoundID = 1114
                AudioServicesPlaySystemSound(systemSoundID)
                
            }
        }
    }
    
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
