//
//  LoginView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import SwiftUI

struct LoginView: View {
    /*@ObservedObject var viewModel: LoginViewModel = LoginViewModel(userFetcher: UserFetcher())*/
    @State var email: String = ""
    @State var password: String = ""
    
        var body: some View {
            return NavigationView {
                VStack {
                    Spacer()
                    VStack {
                        VStack{
                            HStack {
                                TextField("KOREATECH 이메일", text: $email)
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    
                                Text("@ koreatech.ac.kr")
                                    .font(.system(size: 14, weight: .regular))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                            }
                            Divider()
                            
                            
                            SecureField("비밀번호", text: $password)
                                .font(.system(size: 14, weight: .medium))
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                            
                            Divider()
                        }
                        
                        // 로그인 버튼을 누르면
                        Button(action: {
                            //self.viewModel.login()
                        }) {
                            HStack{
                                Spacer()
                                Text("로그인")
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
                    }.padding([.leading, .trailing], CGFloat(16))
                    
                    HStack{
                        Text("비밀번호를 잊어버리셨나요? ")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color("DisableColor"))
                        Button(action: {
                            
                        }) {
                            Text("비밀번호 찾기")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color("PrimaryBlack"))
                        }
                    }.padding(.top, 40)
                    Spacer()
                    HStack{
                        Text("아직 계정이 없으신가요? ")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color("DisableColor"))
                        NavigationLink(destination: TermsView()) {
                            Text("회원가입")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color("PrimaryBlack"))
                        }
                    }.padding(.bottom, 40)
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            
            
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
