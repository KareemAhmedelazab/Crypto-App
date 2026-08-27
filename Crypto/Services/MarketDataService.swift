//
//  MarketDataService.swift
//  Crypto
//
//  Created by Kareem on 26/08/2026.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
     func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketSubscription = NetworkingManger.download(url: url)
            .decode(type: GlobelData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion(completion:), receiveValue: { [weak self] returnedGlobelData in
                self?.marketData = returnedGlobelData.data
                self?.marketSubscription?.cancel()
            })
        
    }
}
