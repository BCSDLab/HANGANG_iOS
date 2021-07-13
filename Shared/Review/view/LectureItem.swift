//
//  LectureItem.swift
//  hangang
//
//  Created by 정태훈 on 2021/07/12.
//
//

import SwiftUI

struct LectureItem: View {
    var lecture: Lecture

    init(lecture: Lecture) {
        self.lecture = lecture
    }

    var body: some View {
        NavigationLink(destination: ReviewDetailView(
                lecture: lecture
        )) {
            VStack(alignment: .leading, spacing: 0){
                HStack(spacing: 0){
                    Text("\(lecture.name)")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(Color("PrimaryBlack"))
                            .frame(height: 21)
                    Text(" (\(lecture.reviewCount ?? 0))")
                            .font(.system(size: 11))
                            .fontWeight(.medium)
                            .foregroundColor(Color("DisableColor"))
                            .frame(height: 16)
                    Spacer()
                    Text("\(lecture.classification ?? "")")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color("PrimaryBlue"))
                            .frame(height: 18)
                }
                Text("\(lecture.professor)")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color("PrimaryBlack"))
                        .frame(height: 21)
                        .padding(.bottom, 9)

                HStack(alignment:.bottom,spacing: 0){
                    if((lecture.top3HashTag ?? []).count > 0) {
                        ForEach(lecture.top3HashTag ?? [], id: \.self) { hash in
                            Text("#\(hash.tag) ")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("DisableColor"))
                                    .frame(height: 18)
                        }
                    }
                    Spacer()
                    Text("\(String(format: "%.1f",  lecture.totalRating ?? 0.0))")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(Color("PrimaryBlack"))
                            .frame(height: 30)
                }
            }.padding(16)
                    .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("BorderColor"), lineWidth: 1)
                    )
                    .padding(.horizontal, 16)
        }
    }
}
