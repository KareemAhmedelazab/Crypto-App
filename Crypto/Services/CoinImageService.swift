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
    private let fileManger = LocalFileManger.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    func getCoinImage() {
        if let savedImage = fileManger.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("get image from fileManger")
        } else {
            downlaodCoinImage()
            print("dwonloading images")
        }
    }
    
    private func downlaodCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManger.download(url: url)
            .tryMap({ data -> UIImage? in
                return  UIImage(data: data)
                
            })
            .sink(receiveCompletion: NetworkingManger.handleCompletion(completion:), receiveValue: { [weak self] returnedImage in
                guard let self = self, let downlaodedImage = returnedImage else { return }
                self.image = downlaodedImage
                self.imageSubscription?.cancel()
                self.fileManger.saveImage(image: downlaodedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}


