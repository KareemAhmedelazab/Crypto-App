//
//  HomeStatsView.swift
//  Crypto
//
//  Created by Kareem on 24/08/2026.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showProtFolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .containerRelativeFrame(.horizontal, alignment: .center) { x, _ in
                        x / 3
                    }
            }
        }
        .containerRelativeFrame(.horizontal, alignment: showProtFolio ? .trailing : .leading) { x, _ in
            x
        }

    }
}

#Preview {
    HomeStatsView(showProtFolio: .constant(true))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
