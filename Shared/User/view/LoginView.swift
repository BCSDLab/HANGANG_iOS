//
//  LoginView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State var isActive : Bool = false
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()

        var body: some View {
            NavigationView {
                VStack {
                    Spacer()
                    VStack {
                        VStack{
                            HStack {
                                TextField("KOREATECH 이메일", text: self.$viewModel.email)
                                    .autocapitalization(.none)
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    
                                Text("@ koreatech.ac.kr")
                                    .font(.system(size: 14, weight: .regular))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                            }
                            Divider()
                            
                            
                            SecureField("비밀번호", text: self.$viewModel.password)
                                .autocapitalization(.none)
                                .font(.system(size: 14, weight: .medium))
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                            
                            Divider()
                        }
                        
                        // 로그인 버튼을 누르면
                        Button(action: {
                            self.viewModel.login()
                        }) {
                            HStack{
                                Spacer()
                                Text("로그인")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color.white).padding(.vertical, 10)
                                Spacer()
                            }
                                .background(Color("PrimaryBlue"))
                                .cornerRadius(24.0)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        .padding(.top, 28)
                        .onReceive(self.viewModel.tokenChange) { token in
                            if(!token.access_token.isEmpty) {
                                authenticationViewModel.token = token
                            }
                        }
                    }.padding([.leading, .trailing], CGFloat(16))
                    
                    HStack{
                        Text("비밀번호를 잊어버리셨나요? ")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color("DisableColor"))
                        NavigationLink(destination: FindPasswordView()) {
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
                        NavigationLink(destination: TermsView(
                                        rootIsActive: self.$isActive
                        ),
                                       isActive: self.$isActive) {
                            Text("회원가입")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color("PrimaryBlack"))
                        }.isDetailLink(false)
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
