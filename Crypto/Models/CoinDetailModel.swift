//
//  CoinDetailModel.swift
//  Crypto
//
//  Created by Kareem on 28/08/2026.

// json data
/*
 https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
 
 */

import Foundation

// MARK: - Welcome
struct CoinDetailModel: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let webSlug: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let previewListing: Bool?
    let hasSupplyBreakdown: Bool?
    let description: Description?
    let links: Links?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case webSlug = "web_slug"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories = "categories"
        case previewListing = "preview_listing"
        case hasSupplyBreakdown = "has_supply_breakdown"
        case description = "description"
        case links = "links"
    }
}

// MARK: - Description
struct Description: Codable {
    let en: String?

    enum CodingKeys: String, CodingKey {
        case en = "en"
    }
}

// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let whitepaper: String?
    let blockchainSite: [String]?
    let officialForumURL: [String]?
    let chatURL: [String]?
    let announcementURL: [String]?
    let twitterScreenName: String?
    let facebookUsername: String?
    let telegramChannelIdentifier: String?
    let subredditURL: String?
    

    enum CodingKeys: String, CodingKey {
        case homepage = "homepage"
        case whitepaper = "whitepaper"
        case blockchainSite = "blockchain_site"
        case officialForumURL = "official_forum_url"
        case chatURL = "chat_url"
        case announcementURL = "announcement_url"
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditURL = "subreddit_url"
        
    }
}

// MARK: - AthDateClass
struct AthDateClass: Codable {
    let btc: String?
    let eur: String?
    let usd: String?

    enum CodingKeys: String, CodingKey {
        case btc = "btc"
        case eur = "eur"
        case usd = "usd"
    }
}
