//
//  DetailViewModel.swift
//  Crypto
//
//  Created by Kareem on 28/08/2026.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancebllables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
    
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { returnCoinDetail in
                print("recieved coin detail data")
                print(returnCoinDetail)
            }
            .store(in: &cancebllables)
            
    }
}
