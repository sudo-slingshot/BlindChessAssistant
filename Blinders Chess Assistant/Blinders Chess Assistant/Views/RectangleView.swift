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
    let utterance = AVSpeechUtterance(string: "Bonjour, je suis votre assistant virtuel. Je peux vous apprendre les règles des echecs, ainsi que le placement et le mouvement des pièces du jeu. Appuyez sur le bouton situé en bas de l'écran pour communiquer avec moi")
    
    
    //Text To Speech Function
    private func TTS(){
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "fr")
         
        speechSynthesizer.speak(utterance)
    }
    
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
                }.onAppear{
                    TTS()
                }.onDisappear{
                    speechSynthesizer.stopSpeaking(at: .immediate)
                }
                
                //Visual menu
                
                NavigationLink(destination: BeginGameView()){
                    RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.gray).overlay(Text("Commencer une partie").offset(x:25).foregroundColor(.primary)).overlay(CircleImage().offset(x: -130))
                }
                
                NavigationLink(destination: RulesChoice()){
                    RoundedRectangle(cornerRadius: 20).frame(height: 90).foregroundColor(.gray).overlay(Text("Consulter les règles").offset(x:25).foregroundColor(.primary)).overlay(RulesCircleImage().offset(x: -130))
                }
                
                //Onboarding vocal triggers
                NavigationLink("MouvementView", destination: MouvementView(), isActive: $mouvement).hidden()
                
                NavigationLink("PlacementView", destination: PlacementView(), isActive: $placement).hidden()
                
                NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
                
                NavigationLink("RulesView", destination: RulesView(), isActive: $rules).hidden()
                
                //Recording button section
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
                    
                    if (text.contains("mouvement")){
                        mouvement = true
                    }
                    if (text.contains("place")){
                        placement = true
                    }
                    
                    if (text.contains("partie")){
                        game = true
                    }
                    
                    if text.contains("Règles") || text.contains("règles"){
                        rules = true
                    }
                    
                    
                }
            }.offset(y:-10)
            
            
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
