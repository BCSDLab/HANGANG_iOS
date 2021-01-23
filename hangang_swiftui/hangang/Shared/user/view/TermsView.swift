//
//  TermsView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import SwiftUI

struct TermsView: View {
    @State var all: Bool = false
    @State var privacy: Bool = false
    @State var hangang: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("약관 동의")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("PrimaryBlack"))
            HStack{
                Circle()
                    .stroke(self.all ? Color.white : Color("CheckboxBorderColor"), lineWidth: 1)
                    .background(self.all ? Color("PrimaryBlue") : Color.white)
                    .frame(width: 12, height: 12)
                    .onTapGesture {
                        print("toggle")
                        self.all.toggle()
                    }
                Text("아래 약관에 모두 동의합니다")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
            }
            HStack{
                Circle()
                    .stroke(self.privacy ? Color.white : Color("CheckboxBorderColor"), lineWidth: 1)
                    .background(self.privacy ? Color("PrimaryBlue") : Color.white)
                    .frame(width: 12, height: 12)
                    .onTapGesture {
                        print("toggle")
                        self.privacy.toggle()
                    }
                Text("개인정보 이용약관(필수)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
            }
            HStack{
                Circle()
                    .stroke(self.hangang ? Color.white : Color("CheckboxBorderColor"), lineWidth: 1)
                    .background(self.hangang ? Color("PrimaryBlue") : Color.white)
                    .frame(width: 12, height: 12)
                    .onTapGesture {
                        print("toggle")
                        self.hangang.toggle()
                    }
                Text("한강 이용약관(필수)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
            }
            Spacer()
            // 로그인 버튼을 누르면
            NavigationLink(destination: EmailCheckView()) {
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
        }
            .frame(maxWidth: .infinity, alignment: .leading)
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

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
