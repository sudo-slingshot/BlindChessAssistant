//
//  SpeechRecognitionView.swift
//  TEST VIEW FOR UPCOMING IMPLEMENTATION
//
//  Created by Yohann Le Clech on 22/01/2023.
//

import SwiftUI
import SwiftSpeech
import AVFoundation

struct SpeechRecognitionView: View {
    //Auto update text while audio recongition is active
    @State private var text = "Push To Speak"
    var body: some View {
        VStack(spacing: 35.0){
            Text(text).font(.system(size: 25, weight: .bold, design: .default))
            SwiftSpeech.RecordButton().swiftSpeechRecordOnHold().onStartRecording{session in
                let systemSoundID: SystemSoundID = 1113
                AudioServicesPlaySystemSound(systemSoundID)
            }.onRecognizeLatest(update: $text).onStopRecording{session in
                let systemSoundID: SystemSoundID = 1114
                AudioServicesPlaySystemSound(systemSoundID)
                let rules = text.contains("règles")
                print(rules)
                if (rules == true){
                   
                }
            }
        }.onAppear{
            SwiftSpeech.requestSpeechRecognitionAuthorization()
            do{
                
            }
        }
    }
}

struct SpeechRecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechRecognitionView()
    }
}
