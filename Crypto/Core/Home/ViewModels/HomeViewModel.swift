//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Kareem on 21/08/2026.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfilioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins,$sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updatesPorfolioCoins
        $allCoins
            .combineLatest(portfilioDataService.$savedEntities)
            .map(mapAllCoinToPortfolioCoin)
            .sink { [weak self] returnedCoins in
                guard let self else { return }
                self.portfolioCoins = self.sortHoldingsCoin(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapClobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePorfolio(coin: CoinModel, amount: Double) {
        portfilioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManger.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel],sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        
        return updatedCoins
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
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank:
                coins.sort { coin1, coin2 in
                    let rank1 = coin1.rank == 0 ? Int.max : coin1.rank
                    let rank2 = coin2.rank == 0 ? Int.max : coin2.rank
                    return rank1 < rank2
                }
            case .rankReversed:
                coins.sort { coin1, coin2 in
                    let rank1 = coin1.rank == 0 ? Int.min : coin1.rank
                    let rank2 = coin2.rank == 0 ? Int.min : coin2.rank
                    return rank1 > rank2
                }
        case .holdings, .holdingsReversed:
                 break
        case .price:
             coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
             coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortHoldingsCoin(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingValue > $1.currentHoldingValue})
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingValue < $1.currentHoldingValue})
        default:
            return coins
        }
    }
    
    private func mapAllCoinToPortfolioCoin(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { portfolio in
                    portfolio.coinID == coin.id
                }) else { return nil }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapClobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let bitcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins.map { coin in
            return coin.currentHoldingValue
                
        }
            .reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(),percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap,volume,bitcDominance,portfolio])
        
        return stats
    }
}
