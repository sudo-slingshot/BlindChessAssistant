//
//  MouvementView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation
import AVFAudio

struct MouvementView: View {
    let speechSynthesizer = AVSpeechSynthesizer()
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var placement = false
    @State private var game = false
    let utterance = "de quelle pièce souhaitez vous connaitre le mouvement?"
    //Text to speech function
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
            
            CircleImageMouvementBig().offset(y: -220)
            VStack(alignment: .leading){
                Text("Mouvement des pièces").font(.title).foregroundColor(.primary)
                HStack{
                    Text("Tous les mouvements des pièces d'échecs").font(.subheadline).foregroundColor(.secondary)
                }.onAppear{TTS(speech: utterance)}
            }.offset(y: -230)
            
            //Vocal triggered navlinks
            
            NavigationLink("PlacementView", destination: PlacementView(), isActive: $placement).hidden()
            
            NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
          
            
            
//=======================================
            
            
            
            //Recording button section
            
            Text(text).font(.system(size: 25, weight: .bold, design: .default))
            SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{session in
                let systemSoundID: SystemSoundID = 1113
                AudioServicesPlaySystemSound(systemSoundID)
            }.onRecognizeLatest(update: $text).onStopRecording{session in
                let systemSoundID: SystemSoundID = 1114
                AudioServicesPlaySystemSound(systemSoundID)
                
                //processing vocal speech to text treatment for view changes
                
                if (text.contains("placement")){
                    placement = true
                }
                
                if (text.contains("partie")){
                    game = true
                }
                
                //gestion du mouvement des pièces
                if text.contains("Pion") || text.contains ("pion"){
                    let pionspeech = "le pion peut bouger uniquement d'une case vers l'avant. Si le pion se trouve sur sa case de départ il peu bouger de deux cases vers l'avant. Il ne peut prendre les pièces adverses que si cette dernière se situe a une case de distance en diagonale"
                    TTS(speech: pionspeech)
                }
                
                //TODO : Autres mouvements
            }
        }
    }
}

struct MouvementView_Previews: PreviewProvider {
    static var previews: some View {
        MouvementView()
    }
}
