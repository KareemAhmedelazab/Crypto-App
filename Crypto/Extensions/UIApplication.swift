//
//  UIApplication.swift
//  Crypto
//
//  Created by Kareem on 24/08/2026.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
