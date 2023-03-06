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
    @State private var principlesstage = 0
    @State private var utterance = ""
    
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
                Text("Principe du jeu").font(.title).foregroundColor(.primary).frame(maxHeight: .infinity, alignment: .top)
                VStack{
                    
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
                        
                        //Continue case
                        if (text.contains("Continu")||text.contains("continu")){
                            principlesstage=principlesstage + 1
                            if(principlesstage==1){
                                 utterance = "Chaque joueur possède au départ un roi, une dame, deux tours, deux fous, deux cavaliers et huit pions."
                                TTS(speech: utterance)
                            }
                            
                            if(principlesstage==2){
                                 utterance = "Le joueur ayant les pièces blanches joue en premier, puis les joueurs jouent chacun leur tour."
                                TTS(speech: utterance)
                            }
                            
                            if (principlesstage==3){
                                utterance = "Le but du jeu d'échecs est de mettre le roi adverse en échec et mat. L'expression échec et mat signifie que le roi est menacé de capture et qu'il n'y a aucun moyen de le sauver, ce qui signifie la fin de la partie."
                                TTS(speech: utterance)
                            }
                            
                            if (principlesstage >= 4){
                                utterance = "Nous avons terminé d'énoncer les principes du jeu d'échec. Si vous souhaitez les réentendre, appuyez sur le bouton et dites : recommencer."
                                TTS(speech: utterance)
                            }
                            
                        }
                        //Start over case
                        if (text.contains("Recommen")||text.contains("recommen")){
                            principlesstage = 0
                            utterance = "Nous allons aborder ensemble les principes du jeu d'échecs. Lorsque vous êtes prêt a les entendre, appuyez sur le bouton et dites : continuez. A tout moment, si vous souhaitez que je répète ce que je viens d'énoncer, appuyez sur le bouton et dites: répète"
                            TTS(speech: utterance)
                        }
                        
                        if (text.contains("Répèt")||text.contains("répèt")){
                            TTS(speech: utterance)
                        }
                        
                    }
                }.frame(maxHeight: .infinity, alignment: .bottom).onAppear{
                    utterance = "Nous allons aborder ensemble les principes du jeu d'échecs. Lorsque vous êtes prêt a les entendre, appuyez sur le bouton et dites : continuez. A tout moment, si vous souhaitez que je répète ce que je viens d'énoncer, appuyez sur le bouton et dites: répète"
                    TTS(speech: utterance)
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
