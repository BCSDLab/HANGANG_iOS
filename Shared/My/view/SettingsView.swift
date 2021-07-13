//
//  SettingsView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/08.
//

import SwiftUI

struct SettingsView: View {
    @State var isLoggedOutPopup = false
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var myViewModel: MyViewModel
    @ObservedObject var viewModel: SettingsViewModel
    
    
    
    init(token: Token?) {
        self.viewModel = SettingsViewModel(
        token: token
        )
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 0) {
                CustomShape()
                    .fill(Color("BorderColor"))
                  .frame(maxWidth: .infinity, minHeight: 1.5, maxHeight: 1.5)
                
                Group{
                    Text("프로필")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                    NavigationLink(destination: EditMyView(
                        user: self.authenticationViewModel.user
                    )) {
                        HStack{
                            Text("내 정보 변경")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color("PrimaryBlack"))
                        }.padding(.all, 16)
                    }
                }
                Divider()
                Group {
                    Text("앱 설정")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                    Toggle(isOn: self.$viewModel.isAuthLoggedIn) {
                        Text("자동로그인")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color("PrimaryBlack"))
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryBlue")))
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    HStack{
                        Text("앱 정보")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color("PrimaryBlack"))
                        Spacer()
                        Text("v1.0 최신 버전입니다.")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color("DisableColor"))
                    }.padding(.all, 16)
                }
                Divider()
                Group {
                    Text("기타")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 0))
                    NavigationLink(destination: EmptyView()) {
                        HStack{
                            Text("문의하기")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color("PrimaryBlack"))
                        }.padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    Button(action: {
                        
                        self.isLoggedOutPopup = true
                    }) {
                        HStack{
                            Text("로그아웃")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color("PrimaryBlack"))
                        }.padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .alert(isPresented: self.$isLoggedOutPopup) {
                        Alert(
                            title: Text(""), message: Text("로그아웃하시겠습니까?").font(.system(size: 12, weight: .regular))
                                    .foregroundColor(Color("PrimaryBlack")),
                            primaryButton: .cancel(),
                            secondaryButton: .default(Text("확인")) {
                                self.authenticationViewModel.logout()
                            }
                              )
                            }
                    Button(action: {
                        
                    }) {
                        HStack{
                            Text("회원탈퇴")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color("PrimaryBlack"))
                        }.padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                }
                    
                
            }.frame(width: geometry.size.width, alignment: .leading)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("환경설정", displayMode: .inline)
            .background(UINavigationConfiguration { nc in
                nc.navigationBar.barTintColor = .white
                nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryBlack")]
            })
        }.onAppear() {
            self.viewModel.getMy(
                    user: self.authenticationViewModel.user
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(token: nil)
    }
}
//192.168.219.104
