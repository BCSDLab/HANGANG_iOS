//
//  SignUpView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    @Binding var rootIsActive : Bool
    
    init(email: String, rootIsActive: Binding<Bool>) {
        self.viewModel = SignUpViewModel(email: email)
        self._rootIsActive = rootIsActive
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 0){
                ForEach([1,1,0,0],id: \.self){ step in
                    ZStack{
                        
                        CustomShape()
                            .fill(Color("BorderColor"))
                          .frame(maxWidth: .infinity, minHeight: 1.5, maxHeight: 1.5)
                        
                        if step == 1{
                            
                            CustomShape()
                              .fill(Color("PrimaryBlue"))
                              .frame(maxWidth: .infinity, minHeight: 1.5, maxHeight: 1.5)
                                /*.matchedGeometryEffect(id: "Tab_Change", in: animation)*/
                        }
                    }
                }
            }
            VStack(alignment: .leading) {
                
                Group {
                    Text("아이디")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("PrimaryBlack"))
                    HStack {
                        Text(self.viewModel.email)
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
                    HStack{
                        Text("비밀번호")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("PrimaryBlack"))
                            .padding(.trailing, 8)
                        Text(!self.viewModel.password.isEmpty && !self.viewModel.checkPassword ? "비밀번호 패턴이 맞지 않습니다!":"")
                            .font(.system(size: 11))
                            .foregroundColor(Color("PrimaryOrenge"))
                    }.padding(.top, 32)
                    VStack{
                        HStack{
                            Group {
                                if(self.viewModel.showPassword) {
                                    TextField("영문,숫자,특수기호 반드시 포함 8자~15자", text: self.$viewModel.password)
                                        .autocapitalization(.none)
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                } else {
                                    SecureField("영문,숫자,특수기호 반드시 포함 8자~15자", text: self.$viewModel.password)
                                        .autocapitalization(.none)
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                }
                            }
                            if(self.viewModel.checkPassword) {
                                Image(systemName: "checkmark")
                                                    .foregroundColor(.green)
                            } else if(self.viewModel.password.isEmpty){
                                EmptyView()
                            } else {
                                Image(systemName: "exclamationmark.triangle")
                                                    .foregroundColor(Color("PrimaryOrenge"))
                            }
                            Button(action: { self.viewModel.showPassword.toggle()}) {
                                                    
                                Image(systemName: self.viewModel.showPassword ? "eye" : "eye.slash")
                                                    .foregroundColor(.secondary)
                                                }
                        }
                        Divider()
                    }
                }
                
                Group {
                    HStack{
                        Text("비밀번호 확인")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("PrimaryBlack"))
                            .padding(.trailing, 8)
                        
                        Text(!self.viewModel.validPassword.isEmpty && !self.viewModel.checkValidPassword ? "비밀번호가 일치하지 않습니다!":"")
                            .font(.system(size: 11))
                            .foregroundColor(Color("PrimaryOrenge"))
                    }.padding(.top, 32)
                    VStack{
                        HStack{
                            Group {
                                if(self.viewModel.showValidPassword) {
                                    TextField("비밀번호를 한번 더 입력해주세요.", text: self.$viewModel.validPassword)
                                        .autocapitalization(.none)
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                } else {
                                    SecureField("비밀번호를 한번 더 입력해주세요.", text: self.$viewModel.validPassword)
                                        .autocapitalization(.none)
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                }
                            }
                            if(self.viewModel.validPassword.isEmpty) {
                                EmptyView()
                            } else if(self.viewModel.checkValidPassword){
                                Image(systemName: "checkmark")
                                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "exclamationmark.triangle")
                                                    .foregroundColor(Color("PrimaryOrenge"))
                            }
                            Button(action: { self.viewModel.showValidPassword.toggle()}) {
                                                    
                                Image(systemName: self.viewModel.showValidPassword ? "eye" : "eye.slash")
                                                    .foregroundColor(.secondary)
                                                }
                        }
                        Divider()
                    }
                }
                
                Group {
                    HStack {
                        Text("닉네임")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("PrimaryBlack"))
                            .padding(.trailing, 8)
                        Text((self.viewModel.nicknameCheckResult.message ?? "") == "사용 가능한 닉네임입니다." ? "" : self.viewModel.nicknameCheckResult.message ?? "")
                            .font(.system(size: 11))
                            .foregroundColor(Color("PrimaryOrenge"))
                    }.padding(.top, 32)
                        
                    HStack {
                        TextField("10자 미만", text: self.$viewModel.nickname)
                            .onChange(of: self.viewModel.nickname, perform: { value in
                                self.viewModel.checkNickname()
                            })
                            .autocapitalization(.none)
                            .font(.system(size: 14))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            
                        if((self.viewModel.nicknameCheckResult.message ?? "") == "사용 가능한 닉네임입니다.") {
                            Image(systemName: "checkmark")
                                                .foregroundColor(.green)
                        } else if((self.viewModel.nicknameCheckResult.message ?? "").isEmpty){
                            EmptyView()
                        } else {
                            Image(systemName: "exclamationmark.triangle")
                                                .foregroundColor(Color("PrimaryOrenge"))
                        }
                    }.padding(.top, 16)
                    Divider()
                }
                Spacer()
                NavigationLink(destination: MajorView(password: self.viewModel.password, email: self.viewModel.email, nickname: self.viewModel.nickname,
                                                      rootIsActive: self.$rootIsActive), isActive: .constant(self.viewModel.allChecked)) {
                    HStack{
                        Spacer()
                        Text("다음")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                        Spacer()
                    }.background(Color("PrimaryBlue"))
                    .cornerRadius(24.0)
                }.isDetailLink(false)
                .simultaneousGesture(TapGesture().onEnded{
                    self.viewModel.checkSignUp()
                        })
                .disabled(
                    !(self.viewModel.checkPassword && self.viewModel.checkValidPassword && (self.viewModel.nicknameCheckResult.message ?? "") == "사용 가능한 닉네임입니다.")
                )
                .buttonStyle(PlainButtonStyle())
                
                .padding(.top, 28)
            }.padding(.vertical, 32)
            .padding(.horizontal,16)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
        .navigationTitle("회원가입")
        .background(UINavigationConfiguration { nc in
            nc.navigationBar.barTintColor = .white
            nc.navigationBar.shadowImage = UIImage()
            nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryBlack")]
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}

