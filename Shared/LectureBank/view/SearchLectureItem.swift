//
//  SearchLectureItem.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/10/04.
//

import SwiftUI

struct SearchLectureItem: View {
    var lecture: Lecture
    @EnvironmentObject var searchLectureViewModel: SearchLectureViewModel
    @EnvironmentObject var uploadLectureBankViewModel: UploadLectureBankViewModel
    init(lecture: Lecture) {
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
                Text("\(lecture.code ?? "")")
                    .font(.system(size: 11))
                    .fontWeight(.medium)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 21)
                Spacer()
                
            }
            Text("\(lecture.professor)")
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(Color("PrimaryBlack"))
                .frame(height: 18)
                .padding(.bottom, 9)
            
            HStack(alignment:.top,spacing: 0){
                /*Text("\(lecture.grades ?? "")학점 ")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)
                
                Text("\(lecture.target) ")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)
                
                Text("\(lecture.classification ?? "") ")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)
                
                Text("\(lecture.classTimeString) ")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("DisableColor"))
                    .frame(height: 16)*/
                Spacer()
                
                Button(action: {
                    if(self.uploadLectureBankViewModel.selectedLecture == lecture) {
                        self.uploadLectureBankViewModel.selectedLecture = nil
                    } else {
                        self.uploadLectureBankViewModel.selectedLecture = lecture
                    }
                }) {
                    Text("선택")
                        .font(.system(size: 12))
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                }.background(self.uploadLectureBankViewModel.selectedLecture == lecture ? Color("PrimaryBlue") : Color("DisableColor"))
                .cornerRadius(20)
                .padding(.trailing, 8)
                
                /*Button(action: {
                    
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
                )*/
                
            }
        }
    }
}

