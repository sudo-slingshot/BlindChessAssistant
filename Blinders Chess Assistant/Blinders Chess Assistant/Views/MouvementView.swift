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
                speechSynthesizer.stopSpeaking(at: .immediate)
                let systemSoundID: SystemSoundID = 1113
                AudioServicesPlaySystemSound(systemSoundID)
            }.onRecognizeLatest(update: $text).onStopRecording{session in
                let systemSoundID: SystemSoundID = 1114
                AudioServicesPlaySystemSound(systemSoundID)
                
                //processing vocal speech to text treatment for view changes
                
                if (text.contains("place")){
                    placement = true
                }
                
                if (text.contains("partie")){
                    game = true
                }
                
                //gestion du mouvement des pièces
                if text.contains("Pion") || text.contains ("pion"){
                    let pionspeech = "Le pion se déplace droit devant lui, d'une seule case à chaque coup et sans jamais pouvoir reculer. Lors de son premier déplacement (alors qu'il est sur sa case initiale), un pion peut avancer, au choix, d'une ou de deux cases en un seul coup. Dans les deux cas, la case d'arrivée doit être libre de toute pièce amie ou ennemie ; si le pion se déplace de deux cases, aucune pièce ne doit être sur son chemin."
                    TTS(speech: pionspeech)
                }
                
                if text.contains("Tour")||text.contains("tour"){
                    let tourspeech="La Tour se déplace horizontalement ou verticalement, d’autant de cases qu’elle veut. La Tour ne peut pas aller sur une case occupée par une pièce de son camp, ni sauter au-dessus d’une autre pièce."
                    TTS(speech: tourspeech)
                }
                
                
                if text.contains("Reine")||text.contains("reine")||text.contains("Dame")||text.contains("dame"){
                    let reinespeech="La Dame se déplace comme la Tour et le Fou: elle peut donc se déplacer verticalement, horizontalement et en diagonale, d’autant de cases qu’elle veut (sans bien sûr pouvoir passer au-dessus d’une autre pièce ou pouvoir prendre une pièce de son propre camp). Comme c’est la pièce la plus mobile, c’est aussi la pièce qui a la plus grande valeur."
                    TTS(speech: reinespeech)
                }
                
                if text.contains("roi")||text.contains("Roi"){
                    let roispeech="Le Roi se déplace d’une seule case, dans toutes les directions. Lorsqu’un Roi est attaqué par une pièce adverse, on dit qu’il est en échec. Un joueur n’a pas le droit de laisser son Roi en échec. Il n’a pas non plus le droit de déplacer son Roi sur une case où celui-ci sera attaqué (donc en échec)."
                    TTS(speech: roispeech)
                }
                
                if text.contains("Fou")||text.contains("fou"){
                    let fouspeech="Le Fou se déplace en diagonale, d’autant de cases qu’il veut."
                    TTS(speech: fouspeech)
                }
                
                if text.contains("Cavalier")||text.contains("cavalier")||text.contains("cheval")||text.contains("Cheval"){
                    let chevalspeech="le Cavalier se déplace de deux cases horizontalement ou verticalement, puis fait un pas sur le côté. Il effectue donc une sorte de « L » majuscule, tourné dans n’importe quel sens. Le Cavalier est la seule pièce qui peut sauter au-dessus des autres pièces (les siennes et celles de l’adversaire)"
                    TTS(speech: chevalspeech)
                }
            }
        }
    }
}

struct MouvementView_Previews: PreviewProvider {
    static var previews: some View {
        MouvementView()
    }
}
