//
//  EditMyView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/16.
//

import SwiftUI

struct EditMyView: View {
    @ObservedObject var viewModel: EditMyViewModel
    
    var majorList: [String] = [
        "기계공학부",
        "디자인·건축공학부",
        "메카트로닉스공학부",
        "산업경영학부",
        "에너지신소재화학공학부",
        "전기전자통신공학부",
        "컴퓨터공학부"
    ]
    
    @State var isSheetShown = false
    
    
    init(user: User?) {
        self.viewModel = EditMyViewModel(
            email: user?.portalAccount ?? "",
            name: user?.name ?? "",
            nickname: user?.nickname ?? "",
            majors: user?.major ?? []
        )
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading){
                Group {
                    Text("이름 (학번)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(.bottom, 14)
                        .padding(.top, 32)
                    HStack{
                        if(self.viewModel.isEdit) {
                            TextField("이름 (학번)", text: self.$viewModel.name)
                                .autocapitalization(.none)
                                .font(.system(size: 15, weight: .medium))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        } else {
                            Text(self.viewModel.name.isEmpty ? "이름과 학번을 입력해주세요" : self.viewModel.name)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    Divider()
                        .background(self.viewModel.isEdit ? Color("PrimaryBlue") : Color("BorderColor"))
                }
                
                Group {
                    Text("아이디")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(.bottom, 14)
                        .padding(.top, 32)
                    HStack {
                        Text(self.viewModel.email)
                            .font(.system(size: 15))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            Spacer()
                    }
                    Divider()
                        .background(Color("BorderColor"))
                }
                
                
                Group {
                    Text("닉네임")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(.bottom, 14)
                        .padding(.top, 32)
                    HStack {
                        if(self.viewModel.isEdit) {
                            TextField("10자 미만", text: self.$viewModel.nickname)
                                .onChange(of: self.viewModel.nickname, perform: { value in
                                    self.viewModel.checkNickname()
                                })
                                .autocapitalization(.none)
                                .font(.system(size: 15))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                
                            if((self.viewModel.nicknameCheckResult.message ?? "") == "사용 가능한 닉네임입니다.") {
                                Image(systemName: "checkmark")
                                                    .foregroundColor(.green)
                            } else if((self.viewModel.nicknameCheckResult.message ?? "").isEmpty){
                                Image(systemName: "exclamationmark.triangleff")
                                                    .foregroundColor(Color("PrimaryOrenge"))
                            } else {
                                Image(systemName: "exclamationmark.triangle")
                                                    .foregroundColor(Color("PrimaryOrenge"))
                            }
                        } else {
                            Text(self.viewModel.nickname.isEmpty ? "닉네임을 입력해주세요" : self.viewModel.nickname)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    Divider()
                        .background(self.viewModel.isEdit ? Color("PrimaryBlue") : Color("BorderColor"))
                }
                
                Group {
                    Text("전공")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(.bottom, 14)
                        .padding(.top, 32)
                    VStack {
                        if(self.viewModel.isEdit) {
                            ForEach(self.viewModel.majors, id: \.self) { major in
                                VStack(alignment: .leading) {
                                    Text(major)
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    Divider()
                                        .background(self.viewModel.isEdit ? Color("PrimaryBlue") : Color("BorderColor"))
                                }
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            Button(action: {
                                self.isSheetShown = true
                            }) {
                                HStack(alignment: .center){
                                    Image(systemName: "plus")
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 4)
                                    Text("전공 추가하기")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("PrimaryBlue"))
                                        
                                    Spacer()
                                }
                            }.bottomSheet(isPresented: self.$isSheetShown, height: geometry.size.height / 2) {
                                VStack {
                                    Text("전공 선택")
                                    
                                    
                                }
                                .background(Color.white)
                                .foregroundColor(.white)
                            }
                            
                        } else {
                            ForEach(self.viewModel.majors, id: \.self) { major in
                                VStack(alignment: .leading) {
                                    Text(major)
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    Divider()
                                        .background(self.viewModel.isEdit ? Color("PrimaryBlue") : Color("BorderColor"))
                                }
                                    
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    
                    
                }
                Spacer()
                
            }
            .padding(16)
            .navigationTitle("내 정보")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.viewModel.toggleEdit()
                    }) {
                        
                        if(self.viewModel.isEdit) {
                            Text("저장")
                        } else {
                            Text("수정")
                        }
                    }
                }
            }
            .background(UINavigationConfiguration { nc in
                nc.navigationBar.barTintColor = .white
                nc.navigationBar.shadowImage = UIImage()
                
                nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryBlack")]
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

