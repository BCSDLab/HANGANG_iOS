//
//  LectureBankScrapView.swift
//  hangang
//
//  Created by 정태훈 on 2021/07/12.
//
//

import SwiftUI

struct LectureBankScrapView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var viewModel: LectureBankScrapViewModel

    init() {
        self.viewModel = LectureBankScrapViewModel()
    }

    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                if((viewModel.scrapLectureBankList ?? []).count > 0) {
                    ForEach(0..<(viewModel.scrapLectureBankList ?? []).count) { index in
                        ZStack(alignment: .topLeading) {
                            NavigationLink(destination: LectureBankDetailView(
                                    lectureBankId: (viewModel.scrapLectureBankList ?? [])[index].id
                            ).tripleEmptyNavigationLink()) {
                                HStack(spacing: 0){
                                    /*AsyncImage(url: URL(string: "https://picsum.photos/102")!,
                                                   placeholder: { Text("Loading ...") },
                                                   image: { Image(uiImage: $0).resizable()})*/


                                    VStack {

                                        /*AsyncImage(url: URL(string: "\((viewModel.scrapLectureBankList ?? [])[index].thumbnail ?? "")")!,
                                                placeholder: { Text("Loading ...") },
                                                image: { Image(uiImage: $0).resizable().frame(width: 33, height: 33)})*/

                                    }
                                            .frame(width: 102, height: 102)
                                            .cornerRadius(8, corners: [.topLeft, .bottomLeft])

                                    VStack(alignment: .leading, spacing: 0){
                                        HStack(spacing: 0){
                                            Text((viewModel.scrapLectureBankList ?? [])[index].title)
                                                    .font(.system(size: 14))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(Color("PrimaryBlack"))
                                                    .frame(height: 21)
                                            Spacer()
                                            Text("\((viewModel.scrapLectureBankList ?? [])[index].category.joined(separator: ", "))")
                                                    .font(.system(size: 12))
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("PrimaryBlue"))
                                                    .frame(height: 18)
                                        }
                                        Text((viewModel.scrapLectureBankList ?? [])[index].user.nickname)
                                                .font(.system(size: 12))
                                                .fontWeight(.regular)
                                                .foregroundColor(Color("PrimaryBlack"))
                                                .frame(height: 18)
                                        Spacer()

                                        HStack(alignment:.bottom,spacing: 0){
                                            Text("\((viewModel.scrapLectureBankList ?? [])[index].lecture.name)")
                                                    .font(.system(size: 12))
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("DisableColor"))
                                                    .frame(height: 18)
                                            Text(" | ")
                                                    .font(.system(size: 12))
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("DisableColor"))
                                                    .frame(height: 18)
                                            Text("\((viewModel.scrapLectureBankList ?? [])[index].lecture.professor)")
                                                    .font(.system(size: 12))
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("DisableColor"))
                                                    .frame(height: 18)
                                            Spacer()
                                            Image("ThumbUp")
                                                    .frame(width: 16, height: 16)
                                                    .padding(.trailing, 4)

                                            Text("\((viewModel.scrapLectureBankList ?? [])[index].hits)")
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
                                    .padding(.top, 7)

                            Image("Bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:16)
                                    .padding(.horizontal, 20)


                        }

                    }
                }
            }.padding(.top, 16)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {

                            }) {
                                Text("완료")
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            Text("강의자료 스크랩")
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("PrimaryBlack"))
                        }
                    }.background(UINavigationConfiguration { nc in
                        nc.navigationBar.barTintColor = .white
                        /*nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)*/
                        nc.navigationBar.shadowImage = UIImage()
                        nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                    })
        }
    }
}

