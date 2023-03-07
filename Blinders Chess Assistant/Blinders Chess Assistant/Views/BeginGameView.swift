//
//  BeginGameView.swift
//  
//
//  Created by Yohann Le Clech on 24/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation
import CoreBluetooth

struct BeginGameView: View {
    let speechSynthesizer = AVSpeechSynthesizer()
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var placement = false
    @State private var mouvement = false
    @State private var choice = false
    @State private var connected = false
    
    
    //Text To Speech Function
    private func TTS(speech: String){
        let speech2 = AVSpeechUtterance(string: speech)
        speech2.pitchMultiplier = 1.0
        speech2.rate = 0.5
        speech2.voice = AVSpeechSynthesisVoice(language: "fr")
         
        speechSynthesizer.speak(speech2)
    }
    
    
    
    var body: some View {
        //ZStack is here to integrate a gradient background behind the navigation section
        ZStack{
            //Gradient background
            StaticGradientView()
            VStack(alignment: .center){
                HorseImage()
                Text("En attente de connexion... 📡").font(.title).foregroundColor(.primary).frame(maxHeight: .infinity, alignment: .top).onTapGesture {
                    connected = true
                }
                
                //========================================
                
                
                //Vocal triggered navlinks
                
                NavigationLink("Mouvement", destination: MouvementView(), isActive: $mouvement).hidden()
                
                NavigationLink("Placement", destination: PlacementView(), isActive: $placement).hidden()
                
                NavigationLink("RulesChoice", destination: RulesChoice(), isActive: $choice).hidden()
                
                NavigationLink("Connected", destination: ConnectedView(), isActive: $connected).hidden()
                
                
                //========================================
                
                
                //Recording button section
                VStack{
                    Text(text).font(.system(size: 25, weight: .bold, design: .default))
                    SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{session in
                        //Load response sound
                        let systemSoundID: SystemSoundID = 1113
                        //Play audio response
                        AudioServicesPlaySystemSound(systemSoundID)
                    }.onRecognizeLatest(update: $text).onStopRecording{session in
                        //Load sound response
                        let systemSoundID: SystemSoundID = 1114
                        //Play sound response
                        AudioServicesPlaySystemSound(systemSoundID)
                        
                        //processing vocal speech to text treatment for view changes
                        
                        if (text.contains("placement")||text.contains("Placement")){
                            placement = true
                        }
                        
                        if (text.contains("mouvement")||text.contains("Mouvement")){
                            mouvement = true
                        }
                        
                        if text.contains("Règles") || text.contains("règles")||text.contains("principe")||text.contains("Principe"){
                            rules = true
                        }
                    }
                }.frame(maxHeight: .infinity, alignment: .bottom).onAppear{
                    //Configuring speech that will be played while going to the view
                    let connectionspeech = "Nous recherchons actuellement votre plateau d'échecs. Assurez vous que votre plateau soit allumé et détectable, et que le bluetooth de votre téléphone soit actif."
                    
                    TTS(speech: connectionspeech)
                    
                }.onDisappear{
                    speechSynthesizer.stopSpeaking(at: .immediate)
                }
            }
        }
    }
}

struct BeginGameView_Previews: PreviewProvider {
    static var previews: some View {
        BeginGameView()
    }
}
