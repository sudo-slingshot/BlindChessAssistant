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
    let utterance = "De quelle pièce souhaitez vous connaitre le mouvement?"
    //Text to speech function
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
                
                CircleImageMouvementBig().frame(maxHeight: .infinity, alignment: .top)
                VStack{
                    Text("Mouvement des pièces").font(.title).foregroundColor(.primary)
                }.frame(maxHeight: .infinity, alignment: .top).offset(y:-70)
                //Vocal triggered navlinks
                
                NavigationLink("PlacementView", destination: PlacementView(), isActive: $placement).hidden()
                
                NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
                
                NavigationLink("RulesView", destination: RulesView(), isActive: $rules).hidden()
                
                
                
                //=======================================
                
                
                
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
                        
                        //processing vocal speech to text treatment for view changes
                        
                        if text.contains("Règles") || text.contains("règles")||text.contains("principe")||text.contains("Principe"){
                            rules = true
                        }
                        
                        if (text.contains("place")){
                            placement = true
                        }
                        
                        if (text.contains("partie")){
                            game = true
                        }
                        
                        //gestion du mouvement des pièces
                        if text.contains("Pion") || text.contains ("pion"){
                            let pionspeech = "Le Pion avance tout droit si la case devant lui est vide. Chaque pion peut se déplacer d'une ou deux cases lors de son premier coup, puis avance d'une seule case par la suite. l capture les pièces adverses en diagonale, mais ne peut pas capturer le roi adverse. Le pion est également la seule pièce qui ne peut pas reculer."
                            TTS(speech: pionspeech)
                        }
                        
                        if text.contains("Tour")||text.contains("tour"){
                            let tourspeech="La Tour se déplace en ligne droite horizontalement ou verticalement et capture les pièces adverses qui se trouvent sur sa trajectoire et s’y positionne."
                            TTS(speech: tourspeech)
                        }
                        
                        
                        if text.contains("Reine")||text.contains("reine")||text.contains("Dame")||text.contains("dame"){
                            let reinespeech="La Dame est la pièce la plus puissante du jeu. Elle peut se déplacer dans toutes les directions sur le plateau d'échecs et capture les pièces adverses qui se trouvent sur sa trajectoire et s’y positionne."
                            TTS(speech: reinespeech)
                        }
                        
                        if text.contains("roi")||text.contains("Roi"){
                            let roispeech=" Le Roi se déplace d'une seule case dans toutes les directions et capture les pièces adverses qui se trouvent sur sa trajectoire et s’y positionne. Le roi n'a pas le droit de se mettre en position d'échec, c'est-à-dire dans une situation où il peut être capturé au tour suivant par une pièce adverse."
                            TTS(speech: roispeech)
                        }
                        
                        if text.contains("Fou")||text.contains("fou"){
                            let fouspeech="Le Fou se déplace sur sa diagonale d'autant de cases qu'il le souhaite et capture les pièces adverses qui se trouvent sur sa trajectoire et s’y positionne."
                            TTS(speech: fouspeech)
                        }
                        
                        if text.contains("Cavalier")||text.contains("cavalier")||text.contains("cheval")||text.contains("Cheval"){
                            let chevalspeech="Le Cavalier est la seule pièce qui peut sauter par-dessus une autre pièce. Il se déplace en formant un L, c'est-à-dire deux cases dans une direction puis une case sur le côté. Si sa case d’arrivée est occupée par une pièce adverse, il la capture et s'y positionne."
                            TTS(speech: chevalspeech)
                        }
                    }.onAppear{TTS(speech: utterance)}.onDisappear{
                        speechSynthesizer.stopSpeaking(at: .immediate)
                    }
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
