//
//  HomeView.swift
//  Crypto
//
//  Created by Kareem on 19/08/2026.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showProtfolio: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                HomeHeader
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

extension HomeView {
    
    private var HomeHeader: some View {
        HStack {
            CircleButtonView(iconName: showProtfolio ? "plus" : "info")
                .animation(.none, value: showProtfolio)
                .background {
                    CircleButtonAnimationView(animate: $showProtfolio)
                }
            Spacer()
            Text(showProtfolio ? "ProtFolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showProtfolio)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProtfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showProtfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
