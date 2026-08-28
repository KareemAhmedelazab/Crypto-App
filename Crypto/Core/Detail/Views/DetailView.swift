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
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("init Detail for \(coin.name)")
    }
    
    var body: some View {
        Text("coin.name")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
