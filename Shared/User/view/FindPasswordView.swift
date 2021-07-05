//
//  FindPasswordView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/21.
//

import SwiftUI

struct FindPasswordView: View {
    @ObservedObject var viewModel: FindPasswordViewModel
    
    init() {
        self.viewModel = FindPasswordViewModel()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0){
                ForEach([0,0],id: \.self){ step in
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
                
                Text("학교 이메일 인증")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
                HStack {
                    TextField("학교 이메일을 적어주세요.", text: self.$viewModel.email)
                        .autocapitalization(.none)
                        .font(.system(size: 14, weight: .medium))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                    Text("@ koreatech.ac.kr")
                        .font(.system(size: 14, weight: .regular))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }
                Divider()
                Text("인증번호")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
                    .padding(.top, 32)
                HStack {
                    VStack{
                        TextField("학교 이메일로 인증번호가 전송됩니다.", text: self.$viewModel.secret)
                            .font(.system(size: 14, weight: .medium))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Divider()
                    }
                    
                    Button(action: {
                        self.viewModel.sendEmail()
                    }) {
                        Text(self.viewModel.emailSendResult.httpStatus == nil ? "인증번호 전송" : "재전송")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(self.viewModel.emailSendResult.httpStatus == nil ? Color.white : Color("PrimaryBlue"))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .background(self.viewModel.emailSendResult.httpStatus == nil ? Color("PrimaryBlue") : Color.white)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color("PrimaryBlue"), lineWidth: 1)
                                    )
                            .cornerRadius(24.0)
                    }
                    .disabled(self.viewModel.email.isEmpty)
                    .buttonStyle(PlainButtonStyle())
                    
                        
                    
                }
                Spacer()
                NavigationLink(destination: ChangePasswordView(email: self.viewModel.email), isActive: .constant(!($viewModel.emailCheckResult.wrappedValue.httpStatus == nil))) {
                    HStack{
                        Spacer()
                        Text("인증완료")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                        Spacer()
                    }.background(Color("PrimaryBlue"))
                    .cornerRadius(24.0)
                    
                }.simultaneousGesture(TapGesture().onEnded{
                    self.viewModel.checkEmail()
                        })
                .disabled(self.viewModel.secret.isEmpty)
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 28)
                
            }
            .padding(.vertical, 32)
            .padding(.horizontal,16)
        }.frame(maxWidth: .infinity, alignment: .leading)
        .navigationTitle("비밀번호 찾기")
        .background(UINavigationConfiguration { nc in
            nc.navigationBar.barTintColor = .white
            nc.navigationBar.shadowImage = UIImage()
            nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryBlack")]
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FindPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        FindPasswordView()
    }
}
