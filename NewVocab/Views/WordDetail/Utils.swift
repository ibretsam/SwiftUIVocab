//
//  Utils.swift
//  NewVocab
//
//  Created by MasterBi on 21/9/24.
//

import SwiftUI
import AVFoundation

func getTitleOpacity(offset: CGFloat) -> CGFloat {
    let titleOffset = -getTitleOffset(offset: offset)
    
    let progress = titleOffset / 5
    
    let opacity = 1 - progress
    
    return opacity
}

func getTitleOffset(offset: CGFloat) -> CGFloat {
    if (offset < 0) {
        let progress = -offset / 90
        let newOffset = (progress <= 1.0 ? progress : 1) * 20
        
        return -newOffset
    }
    return 0
}

func speakWord(wordText: String, synthesizer: AVSpeechSynthesizer) {
    if synthesizer.isSpeaking {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    let utterance = AVSpeechUtterance(string: wordText)
    utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Amelie-compact")
    utterance.rate = 0.5
    utterance.pitchMultiplier = 1.0
    utterance.volume = 1.0
    synthesizer.speak(utterance)
}

struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
