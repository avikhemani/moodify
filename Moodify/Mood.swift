//
//  MoodChoices.swift
//  Moodify
//
//  Created by Avi Khemani on 5/27/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import Foundation

enum Mood: CaseIterable, Hashable {
    case happy
    case sad
    case stressed
    case bored
    case angry
    case tired
    case excited
    case determined
    case apathetic
    
    var string: String {
        switch self {
        case .happy: return "Happy"
        case .sad: return "Sad"
        case .stressed: return "Stressed"
        case .bored: return "Bored"
        case .angry: return "Angry"
        case .tired: return "Tired"
        case .excited: return "Excited"
        case .determined: return "Determined"
        case .apathetic: return "Apathetic"
        }
    }
    
    var emoji: String {
        switch self {
        case .happy: return "😊"
        case .sad: return "🙁"
        case .stressed: return "😬"
        case .bored: return "😒"
        case .angry: return "😠"
        case .tired: return "😴"
        case .excited: return "😁"
        case .determined: return "😎"
        case .apathetic: return "😐"
        }
    }
}
