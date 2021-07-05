//
//  MajorView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/17.
//

import SwiftUI

struct MajorView: View {
    @ObservedObject var viewModel: MajorViewModel
    @Binding var rootIsActive : Bool
    
    var majorList: [String] = [
        "기계공학부",
        "디자인ㆍ건축공학부",
        "메카트로닉스공학부",
        "산업경영학부",
        "에너지신소재화학공학부",
        "전기ㆍ전자ㆍ통신공학부",
        "컴퓨터공학부"
    ]
    
    init(password: String, email: String, nickname: String, rootIsActive: Binding<Bool>) {
        self.viewModel = MajorViewModel(email: email, password: password, nickname: nickname)
        self._rootIsActive = rootIsActive
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0){
                ForEach(self.viewModel.showDialog ? [1,1,1,1] : [1,1,1,0],id: \.self){ step in
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
            VStack(alignment: .leading, spacing: 16) {
                
                Text("전공 선택")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("PrimaryBlack"))
                ForEach(majorList, id: \.self) { major in
                    HStack{
                        Button(action: {
                            if(self.viewModel.selectedMajor.contains(major)) {
                                if let index = self.viewModel.selectedMajor.firstIndex(of: major) {
                                    self.viewModel.selectedMajor.remove(at: index)
                                }
                            } else {
                                self.viewModel.selectedMajor.append(major)
                            }
                        }) {
                            Image(systemName: self.viewModel.selectedMajor.contains(major) ? "circlebadge.fill" :"circlebadge")
                                .foregroundColor(self.viewModel.selectedMajor.contains(major) ? Color("PrimaryBlue") : Color("CheckboxBorderColor"))
                                .frame(width: 16, height: 16)
                        }
                        Text(major)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color("PrimaryBlack"))
                    }
                }
                Spacer()
                // 로그인 버튼을 누르면
                Button(action: {
                    self.viewModel.signUp()
                }) {
                    HStack{
                        Spacer()
                        Text("완료")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                        Spacer()
                    }
                }
                .disabled(self.viewModel.selectedMajor.isEmpty)
                .buttonStyle(PlainButtonStyle())
                .background(Color("PrimaryBlue"))
                .background(self.viewModel.selectedMajor.isEmpty ? Color("DisabledBlue") : Color("PrimaryBlue"))
                .cornerRadius(24.0)
                .padding(.top, 28)
                .alert(isPresented: self.$viewModel.showDialog) {
                    Alert(title: Text("회원가입이 완료되었습니다.").font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("PrimaryBlack")), message: Text("\(self.viewModel.nickname)님!\n한기대의 강의평가를 보러 가볼까요?").font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color("PrimaryBlack")), dismissButton: .default(Text("로그인하러 가기")) {
                                    self.rootIsActive = false
                    }
                          )
                        }
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

