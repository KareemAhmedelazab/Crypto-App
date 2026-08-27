//
//  HapticManger.swift
//  Crypto
//
//  Created by Kareem on 27/08/2026.
//

import Foundation
import SwiftUI


class HapticManger {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
