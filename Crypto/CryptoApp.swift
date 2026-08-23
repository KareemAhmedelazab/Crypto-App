//
//  CryptoApp.swift
//  Crypto
//
//  Created by Kareem on 19/08/2026.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(vm)
        }
    }
}
