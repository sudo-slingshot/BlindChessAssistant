//
//  Funcs.swift
//  
//
//  Created by Yohann Le Clech on 27/01/2023.
//

import Foundation
import AVFAudio
import AVFoundation


class ViewModel: ObservableObject{
    func TextToSpeech(speech: String){
        let speechSynthesizer = AVSpeechSynthesizer()
        let speech2 = AVSpeechUtterance(string: speech)
        speech2.pitchMultiplier = 1.0
        speech2.rate = 0.5
        speech2.voice = AVSpeechSynthesisVoice(language: "fr")
        
        speechSynthesizer.speak(speech2)
    }
}
