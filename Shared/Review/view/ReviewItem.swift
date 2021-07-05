//
//  ReviewItem.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/18.
//

import SwiftUI

struct ReviewItem: View {
    var review: Review
    
    init(review: Review) {
        self.review = review
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("\(review.semesterDate) 수강자")
                    .font(.system(size: 12))
                    .foregroundColor(Color("PrimaryBlack"))
                    .frame(height: 18)
                Spacer()
            }.padding(.bottom, 4)
            .padding(.top, 16)
            
            HStack {
                Text("과제정보")
                    .font(.system(size: 12))
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 18)
                    .padding(.trailing, 4)
                
                Text("\(review.assignment.map {$0.name}.joined(separator: ","))")
                    .font(.system(size: 12))
                    .foregroundColor(Color("PrimaryBlack"))
                    .frame(height: 18)
                
            }.padding(.bottom, 8)
            Text("\(review.comment)")
                .font(.system(size: 12))
                .foregroundColor(Color("PrimaryBlack"))
                .frame(height: 18)
                .padding(.bottom, 9)
            HStack {
                Image("ThumbUp")
                    .foregroundColor(review.isLiked ? Color("PrimaryBlue") : nil)
                Text("\(review.likes)")
                    .font(.system(size: 12))
                    .foregroundColor(Color("PrimaryBlue"))
                    .frame(height: 18)
                Spacer()
                Text("신고")
                    .font(.system(size: 12))
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 18)
            }.padding(.bottom, 15)
            Divider()
                
        }
    }
}

