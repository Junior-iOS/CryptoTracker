//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by NJ Development on 30/05/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let service = CoinDataService()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        service.$allCoins
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
    }
}
