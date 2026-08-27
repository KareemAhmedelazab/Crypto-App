//
//  PortfolioView.swift
//  Crypto
//
//  Created by Kareem on 27/08/2026.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var textField: String = ""
    @State private var checkMark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        porfolioInputSection
                    }
                }
                
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    saveBarTrailing
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
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
                                    selectedCoin?.id == coin.id ?
                                    Color.theme.green : Color.clear,
                                    lineWidth: 1.0
                                )
                            )
                }
            }
            .padding()
        }
    }
    
    private var porfolioInputSection: some View {
        
        VStack {
            HStack {
                Text("Current price of \(selectedCoin?.symbol ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $textField)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none, value: selectedCoin?.id)
        .padding()
        .font(.headline)
    }
    
    private var saveBarTrailing: some View {
        
        HStack {
            Image(systemName: "checkmark")
                .foregroundStyle(Color.theme.accent)
                .opacity(checkMark ? 1 : 0)
            Button(action: {
                pressedSaveButton()
            }, label: {
                Text("Save")
                    .foregroundStyle(Color.theme.accent)
            })
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(textField) ? 1 : 0)
        }
    }
    
    private func getCurrentValue() -> Double {
        if let currentValue = Double(textField) {
            return currentValue * (selectedCoin?.currentPrice ?? 0)
        } else { return 0 }
    }
    
    private func pressedSaveButton() {
        
        guard let coin = selectedCoin else { return }
        
        // save to portfolio
        
        // show checkmark
        withAnimation(.easeIn) {
            checkMark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            withAnimation(.easeOut) {
                checkMark = false
            }
        })
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
        
    }
}
