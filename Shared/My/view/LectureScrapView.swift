//
//  LectureScrapView.swift
//  hangang
//
//  Created by 정태훈 on 2021/07/12.
//
//

import SwiftUI

struct LectureScrapView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var viewModel: LectureScrapViewModel

    init(token: Token?) {
        self.viewModel = LectureScrapViewModel(
                token: token
        )
    }

    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                if((viewModel.scrapLectureList ?? []).count > 0) {
                    ForEach(0..<(viewModel.scrapLectureList ?? []).count) { index in
                        ZStack(alignment: .topLeading) {
                            
                            NavigationLink(destination: ReviewDetailView(
                                    lecture: (viewModel.scrapLectureList ?? [])[index]
                            ).tripleEmptyNavigationLink()) {
                                VStack(alignment: .leading, spacing: 0){
                                    HStack(spacing: 0){
                                        Text("\((viewModel.scrapLectureList ?? [])[index].name)")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color("PrimaryBlack"))
                                                .frame(height: 21)
                                        Text(" (\((viewModel.scrapLectureList ?? [])[index].reviewCount ?? 0))")
                                                .font(.system(size: 11))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color("DisableColor"))
                                                .frame(height: 16)
                                        Spacer()
                                        Text("\((viewModel.scrapLectureList ?? [])[index].classification ?? "")")
                                                .font(.system(size: 12))
                                                .fontWeight(.regular)
                                                .foregroundColor(Color("PrimaryBlue"))
                                                .frame(height: 18)
                                    }
                                    Text("\((viewModel.scrapLectureList ?? [])[index].professor)")
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 21)
                                            .padding(.bottom, 9)

                                    HStack(alignment:.bottom,spacing: 0){
                                        /*if(((viewModel.scrapLectureList ?? [])[index].top3HashTag ?? []).count > 0) {
                                            ForEach((viewModel.scrapLectureList ?? [])[index].top3HashTag ?? [], id: \.self) { hash in
                                                Text("#\(hash.tag) ")
                                                        .font(.system(size: 12))
                                                        .fontWeight(.regular)
                                                        .foregroundColor(Color("DisableColor"))
                                                        .frame(height: 18)
                                            }
                                        }*/
                                        Spacer()
                                        Text("\(String(format: "%.1f",  (viewModel.scrapLectureList ?? [])[index].totalRating ?? 0.0))")
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
                                    .padding(.top, 7)

                            Image("Bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:16)
                                    .padding(.horizontal, 20)


                        }
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
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
                            Text("강의평 스크랩")
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
