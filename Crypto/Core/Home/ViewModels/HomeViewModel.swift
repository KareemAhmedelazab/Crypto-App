//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Kareem on 21/08/2026.
//

import Foundation

@Observable
class HomeViewModel {
    
    var allCoins: [CoinModel] = []
    var protfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.protfolioCoins.append(DeveloperPreview.instance.coin)

        }
    }
}
