//
//  TimetableLectureItem.swift
//  hangang
//
//  Created by 정태훈 on 2021/08/22.
//
//
import SwiftUI

struct TimetableLectureItem: View {
    var lecture: TimeTableLecture

    init(lecture: TimeTableLecture) {
        self.lecture = lecture
    }

    var body: some View {
        NavigationLink(
                destination: ReviewDetailView(
                        lecture: lecture.toLecture()
                )
        ) {
            HStack{
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
                NavigationLink(destination: ReviewDetailView(
                        lecture: lecture.toLecture()
                )) {
                    Text((self.lecture.isReviewed ?? false) ? "평가완료": "평가하기")
                            .font(.system(size: 12))
                            .foregroundColor((self.lecture.isReviewed ?? false) ? Color("DisableColor"): Color.white)
                            .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8))
                }
                        .disabled((self.lecture.isReviewed ?? false))
                        .background((self.lecture.isReviewed ?? false) ? Color("BorderColor"): Color("PrimaryBlue"))
                        .cornerRadius(20)

                /*Text("평가하기")
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                        .foregroundColor(Color("PrimaryBlack"))*/
            }.padding(16)
        }.disabled((self.lecture.isReviewed ?? false))
    }
}