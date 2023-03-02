//
//  PlacementView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation
import AVFAudio

struct PlacementView: View {
    let speechSynthesizer = AVSpeechSynthesizer()
    let utterance = "Nous allons commencer a placer les pièces ensemble. Lorsque vous êtes prêt a placer vos pièces, appuyez sur le bouton et dites : continuez. A tout moment, si vous souhaitez que je répète ce que je viens d'énoncer, appuyez sur le bouton et dites: répète"
    @State private var placingspeech = ""
    
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var mouvement = false
    @State private var game = false
    @State private var placingstage = 0
    @State private var placingorder = 0
    
    //Text To Speech Function
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
                
                CirclePlacementImageBig().frame(maxHeight: .infinity, alignment: .top)
                VStack(alignment: .leading){
                    Text("Placement des pièces").font(.title).foregroundColor(.primary).frame(maxHeight: .infinity, alignment: .top).offset(y: 30)
                }.onAppear{
                    TTS(speech: utterance)
                }.offset(y: -150).onDisappear{
                    speechSynthesizer.stopSpeaking(at: .immediate)
                }
                
                
                
                //========================================
                
                
                //Vocal triggered navlinks
                
                NavigationLink("PlacementView", destination: MouvementView(), isActive: $mouvement).hidden()
                
                NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
                
                
                
                
                //========================================
                
                
                
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
                        
                        //processing request to move on in the chess pieces placing process
                        if (text.contains("continu") || text.contains("Continu")){
                            placingstage = placingstage + 1
                            if (placingstage == 1){
                                placingspeech = "Pour commencer, positionnons le plateau d'échecs. Sur le coin inférieur gauche du plateau d'échecs se trouve un petit trou. Trouvez ce coin et positionnez le devant vous, sur votre gauche"
                            }
                            //placing white pieces before placing the black ones
                            if (placingstage == 2 && placingorder==0){
                                placingspeech = "Commençons par placer les pièces blanches. Placez vos 8 pions en ligne droite le long de la deuxième rangée."
                            }
                            
                            //placing black pieces
                            if (placingstage == 2 && placingorder==1){
                                placingspeech = "Plaçons maintenant les pièces noires. Placez vos pions sur la deuxième rangée."
                            }
                            
                            if (placingstage == 3){
                                placingspeech = "Placez vos tours dans les coins de l'échiquier"
                            }
                            
                            if (placingstage == 4){
                                placingspeech=" Placez vos cavaliers a côté de vos tours"
                            }
                            
                            if (placingstage == 5){
                                placingspeech="Placez vos fous a côté de vos cavaliers"
                            }
                            
                            if (placingstage==6){
                                placingspeech="Placez votre reine sur la case situé devant le petit trou présent sur le bord de l'échiquier"
                            }
                            
                            if (placingstage == 7){
                                placingspeech = "Placez votre roi sur la case vide restante"
                                
                                if (placingorder==0){
                                    placingstage=1
                                    placingorder=placingorder+1
                                }
                            }
                            
                            if (placingstage >= 8){
                                placingspeech="Nous avons terminé de placer vos pièces. Si vous souhaitez recommencer le placement de vos pièces, appuyez sur le bouton et dites : recommencer"
                            }
                            
                            TTS(speech: placingspeech)
                        }
                        
                        //processing the "repeat" request
                        if (text.contains("Répète")||text.contains("répèt")){
                            TTS(speech: placingspeech)
                        }
                        
                        //processing the "begin again" request
                        if (text.contains("Recommence")||text.contains("recommence")){
                            placingstage = 0
                            TTS(speech: utterance)
                        }
                        
                        if (text.contains("mouvement")){
                            mouvement = true
                        }
                        
                        if (text.contains("partie")){
                            game = true
                        }
                    }
                }
            }.frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

struct PlacementView_Previews: PreviewProvider {
    static var previews: some View {
        PlacementView()
    }
}
