//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by NJ Development on 13/06/24.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantity: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                        .padding()
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputStack
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            })
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel())
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal,
                   showsIndicators: false,
                   content: {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                                    lineWidth: 1
                                )
                        )
                }
            }
            .padding(.leading)
            .padding(.vertical, 4)
//            .frame(height: 120)
        })
    }
    
    func getCurrentValue() -> Double {
        if let quantity = Double(quantity) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputStack: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(String(describing: selectedCoin?.symbol.uppercased() ?? "")): ")
                Spacer()
                Text("\(String(describing: selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? ""))")
            }
            
            Divider()
            HStack {
                Text("Amount holding: ")
                Spacer()
                TextField("Ex: 1.4", text: $quantity)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            HStack {
                Text("Current value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith6Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
}
