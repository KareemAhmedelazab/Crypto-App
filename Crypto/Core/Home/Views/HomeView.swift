//
//  HomeView.swift
//  Crypto
//
//  Created by Kareem on 19/08/2026.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State private var showProtfolio: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                HomeHeader
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showProtfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showProtfolio {
                    protfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
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
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 8))
            }
        }
        .listStyle(.plain)
    }
    
    private var protfolioCoinsList: some View {
        List {
            ForEach(vm.protfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 8))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showProtfolio {
                Text("Holdings")
            }
            Text("Price")
                .containerRelativeFrame(.horizontal, alignment: .trailing) { x, _ in
                    x / 3
                }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
