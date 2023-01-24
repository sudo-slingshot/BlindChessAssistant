//
//  BeginGameView.swift
//  
//
//  Created by Yohann Le Clech on 24/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation

struct BeginGameView: View {
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var placement = false
    @State private var mouvement = false
    var body: some View {
        VStack(alignment: .center){
            CircleRobotImage()
            Text("En attente de connexion... 📡").font(.title).foregroundColor(.primary)
            HStack{
                Text("Assurez vous que votre plateau d'echecs soit allumé et détectable...").foregroundColor(.secondary).font(.subheadline)
            }
            
            //========================================
                        
                        
            //Vocal triggered navlinks
                        
                NavigationLink("Mouvement", destination: MouvementView(), isActive: $mouvement).hidden()
                        
                NavigationLink("Placement", destination: PlacementView(), isActive: $placement).hidden()
            
            
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
                
                if (text.contains("placement")){
                    placement = true
                }
                
                if (text.contains("mouvement")){
                    mouvement = true
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
