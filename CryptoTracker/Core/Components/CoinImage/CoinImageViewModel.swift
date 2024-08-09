//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by NJ Development on 31/05/24.
//

import Combine
import Foundation
import SwiftUI

final class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    private let coin: Coin
    private let service: CoinImageService
    private var cancellable = Set<AnyCancellable>()

    init(coin: Coin) {
        self.coin = coin
        service = CoinImageService(coin: coin)
        addSubscribers()
    }

    private func addSubscribers() {
        service.$image
            .sink { [weak self] _ in
                self?.isLoading = true
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellable)
    }
}
