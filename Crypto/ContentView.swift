//
//  ContentView.swift
//  Crypto
//
//  Created by Kareem on 19/08/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                Text("hello there")
                    .foregroundStyle(Color.theme.accent)
                
                Text("hi maaaaannnnn")
                    .foregroundStyle(Color.theme.secondaryText)
                
                Text("hahahahahaa")
                    .foregroundStyle(Color.theme.green)
            }
        }
    }
}

#Preview {
    ContentView()
}
