//
//  CoinImage.swift
//  CryptoTracker
//
//  Created by NJ Development on 31/05/24.
//

import SwiftUI

struct CoinImage: View {
    @StateObject var viewModel: CoinImageViewModel

    init(coin: Coin) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CoinImage(coin: DeveloperPreview.shared.coin)
}
