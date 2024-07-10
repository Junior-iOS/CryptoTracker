//
//  DetailView.swift
//  CryptoTracker
//
//  Created by NJ Development on 27/06/24.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    
    init(coin: Binding<Coin?>) {
        self._coin = coin
    }
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    init(coin: Coin) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text("Hello, there!")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.shared.coin)
}
