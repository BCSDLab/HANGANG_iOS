//
//  BarView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/13.
//

import SwiftUI

struct BarView: View {
    var value: CGFloat
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing){
                Rectangle().frame(width: 20, height: 130)
                    .foregroundColor(.clear)
                Rectangle().frame(width: 20, height: value)
                    .foregroundColor(Color("PrimaryOrenge"))
            }
            /*Text(name)
                .font(.system(size: 11))
                .fontWeight(.regular)
                .foregroundColor(Color("DisableColor"))
                .frame(height: 16)*/
        }
    }
}

