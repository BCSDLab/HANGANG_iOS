//
// Created by 정태훈 on 2021/01/31.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var tabViewModel: TabViewModel

    init() {
        self.viewModel = HomeViewModel()
    }
    
    var majorList: [String] = [
        "교양학부",
        "HRD학과",
        "기계공학부",
        "디자인ㆍ건축공학부",
        "메카트로닉스공학부",
        "산업경영학부",
        "에너지신소재화학공학부",
        "전기ㆍ전자ㆍ통신공학부",
        "컴퓨터공학부"
    ]
    
    var majorThumbnailList: [String] = [
        "culture",
        "hrd",
        "machine",
        "design",
        "mecha",
        "operation",
        "energy",
        "electrity",
        "computer"
    ]
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                ScrollView{
                    VStack{
                        Text("강의랭킹")
                                .fontWeight(.medium)
                                .font(.system(size: 16))
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
                                .frame(width: geometry.size.width, alignment: .leading)
                        VStack(spacing: 0){
                            ScrollView(.horizontal){
                                HStack(spacing: 16){
                                    ForEach(0..<majorList.count) { index in
                                        Button(action: {
                                            self.viewModel.department = majorList[index]
                                        }) {
                                            Text("\(majorList[index])")
                                                    .font(.system(size: 14))
                                                .foregroundColor(majorList[index] == self.viewModel.department ? Color("PrimaryBlue") :  Color("DisableColor"))
                                        }
                                                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                                    }
                                }.padding(.horizontal, 8)
                            }
                            if(viewModel.lectureResult.count > 0) {
                                ForEach(0..<9) { index in

                                    if(index % 2 == 0) {
                                        RankingLectureItem(
                                                rank: (index / 2) + 1,
                                                lecture: viewModel.lectureResult[(index / 2)]
                                        )
                                    } else {
                                        Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(Color("BorderColor"))
                                    }


                                }
                            }
                        }
                                .frame(width: geometry.size.width - 32)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color("BorderColor"), lineWidth: 1)
                                )
                                .padding(.horizontal, 16)

                        Text("학부별 탐색")
                                .fontWeight(.medium)
                                .font(.system(size: 16))
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
                                .frame(width: geometry.size.width, alignment: .leading)

                        ScrollView(.horizontal){
                            HStack(spacing: 8){
                                ForEach(0..<majorThumbnailList.count) { index in
                                    Button(action: {
                                        self.tabViewModel.major = majorList[index]
                                        self.tabViewModel.menuTapped("ClipboardCheck")
                                    }) {
                                        VStack {
                                            Text("\(majorList[index])")
                                                    .fontWeight(.medium)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 14)
                                                    .padding(.bottom, 8)
                                        }.frame(width: 87, height: 87, alignment: .bottom)
                                                .background(
                                                        Image("\(majorThumbnailList[index])")
                                                                .resizable()
                                                )
                                                .cornerRadius(8)
                                    }
                                }
                            }.padding(.horizontal, 16)
                        }

                        Text("내 시간표")
                                .fontWeight(.medium)
                                .font(.system(size: 16))
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
                                .frame(width: geometry.size.width, alignment: .leading)

                        VStack(spacing: 0){
                            if(viewModel.timeTableLectureResult.count > 0) {
                                ForEach(0..<viewModel.timeTableLectureResult.count * 2 - 1) { index in

                                    if(index % 2 == 0) {
                                        TimetableLectureItem(
                                                lecture: viewModel.timeTableLectureResult[(index / 2)]
                                        )
                                    } else {
                                        Rectangle()
                                                .frame(height: 1)
                                                .foregroundColor(Color("BorderColor"))
                                    }


                                }
                            }
                        }
                                .frame(width: geometry.size.width - 32)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color("BorderColor"), lineWidth: 1)
                                )
                                .padding(.horizontal, 16)

                        /*if(!((self.viewModel.hitLectureBank ?? []).isEmpty)) {
                            VStack{
                                Text("추천 강의자료")
                                        .fontWeight(.medium)
                                        .font(.system(size: 16))
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
                                        .frame(width: geometry.size.width, alignment: .leading)

                                ScrollView(.horizontal){
                                    HStack(spacing: 8){
                                        ForEach(self.viewModel.hitLectureBank, id: \.self) { lectureBank in
                                            NavigationLink(destination: LectureBankDetailView(
                                                    lectureBankId: lectureBank.id
                                            )) {
                                                VStack{
                                                    VStack {
                                                        Image("\((lectureBank.uploadFiles ?? []).first?.ext ?? "txt")")
                                                                .resizable()
                                                                .frame(width: 33, height: 33)
                                                                .padding(8)
                                                    }.frame(width: 90, height: 90, alignment: .center)
                                                            .background(Color(red: 252/256, green: 252/256, blue: 252/256))
                                                            .cornerRadius(8)

                                                    Text("\(lectureBank.title ?? "")")
                                                            .fontWeight(.regular)
                                                            .font(.system(size: 12))
                                                            .foregroundColor(Color("PrimaryBlack"))
                                                            .frame(width: 90, height: 18, alignment: .leading)

                                                }
                                            }
                                                    .padding(.leading,(self.viewModel.hitLectureBank ?? []).first == lectureBank ? 16 : 0)
                                                    .padding(.trailing,(self.viewModel.hitLectureBank ?? []).last == lectureBank ? 16 : 0)
                                        }
                                    }
                                }.padding(.bottom, 16)
                            }
                        } else {
                            EmptyView()
                        }*/
                    }
                }.frame(width: geometry.size.width, alignment: .leading)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitle("", displayMode: .inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                HStack{
                                    Text("한강")
                                            .font(.custom("NanumSquareRoundOTFEB", size: 20))
                                            .foregroundColor(Color("PrimaryBlue"))
                                }
                            }

                        }
                        .background(UINavigationConfiguration { nc in
                            nc.navigationBar.barTintColor = .white
                            /*nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)*/
                            nc.navigationBar.shadowImage = UIImage()
                            nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                        })
            }
        }
    }
}
