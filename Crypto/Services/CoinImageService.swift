//
//  CoinImageService.swift
//  Crypto
//
//  Created by Kareem on 22/08/2026.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManger.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManger.handleCompletion(completion:), receiveValue: { [weak self] returnedImage in
                                self?.image = returnedImage
                                self?.imageSubscription?.cancel()
                            })
    }
}

