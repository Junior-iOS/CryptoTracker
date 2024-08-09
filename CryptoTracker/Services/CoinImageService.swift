//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by NJ Development on 31/05/24.
//

import Combine
import Foundation
import SwiftUI

final class CoinImageService {
    @Published var image: UIImage?

    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_images"
    private let imageName: String

    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }

    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrived image from File Manager")
        } else {
            downloadCoinImage()
            print("Downloading image")
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }

        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ data -> UIImage in
                guard let image = UIImage(data: data) else { return UIImage() }
                return image
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] image in
                guard let self else { return }
                self.image = image
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
