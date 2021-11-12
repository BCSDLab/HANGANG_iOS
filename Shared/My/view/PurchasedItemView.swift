//
//  PurchasedItemView.swift
//  hangang
//
//  Created by 정태훈 on 2021/07/12.
//
//

import SwiftUI

struct PurchasedItemView: View {
    @ObservedObject var viewModel: PurchasedItemViewModel
    
    init() {
        self.viewModel = PurchasedItemViewModel()
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(self.viewModel.purchaseList, id: \.self) { (p: Purchase) in
                    VStack {
                        HStack {
                            Text("\(p.lecture.name)")
                        }
                    }.onTapGesture {

                    }
                }
            }
        }
    }
}
