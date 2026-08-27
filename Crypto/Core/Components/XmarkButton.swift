//
//  XmarkButton.swift
//  Crypto
//
//  Created by Kareem on 27/08/2026.
//

import SwiftUI

struct XmarkButton: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })    }
}

#Preview {
    XmarkButton()
}
