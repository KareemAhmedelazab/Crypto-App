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
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]

    }
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                NavigationStack {
                    HomeView()
                }
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        launchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
            
            
        }
    }
}
