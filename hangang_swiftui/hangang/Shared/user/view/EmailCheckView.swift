//
//  SignUpView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import SwiftUI

struct EmailCheckView: View {
    @State var email: String = ""
    @State var authNumber: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("학교 이메일 인증")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("PrimaryBlack"))
            HStack {
                TextField("학교 이메일을 적어주세요.", text: $email)
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
                    TextField("학교 이메일로 인증번호가 전송됩니다.", text: $authNumber)
                        .font(.system(size: 14, weight: .medium))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Divider()
                }
                
                Button(action: {
                    
                }) {
                    Text("인증번호 전송")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                }
                .buttonStyle(PlainButtonStyle())
                .background(Color("PrimaryBlue"))
                .cornerRadius(24.0)
                    
                
            }
            Spacer()
            Button(action: {
                //self.viewModel.login()
            }) {
                HStack{
                    Spacer()
                    Text("인증완료")
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

struct EmailCheckView_Previews: PreviewProvider {
    static var previews: some View {
        EmailCheckView()
    }
}
