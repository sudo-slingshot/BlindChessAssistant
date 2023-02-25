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
    let utterance = "Nous allons commencer a placer les pièces ensemble. Lorsque vous êtes prêt a placer vos pièces, appuyez sur le bouton et dites : continuez"
    @State private var placingspeech = ""
    
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var mouvement = false
    @State private var game = false
    @State private var placingstage = 0
    
    //Text To Speech Function
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
            
            CirclePlacementImageBig().offset(y: -220)
            VStack(alignment: .leading){
                Text("Placement des pièces").font(.title).foregroundColor(.primary)
                HStack{
                    Text("Toutes les règles de placement").font(.subheadline).foregroundColor(.secondary)
                }.onAppear{
                    TTS(speech: utterance)
                }
            }.offset(y: -230).onDisappear{
                speechSynthesizer.stopSpeaking(at: .immediate)
            }
         
            
            
//========================================
            
            
            //Vocal triggered navlinks
            
            NavigationLink("PlacementView", destination: MouvementView(), isActive: $mouvement).hidden()
            
            NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
            
            
            
            
//========================================


            
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
                
                //processing request to move on in the chess pieces placing process
                if (text.contains("continu") || text.contains("Continu")){
                    placingstage = placingstage + 1
                    if (placingstage == 1){
                        placingspeech = "Pour commencer, positionnons le plateau d'échecs. Sur certains bords se trouvent un trou et une bosse côte a côte. Positionnez l'un de ces deux bords devant vous. . . . . Voulez vous que je répète ou que l'on recommence le placement des pièces du début ?"
                    }
                    
                    if (placingstage == 2){
                        placingspeech = "Placez le roi sur la case située devant la bosse se trouvant sur le bord du plateau"
                    }
                    
                    if (placingstage == 3){
                        placingspeech = "Placez la reine sur la case située devant le trou se trouvant sur le bord du plateau"
                    }
                    
                    if (placingstage == 4){
                        placingspeech="Placez vos fous sur les cases a côté du roi et de la reine."
                    }
                    
                    if (placingstage == 5){
                        placingspeech="Placez vos cavaliers sur les cases libres a côté de vos fous"
                    }
                    
                    if (placingstage==6){
                        placingspeech="Placez vos tours sur les cases libres a côté de vos cavaliers. Si votre placement est correct, les tours se trouvent sur les cases en bord de plateau"
                    }
                    
                    if (placingstage == 7){
                        placingspeech = "Placez vos pions devant chaque pièce que vous venez de placer jusqu'alors."
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
    }
}

struct PlacementView_Previews: PreviewProvider {
    static var previews: some View {
        PlacementView()
    }
}
