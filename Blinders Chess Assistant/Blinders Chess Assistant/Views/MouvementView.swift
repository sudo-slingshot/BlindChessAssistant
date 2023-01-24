//
//  MouvementView.swift
//  Blinders Chess Assistant
//
//  Created by Yohann Le Clech on 21/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation

struct MouvementView: View {
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var placement = false
    @State private var game = false
    var body: some View {
        VStack{
            ChessBack().offset(y:-135).edgesIgnoringSafeArea(.all)
            
            CircleImageMouvementBig().offset(y: -220)
            VStack(alignment: .leading){
                Text("Mouvement des pièces").font(.title).foregroundColor(.primary)
                HStack{
                    Text("Tous les mouvements des pièces d'échecs").font(.subheadline).foregroundColor(.secondary)
                }
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
            }
        }
    }
}

struct MouvementView_Previews: PreviewProvider {
    static var previews: some View {
        MouvementView()
    }
}
