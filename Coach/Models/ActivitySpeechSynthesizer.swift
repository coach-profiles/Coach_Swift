//
//  ActivitySpeechSynthesizer.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/20/22.
//

import Foundation
import AVFoundation


class ActivitySpeechSynthesizer: NSObject, AVSpeechSynthesizerDelegate {
    let synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    @objc func notify(notification text: String?) {
        guard let notification = text else {
            return
        }
        guard !notification.isEmpty else {
            return
        }
        
        let utterance = AVSpeechUtterance(string: notification)
        utterance.preUtteranceDelay = 0.0
        utterance.postUtteranceDelay = 0.0
        synthesizer.speak(utterance)
    }
}
