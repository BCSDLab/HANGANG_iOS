//
//  TermsView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import SwiftUI

struct TermsView: View {
    @ObservedObject var viewModel: TermsViewModel
    @Binding var rootIsActive : Bool
    
    init(rootIsActive: Binding<Bool>) {
        self._rootIsActive = rootIsActive
        self.viewModel = TermsViewModel()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0){
                ForEach([0,0,0,0],id: \.self){ step in
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
            VStack(alignment: .leading, spacing: 0) {
                
                Text("약관 동의")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
                    .padding(.bottom, 8)
                HStack(spacing: 0){
                    Button(action: {
                        self.viewModel.all.toggle()
                    }) {
                        Image(systemName: self.viewModel.all ? "circlebadge.fill" :"circlebadge")
                            .foregroundColor(self.viewModel.all ? Color("PrimaryBlue") : Color("CheckboxBorderColor"))
                            .frame(width: 16, height: 16)
                            .padding([.top, .bottom, .trailing], 8)
                    }
                    Text("아래 약관에 모두 동의합니다")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color("PrimaryBlack"))
                }
                HStack(spacing: 0){
                    Button(action: {
                        self.viewModel.privacy.toggle()
                    }) {
                        Image(systemName: self.viewModel.privacy ? "circlebadge.fill" :"circlebadge")
                            .foregroundColor(self.viewModel.privacy ? Color("PrimaryBlue") : Color("CheckboxBorderColor"))
                            .frame(width: 16, height: 16)
                            .padding([.top, .bottom, .trailing], 8)
                    }
                    Text("개인정보 이용약관(필수)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color("PrimaryBlack"))
                }
                HStack(spacing: 0){
                    Button(action: {
                        self.viewModel.hangang.toggle()
                    }) {
                        Image(systemName: self.viewModel.hangang ? "circlebadge.fill" :"circlebadge")
                            .foregroundColor(self.viewModel.hangang ? Color("PrimaryBlue") : Color("CheckboxBorderColor"))
                            .frame(width: 16, height: 16)
                            .padding([.top, .bottom, .trailing], 8)
                    }
                    Text("한강 이용약관(필수)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color("PrimaryBlack"))
                }
                Spacer()
                // 로그인 버튼을 누르면
                /*
                 HStack{
                     Spacer()
                     Text("다음")
                         .font(.system(size: 14, weight: .medium))
                         .foregroundColor(Color.white)
                         .padding(.vertical, 10)
                     Spacer()
                 }
                 */
                NavigationLink(
                    destination: EmailCheckView(
                        rootIsActive: self.$rootIsActive
                    )){
                    HStack{
                        Spacer()
                        Text("다음")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                        Spacer()
                    }.frame(maxWidth:.infinity)
                    .background((self.viewModel.privacy && self.viewModel.hangang) ? Color("PrimaryBlue") : Color("DisabledBlue"))
                    .cornerRadius(24.0)
                }
                .isDetailLink(false)
                .disabled(!(self.viewModel.privacy && self.viewModel.hangang))
                .buttonStyle(PlainButtonStyle())
                
                .padding(.top, 28)
            }
            .padding(.vertical, 32)
            .padding(.horizontal,16)
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle("회원가입")
            .background(UINavigationConfiguration { nc in
                nc.navigationBar.barTintColor = .white
                nc.navigationBar.shadowImage = UIImage()
                nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryBlack")]
            })
            .navigationBarTitleDisplayMode(.inline)
    }
}
