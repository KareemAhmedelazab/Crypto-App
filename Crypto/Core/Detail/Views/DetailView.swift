//
//  DetailView.swift
//  Crypto
//
//  Created by Kareem on 28/08/2026.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}
struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("init Detail for \(coin.name)")
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                Text("")
                    .frame(height: 150)
                overviewTitle
                Divider()
                overviewGrid
                
                additionalTitle
                Divider()
                additionalGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}

extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var overviewGrid: some View {
        
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: nil,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var additionalGrid: some View {
        
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: nil,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
}
