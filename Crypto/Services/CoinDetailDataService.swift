//
//  CoinDetailDataService.swift
//  Crypto
//
//  Created by Kareem on 28/08/2026.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinsDetails()
    }
    
    func getCoinsDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManger.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion(completion:), receiveValue: { [weak self] returnedCoinsDetails in
                self?.coinDetails = returnedCoinsDetails
                self?.coinDetailSubscription?.cancel()
            })
        
    }
}
