//
//  MyView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/07.
//

import SwiftUI

struct MyView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var viewModel: MyViewModel

    init() {
        self.viewModel = MyViewModel()
    }

    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                ScrollView{
                    VStack{
                        Text(self.authenticationViewModel.user?.nickname ?? "익명")
                                .fontWeight(.medium)
                                .font(.system(size: 18))
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 0))
                                .frame(width: geometry.size.width, alignment: .leading)
                        Text((self.authenticationViewModel.user?.major ?? []).joined(separator: ","))
                                .fontWeight(.regular)
                                .font(.system(size: 12))
                                .foregroundColor(Color("DisableColor"))
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0))
                                .frame(width: geometry.size.width, alignment: .leading)

                        NavigationLink(destination: MyPointView(
                                point: self.authenticationViewModel.user?.point ?? 0)) {
                            HStack{
                                Text("\(self.authenticationViewModel.user?.point ?? 0)P")
                                        .fontWeight(.medium)
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                        .frame(height: 36)
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                Spacer()
                                Image(systemName: "chevron.right")
                                        .foregroundColor(Color.white)
                            }.padding(.horizontal, 16)
                                    .background(Color("PrimaryBlue"))
                                    .cornerRadius(8)

                        }
                                .padding(.horizontal, 16)

                        HStack(spacing: 32){
                            Group{
                                VStack(spacing: 0){
                                    Text("\(self.viewModel.lectureCount?.lectureReview ?? 0)")
                                            .fontWeight(.medium)
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 24, alignment: .center)
                                            .padding(.bottom, 2)

                                    Text("강의평가")
                                            .fontWeight(.regular)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color("DisableColor"))
                                            .frame(height: 18)
                                }

                                HStack{
                                    Divider()
                                            .frame(height: 16)
                                }

                                VStack(spacing: 0){
                                    Text("\(self.viewModel.lectureCount?.getLectureBankCount ?? 0)")
                                            .fontWeight(.medium)
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 24, alignment: .center)
                                            .padding(.bottom, 2)

                                    Text("강의자료")
                                            .fontWeight(.regular)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color("DisableColor"))
                                            .frame(height: 18)
                                }

                                HStack{
                                    Divider()
                                            .frame(height: 16)
                                }

                                VStack(spacing: 0){
                                    Text("\(self.viewModel.lectureCount?.getLectureBankCommentCount ?? 0)")
                                            .fontWeight(.medium)
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 24, alignment: .center)
                                            .padding(.bottom, 2)

                                    Text("댓글")
                                            .fontWeight(.regular)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color("DisableColor"))
                                            .frame(height: 18)
                                }
                            }
                        }.padding(.vertical, 24)
                        Divider()
                        Group {
                            NavigationLink(destination: LectureScrapView()) {
                                HStack {
                                    Text("강의평 스크랩")
                                            .fontWeight(.medium)
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 24)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                            .frame(width: 18, height: 18)
                                            .foregroundColor(Color("PrimaryBlack"))
                                }.padding(EdgeInsets(
                                        top: 24, leading: 16, bottom: 26, trailing: 16
                                ))
                            }
                            Divider()
                            NavigationLink(destination: LectureBankScrapView()) {
                                HStack {
                                    Text("강의자료 스크랩")
                                            .fontWeight(.medium)
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 24)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                            .frame(width: 18, height: 18)
                                            .foregroundColor(Color("PrimaryBlack"))
                                }.padding(EdgeInsets(
                                        top: 24, leading: 16, bottom: 26, trailing: 16
                                ))
                            }
                            Divider()

                            /*VStack(spacing: 0){
                                NavigationLink(destination: PurchasedItemView()) {
                                    HStack {
                                        Text("구입한 자료")
                                                .fontWeight(.medium)
                                                .font(.system(size: 16))
                                                .foregroundColor(Color("PrimaryBlack"))
                                                .frame(height: 24)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                                .frame(width: 18, height: 18)
                                                .foregroundColor(Color("PrimaryBlack"))
                                    }.padding(.bottom, 16)
                                }
                                ScrollView(.horizontal){
                                    HStack(spacing: 8){
                                        ForEach(0..<(self.viewModel.purchaseList.count)) { index in
                                            VStack {
                                                HStack{
                                                    Image("\(self.viewModel.purchaseList[index].uploadFiles.first?.ext ?? "txt")")
                                                            .resizable()
                                                            .frame(width: 24, height: 24)
                                                            .padding(8)
                                                    Spacer()
                                                }
                                                Spacer()
                                                HStack {
                                                    Spacer()
                                                    Text("\(self.viewModel.purchaseList[index].uploadFiles.first?.fileName ?? "")")
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
                                        }
                                    }
                                }
                            }.padding(EdgeInsets(
                                    top: 24, leading: 16, bottom: 26, trailing: 16
                            ))*/
                        }

                    }
                }.frame(width: geometry.size.width, alignment: .leading)
                        .navigationBarTitleDisplayMode(.inline)
                        //.navigationBarTitle("", displayMode: .inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: SettingsView().environmentObject(self.viewModel)) {
                                    Image("Config")
                                }
                            }
                        }
                        .background(UINavigationConfiguration { nc in
                            nc.navigationBar.barTintColor = .white
                            nc.navigationBar.shadowImage = UIImage()
                            nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                        })
            }
        }
    }
}
