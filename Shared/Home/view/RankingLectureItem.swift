//
//  RankingLectureItem.swift
//  hangang
//
//  Created by 정태훈 on 2021/07/22.
//
//

import SwiftUI

struct RankingLectureItem: View {
    var rank: Int
    var lecture: Lecture

    init(rank: Int, lecture: Lecture) {
        self.rank = rank
        self.lecture = lecture
    }

    var body: some View {
        NavigationLink(
                destination: ReviewDetailView(
                        lecture: lecture
                )
        ) {
            HStack{
                Text("\(rank)")
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(.trailing, 16)
                VStack(alignment: .leading){
                    Text(lecture.name)
                            .fontWeight(.medium)
                            .font(.system(size: 14))
                            .foregroundColor(Color("PrimaryBlack"))
                    Text(lecture.professor)
                            .font(.system(size: 12))
                            .foregroundColor(Color("DisableColor"))
                }
                Spacer()
                Text("\(String(format: "%.1f",  lecture.totalRating ?? 0.0))")
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                        .foregroundColor(Color("PrimaryBlack"))
            }.padding(16)
        }
    }
}
