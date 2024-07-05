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
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.shared.coin)
}
