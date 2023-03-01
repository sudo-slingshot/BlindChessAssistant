//
//  RectangleView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation
import AVFAudio

struct RectangleView: View {
    
    //Variables for vocal triggers
    let speechSynthesizer = AVSpeechSynthesizer()
    @State private var text = "Push To Speak"
    @State private var mouvement = false
    @State private var placement = false
    @State private var game = false
    @State private var rules =  false
    
    
    //String TTS
    @State private var utterance = "Bonjour, je suis votre assistant virtuel. Pour en savoir plus sur mon utilisation, appuyez sur le bouton situé en bas de l'écran et dites : Présente toi"
    
    
    //Text To Speech Function
    private func TTS(speech: String){
        let speech2 = AVSpeechUtterance(string: speech)
        speech2.pitchMultiplier = 1.0
        speech2.rate = 0.5
        speech2.voice = AVSpeechSynthesisVoice(language: "fr")
         
        speechSynthesizer.speak(speech2)
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                GradientView()
                VStack(alignment: .center){
                    //Header display, for robot head & greeting message
                    
                    VStack(alignment: .center){
                        HorseImage()
                        Text("Bonjour 👋🏻").font(.title).foregroundColor(.primary)
                        HStack{
                            Text("Je suis votre assistant virtuel pour vous apprendre a jouer aux échecs").foregroundColor(.secondary).font(.subheadline)
                        }
                        
                        //Visual menu
                        NavigationLink(destination: BeginGameView()){
                            RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.clear).overlay(Text("Commencer une partie").offset(x:25).foregroundColor(.primary)).overlay(CircleImage().offset(x: -130))
                        }.offset(y:10)
                        
                        NavigationLink(destination: RulesChoice()){
                            RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.clear).overlay(Text("Consulter les règles").offset(x:25).foregroundColor(.primary)).overlay(RulesCircleImage().offset(x: -130))
                        }.offset(y:10)
                        
                        //Onboarding vocal triggers
                        NavigationLink("MouvementView", destination: MouvementView(), isActive: $mouvement).hidden()
                        
                        NavigationLink("PlacementView", destination: PlacementView(), isActive: $placement).hidden()
                        
                        NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
                        
                        NavigationLink("RulesView", destination: RulesView(), isActive: $rules).hidden()
                        
                    }.frame(maxHeight: .infinity, alignment: .top).offset(y:10).onAppear{
                        TTS(speech: utterance)
                    }.onDisappear{
                        speechSynthesizer.stopSpeaking(at: .immediate)
                    }
                    
                    //Recording button section
                    VStack{
                        Text(text).font(.system(size: 25, weight: .bold, design: .default)).offset(y:-20)
                        SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{
                            session in
                            speechSynthesizer.stopSpeaking(at: .immediate)
                            let systemSoundID: SystemSoundID = 1113
                            AudioServicesPlaySystemSound(systemSoundID)
                        }.onRecognizeLatest(update: $text).onStopRecording{session in
                            let systemSoundID: SystemSoundID = 1114
                            AudioServicesPlaySystemSound(systemSoundID)
                            
                            //processing vocal speech to text treatment for view changes
                            
                            if (text.contains("Présent")||text.contains("présent")){
                                utterance = "Je peux vous apprendre les règles de base des échecs, ainsi que le placement des pièces du jeu, et les mouvements des pièces. Que souhaitez vous faire?"
                                
                                TTS(speech: utterance)
                            }
                            
                            if (text.contains("mouve")||text.contains("Mouve")){
                                mouvement = true
                            }
                            if (text.contains("place")||text.contains("Place")){
                                placement = true
                            }
                            
                            if (text.contains("partie")||text.contains("Partie")){
                                game = true
                            }
                            
                            if text.contains("Règles") || text.contains("règles"){
                                rules = true
                            }
                            
                            
                        }
                    }.offset(y:-10)
                    
                    
                }.frame(maxHeight: .infinity, alignment: .bottom).onAppear{
                    SwiftSpeech.requestSpeechRecognitionAuthorization()
                }
            }
        }
    }
}
    
    struct RectangleView_Previews: PreviewProvider {
        static var previews: some View {
            RectangleView()
        }
    }
