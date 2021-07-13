//
//  LectureBankItem.swift
//  hangang
//
//  Created by 정태훈 on 2021/07/12.
//
//

import SwiftUI

struct LectureBankItem: View {
    var lectureBank: LectureBank

    init(lectureBank: LectureBank) {
        self.lectureBank = lectureBank
    }

    var body: some View {
        NavigationLink(destination: LectureBankDetailView(
                lectureBankId: lectureBank.id
        )) {
            HStack(spacing: 0){
                /*AsyncImage(url: URL(string: "https://picsum.photos/102")!,
                               placeholder: { Text("Loading ...") },
                               image: { Image(uiImage: $0).resizable()})*/


                VStack {
                    Image("\(lectureBank.uploadFiles?.first?.ext ?? "txt")")
                            .resizable()
                            .frame(width: 33, height: 33)
                }
                        .frame(width: 102, height: 102)
                        .cornerRadius(8, corners: [.topLeft, .bottomLeft])

                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing: 0){
                        Text(lectureBank.title)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 21)
                        Spacer()
                        Text("\(lectureBank.category.joined(separator: ", "))")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlue"))
                                .frame(height: 18)
                    }
                    Text(lectureBank.user.nickname)
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color("PrimaryBlack"))
                            .frame(height: 18)
                    Spacer()

                    HStack(alignment:.bottom,spacing: 0){
                        Text("\(lectureBank.lecture.name)")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(height: 18)
                        Text(" | ")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(height: 18)
                        Text("\(lectureBank.lecture.professor)")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(height: 18)
                        Spacer()
                        Image("ThumbUp")
                                .frame(width: 16, height: 16)
                                .padding(.trailing, 4)

                        Text("\(lectureBank.hits)")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(height: 18)
                    }
                }.padding(9)
            }
                    .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("BorderColor"), lineWidth: 1)
                    )
                    .padding(.horizontal, 16)
        }
    }
}
