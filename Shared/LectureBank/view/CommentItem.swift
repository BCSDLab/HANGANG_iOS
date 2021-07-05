//
//  CommentItem.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/25.
//

import SwiftUI

struct CommentItem: View {
    var comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0){
                Text("\(comment.nickname)")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(Color("PrimaryBlack"))
                    .frame(height: 18)
                    .padding(.trailing, 8)
                
                Text("\(comment.createdAt.stringToDate.timeAgoDisplay())")
                    .font(.system(size: 11))
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(Color("DisableColor"))
            }.padding(.bottom, 4)
            .padding(.top, 16)
            
            Text("\(comment.comments)")
                .font(.system(size: 12))
                .foregroundColor(Color("PrimaryBlack"))
                .lineLimit(nil)
                .padding(.bottom, 15)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                .foregroundColor(Color("BorderColor"))
                .background(Color("BorderColor"))
        }
    }
}
