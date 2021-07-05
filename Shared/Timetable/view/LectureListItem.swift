//
//  LectureListItem.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/28.
//

import SwiftUI

struct LectureListItem: View {
    var lecture: TimeTableLecture
    @EnvironmentObject var viewModel: TimeTableViewModel
    
    init(lecture: TimeTableLecture) {
        self.lecture = lecture
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(alignment: .center, spacing: 0){
                Text("\(lecture.name) ")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color("PrimaryBlack"))
                    .frame(height: 21)
                Text("\(lecture.code)")
                    .font(.system(size: 11))
                    .fontWeight(.medium)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 21)
                Spacer()
                Text("\(String(format: "%.1f", lecture.rating))")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color("PrimaryBlack"))
                    .frame(height: 21)
            }
            Text("\(lecture.professor) (\(lecture.classNumber))")
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(Color("PrimaryBlack"))
                .frame(height: 18)
                .padding(.bottom, 9)
            
            HStack(alignment:.top,spacing: 0){
                Text("\(lecture.grades)학점 ")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)
                
                Text("\(lecture.target) ")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)
                
                Text("\(lecture.classification) ")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)
                
                Text("\(lecture.classTimeString) ")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)
                Spacer()
                
                Button(action: {
                    //viewModel.addLecture(lectureId: lecture.id)
                }) {
                    Text("담기")
                        .font(.system(size: 12))
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                }.background(Color("PrimaryBlue"))
                .cornerRadius(20)
                .padding(.trailing, 8)
                
                Button(action: {
                    
                }) {
                    Text("강의평")
                        .font(.system(size: 12))
                        .foregroundColor(Color("DisableColor"))
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                }.background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("DisableColor"), lineWidth: 1)
                )
                
            }
        }
    }
}
