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
    let utterance = "Le placement des pièces sur le plateau fourni est le suivant. Placez votre reine sur la case se trouvant juste devant le trou sur le bord du plateau. Placez ensuite votre roi sur la case se trouvant juste devant la bosse sur le bord du plateau. De part et d'autre du roi et de la reine, placez vos fous. De part et d'autre des fous, placez vos cavaliers. Enfin, placez vos deux tours restantes de part et d'autre des cavalier"
    
    @State private var text = "Push To Speak"
    @State private var rules = false
    @State private var mouvement = false
    @State private var game = false
    
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
            }.offset(y: -230)
         
            
            
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
