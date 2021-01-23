//
//  SignUpView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import SwiftUI

struct SignUpView: View {
    var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State var validPassword: String = ""
    @State var showValidPassword: Bool = false
    @State var nickname: String = ""
    
    init(email: String) {
        self.email = email
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            Group {
                Text("아이디")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
                HStack {
                    Text(email)
                        .font(.system(size: 14))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                    Text("@ koreatech.ac.kr")
                        .font(.system(size: 14, weight: .regular))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }.padding(.top, 16)
                Divider()
            }
            
            Group {
                Text("비밀번호")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
                    .padding(.top, 32)
                VStack{
                    HStack{
                        Group {
                            if(self.showPassword) {
                                TextField("영문,숫자,특수기호 반드시 포함 8자~15자", text: $password)
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            } else {
                                SecureField("영문,숫자,특수기호 반드시 포함 8자~15자", text: $password)
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                            
                        Button(action: { self.showPassword.toggle()}) {
                                                
                            Image(systemName: self.showPassword ? "eye" : "eye.slash")
                                                .foregroundColor(.secondary)
                                            }
                    }
                    Divider()
                }
            }
            
            Group {
                Text("비밀번호 확인")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
                    .padding(.top, 32)
                VStack{
                    SecureField("비밀번호를 한번 더 입력해주세요.", text: $validPassword)
                        .font(.system(size: 14, weight: .medium))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Divider()
                }
            }
            
            Group {
                Text("닉네임")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
                    .padding(.top, 32)
                    
                HStack {
                    TextField("10자 미만", text: $nickname)
                        .font(.system(size: 14))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                }.padding(.top, 16)
                Divider()
            }
            Spacer()
            Button(action: {
                //self.viewModel.login()
            }) {
                HStack{
                    Spacer()
                    Text("다음")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 10)
                    Spacer()
                }
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color("PrimaryBlue"))
            .cornerRadius(24.0)
            .padding(.top, 28)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 32)
        .padding(.horizontal,16)
        .navigationTitle("회원가입")
        .background(UINavigationConfiguration { nc in
            nc.navigationBar.barTintColor = .white
            nc.navigationBar.shadowImage = UIImage()
            nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryBlack")]
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(email: "wxg1297")
    }
}
