//
//  MarketDataModel.swift
//  Crypto
//
//  Created by Kareem on 26/08/2026.
//

import Foundation


// Coingecko Response
/*
 https://api.coingecko.com/api/v3/global
 
 Json Response:
 {
   "data": {
     "active_cryptocurrencies": 17397,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1476,
     "total_market_cap": {
       "btc": 34570737.199462704,
       "eth": 1259418635.423994,
       "usd": 2621040321355.0405
     },
     "total_volume": {
       "btc": 1254779.1727158197,
       "eth": 45711847.69194817,
       "usd": 95133256404.37308
     },
     "market_cap_percentage": {
       "btc": 57.9539332566265,
       "eth": 9.58227145398409,
       "usdt": 7.223241338072757
     },
     "market_cap_change_percentage_24h_usd": -1.6081983639177684,
     "volume_change_percentage_24h_usd": 33.064521460740046,
     "updated_at": 1779878351
   }
 }
 */

struct GlobelData: Codable {
    let data: MarketDataModel?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct MarketDataModel: Codable {
    let activeCryptocurrencies: Int?
    let upcomingIcos: Int?
    let ongoingIcos: Int?
    let endedIcos: Int?
    let markets: Int?
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let volumeChangePercentage24HUsd: Double?
    let updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets = "markets"
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case volumeChangePercentage24HUsd = "volume_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
            return key == "usd"
        }) {
            return "$" + item.value.formattedWithAbbreviations()
        } else {
            return ""
        }
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { (key, value) -> Bool in
            return key == "usd"
        }) {
            return "$" + item.value.formattedWithAbbreviations()
        } else {
            return ""
        }
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { (key, value) -> Bool in
            return key == "btc"
        }) {
            return item.value.asPercentString()
        } else {
            return ""
        }

    }
}
