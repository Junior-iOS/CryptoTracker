//
//  CoinDetailViewModel.swift
//  CryptoTracker
//
//  Created by NJ Development on 09/07/24.
//

import Combine
import Foundation

final class DetailViewModel: ObservableObject {
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published var coin: Coin

    @Published var coinDescription: String?
    @Published var websiteURL: String?
    @Published var redditURL: String?

    private let service: CoinDetailDataService
    private var cancellabels = Set<AnyCancellable>()

    init(coin: Coin) {
        self.coin = coin
        self.service = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }

    private func addSubscribers() {
        service.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistic)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellabels)

        service.$coinDetails
            .sink { [weak self] returnedCoins in
                self?.coinDescription = returnedCoins?.readableDescription
                self?.websiteURL = returnedCoins?.links?.homepage?.first
                self?.redditURL = returnedCoins?.links?.subredditURL
            }
            .store(in: &cancellabels)
    }

    private func mapDataToStatistic(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistic], additional: [Statistic]) {
        let overviewArray = createOverview(with: coin)
        let additionalArray = createAdditional(with: coinDetail, and: coin)
        return (overviewArray, additionalArray)
    }

    private func createOverview(with coin: Coin) -> [Statistic] {
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let priceChangePercentage = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentageChange: priceChangePercentage)

        let marketCap = "R$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)

        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)

        let volume = "R$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)

        return [
            priceStat,
            marketCapStat,
            rankStat,
            volumeStat
        ] as [Statistic]
    }

    private func createAdditional(with coinDetail: CoinDetail?, and coin: Coin) -> [Statistic] {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = Statistic(title: "High", value: high)

        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "Low", value: low)

        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let priceChangePercentage2 = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: priceChangePercentage2)

        let marketCapChange = "R$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapChange2 = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Capitalization", value: marketCapChange, percentageChange: marketCapChange2)

        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)

        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)

        return [
            highStat,
            lowStat,
            priceChangeStat,
            marketCapChangeStat,
            blockStat,
            hashingStat
        ] as [Statistic]
    }
}
