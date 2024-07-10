//
//  CoinDetailViewModel.swift
//  CryptoTracker
//
//  Created by NJ Development on 09/07/24.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    private let service: CoinDetailDataService
    private var cancellabels = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.service = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        service.$coinDetails
            .sink { coinDetail in
                print("Received coins: \(coinDetail)")
            }
            .store(in: &cancellabels)
    }
}
