//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by NJ Development on 07/06/24.
//

import Foundation
import Combine

final class MarketDataService {
    @Published var marketData: MarketData? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        
        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] globalData in
                self?.marketData = globalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
