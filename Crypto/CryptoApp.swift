//
//  CryptoApp.swift
//  Crypto
//
//  Created by Kareem on 19/08/2026.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @State private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environment(vm)
        }
    }
}
