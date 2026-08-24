//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Kareem on 21/08/2026.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var protfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
// old allCoins sink
/*        dataService.$allCoins
//            .sink { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
*/
        // updates allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
                guard !text.isEmpty else {
                return coins
            }
            let lowercasedText = text.lowercased()
            
            let filteredCoins = coins.filter { coin -> Bool in
              return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
            }
            return filteredCoins
    }
}
