//
//  LectureBankDetailView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/14.
//

import SwiftUI

struct LectureBankDetailView: View {
    @ObservedObject var viewModel: LectureBankDetailViewModel
    
    init(lectureBankId: Int) {
        self.viewModel = LectureBankDetailViewModel(
            lectureBankId: lectureBankId
        )
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0){
                    HStack {
                        Text(viewModel.lectureBankResult?.title ?? "")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(Color("PrimaryBlack"))
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color("DisableColor"))
                    }.padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    Text(viewModel.lectureBankResult?.user.nickname ?? "")
                        .font(.system(size: 14))
                        .foregroundColor(Color("DisableColor"))
                        .padding(.horizontal, 16)
                    HStack {
                        Text("작성일 \(viewModel.lectureBankResult?.createdAt.stringToDate.getymd ?? "")")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DisableColor"))
                        Spacer()
                        Image(systemName: "hand.thumbsup")
                            .foregroundColor(Color("DisableColor"))
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 4)
                        Text("\(viewModel.lectureBankResult?.hits ?? 0)")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DisableColor"))
                    }.padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 14)
                    VStack {
                        Image("\(viewModel.lectureBankResult?.uploadFiles?.first?.ext ?? "txt")")
                            .resizable()
                            .frame(width: 99, height: 99)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    /*AsyncImage(url: URL(string: "https://picsum.photos/\(Int(geometry.size.width))")!,
                                   placeholder: { Text("Loading ...") },
                                   image: { Image(uiImage: $0).resizable()})*/
                        
                        .padding(.bottom, 16)
                    
                    //
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0){
                            Text(viewModel.lectureBankResult?.lecture.name ?? "")
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("PrimaryBlack"))
                                .padding(.trailing, 8)
                            Text(viewModel.lectureBankResult?.lecture.semesterData?.first ?? "")
                                .font(.system(size: 12))
                                .foregroundColor(Color("DisableColor"))
                                Spacer()
                            Text("\(viewModel.lectureBankResult?.category.joined(separator: ", ") ?? "")")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("PrimaryBlue"))
                                    .frame(height: 18)
                            }.padding(.horizontal, 16)
                            .padding(.bottom, 4)
                        Text(viewModel.lectureBankResult?.lecture.professor ?? "")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color("DisableColor"))
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        
                        Text(viewModel.lectureBankResult?.content ?? "")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color("PrimaryBlack"))
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                    }
                    
                    ScrollView(.horizontal){
                        HStack(spacing: 8){
                            ForEach(0..<(viewModel.lectureBankResult?.uploadFiles?.count ?? 0)) { index in
                                VStack {
                                    HStack{
                                        Image("\(viewModel.lectureBankResult?.uploadFiles?[index].ext ?? "txt")")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .padding(8)
                                        Spacer()
                                    }
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Text("\(viewModel.lectureBankResult?.uploadFiles?[index].fileName ?? "")")
                                            .fontWeight(.regular)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 18, alignment: .center)
                                            .padding(8)
                                    }
                                }.frame(width: 100, height: 100, alignment: .topLeading)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color("BorderColor"), lineWidth: 1)
                                )
                                        .cornerRadius(8)
                                .padding(.leading, index == 0 ? 16 : 0)
                                .padding(.trailing, index == ((viewModel.lectureBankResult?.uploadFiles?.count ?? 0) - 1) ? 16 : 0)
                            }
                        }
                    }.padding(.bottom, 16)
                    
                    Divider()
                    
                    VStack (spacing: 0){
                        HStack {
                            TextField("댓글을 작성해주세요.", text: self.$viewModel.comment)
                                .padding(12)
                            Spacer()
                        }
                        .frame(width: geometry.size.width - 32, alignment: .center)
                        .background(Color("BorderColor"))
                        .cornerRadius(8.0)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        
                        VStack(spacing: 0) {
                            ForEach(self.viewModel.lectureBankCommentsResult, id: \.self) { comment in
                                CommentItem(
                                    comment: comment
                                )
                            }
                        }.padding(.horizontal, 16)
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    Text("강의자료 상세")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                }
            }
        }
        
    }
}

/*struct LectureBankDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LectureBankDetailView(item: nil)
    }
}*/
