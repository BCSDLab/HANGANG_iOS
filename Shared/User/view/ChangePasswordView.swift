//
//  ChangePasswordView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/22.
//

import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var viewModel: ChangePasswordViewModel
    
    
    init(email: String) {
        self.viewModel = ChangePasswordViewModel(email: email)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0){
                ForEach(self.viewModel.showDialog ? [1,1] : [1,0],id: \.self){ step in
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
            VStack(alignment: .leading){
                Group {
                    HStack{
                        Text("새 비밀번호")
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
                        Text("새 비밀번호 확인")
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
                
                
                Spacer()
                Button(action: {
                    self.viewModel.changePassword()
                }) {
                    HStack{
                        Spacer()
                        Text("비밀번호 변경")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                        Spacer()
                    }.background(!(self.viewModel.checkPassword && self.viewModel.checkValidPassword) ? Color("DisabledBlue") : Color("PrimaryBlue"))
                    .cornerRadius(24.0)
                    
                }
                .disabled(!(self.viewModel.checkPassword && self.viewModel.checkValidPassword))
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 28)
                .alert(isPresented: self.$viewModel.showDialog) {
                    Alert(title: Text("비밀번호가 변경되었습니다.").font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("PrimaryBlack")), message: Text("환영합니다.\n한기대 강의평, 이제는 한강에서 만나요!").font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color("PrimaryBlack")), dismissButton: .default(Text("로그인하러 가기")) {
                        
                    }
                          )
                        }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 32)
            .padding(.horizontal,16)
        }
        .navigationTitle("비밀번호 찾기")
        .background(UINavigationConfiguration { nc in
            nc.navigationBar.barTintColor = .white
            nc.navigationBar.shadowImage = UIImage()
            nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryBlack")]
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(email: "wxg1297")
    }
}
