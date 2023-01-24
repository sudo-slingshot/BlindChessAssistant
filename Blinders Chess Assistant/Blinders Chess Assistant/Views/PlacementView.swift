//
//  PlacementView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation

struct PlacementView: View {
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var mouvement = false
    @State private var game = false
    var body: some View {
        VStack{
            ChessBack().offset(y:-135).edgesIgnoringSafeArea(.all)
            
            CirclePlacementImageBig().offset(y: -220)
            VStack(alignment: .leading){
                Text("Placement des pièces").font(.title).foregroundColor(.primary)
                HStack{
                    Text("Toutes les règles de placement").font(.subheadline).foregroundColor(.secondary)
                }
            }.offset(y: -230)
         
            
            
//========================================
            
            
            //Vocal triggered navlinks
            
            NavigationLink("PlacementView", destination: MouvementView(), isActive: $mouvement).hidden()
            
            NavigationLink("GameView", destination: BeginGameView(), isActive: $game).hidden()
            
            
            
            
//========================================


            
            //Recording button section
            
            Text(text).font(.system(size: 25, weight: .bold, design: .default))
            SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{session in
                let systemSoundID: SystemSoundID = 1113
                AudioServicesPlaySystemSound(systemSoundID)
            }.onRecognizeLatest(update: $text).onStopRecording{session in
                let systemSoundID: SystemSoundID = 1114
                AudioServicesPlaySystemSound(systemSoundID)
                
                //processing vocal speech to text treatment for view changes
                
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
