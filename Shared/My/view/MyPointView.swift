//
//  MyPointView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/08.
//

import SwiftUI

struct MyPointView: View {
    @ObservedObject var viewModel: MyPointViewModel
    @State var point: Int
    
    init(token: Token, point: Int) {
        self.viewModel = MyPointViewModel(
        token: token
        )
        self.point = point
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 0) {
                CustomShape()
                    .fill(Color("BorderColor"))
                  .frame(maxWidth: .infinity, minHeight: 1.5, maxHeight: 1.5)
                
                Group{
                    Text("포인트 시스템 안내")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))

                    Text("""
포인트 시스템은 강의평가 서비스와 강의자료 서비스에서 사용하는
가상 포인트를 적립하고, 사용하는 시스템입니다.
포인트 획득을 위해 허위/중복/성의없는 정보를 작성할 경우,
허위 신고하는 경우, 그 외 부적절한 방법으로 포인트 시스템을
남용하는 경우에 서비스 이용이 영구 제한될 수 있습니다.
""").font(.system(size: 12))
                        
                        .fontWeight(.regular)
                        .foregroundColor(Color("DisableColor"))
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                }
                Group{
                    Text("포인트 적립 & 사용")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                    
                    HStack(spacing: 0){
                        Text("""
- 가입시 기본 지급
- 강의평가 작성
- 강의자료 업로드
- 강의자료 구입
""").font(.system(size: 12))
                            .fontWeight(.regular)
                            .lineSpacing(8)
                            .foregroundColor(Color("PrimaryBlack"))
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
                        Text("""
+ 300P
+ 30P
+ 70P
- 100P
""").font(.system(size: 12))
                            .fontWeight(.medium)
                            .lineSpacing(8)
                            .foregroundColor(Color("DisableColor"))
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
                    }.padding(.bottom, 27)
                }
                
                Divider()
                
                Group{
                    Text("내 포인트 내역")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                    HStack{
                        Text("\(self.point)P")
                            .fontWeight(.medium)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .frame(height: 36)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        Spacer()
                    }.padding(.horizontal, 16)
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(8)
                    .padding(16)
                }
                
                List(self.viewModel.pointList ?? [], id: \.self) { point in
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(point.title)")
                                .font(.system(size: 14))
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 2, trailing: 0))
                            
                            Text("\(point.createdAt.stringToDate.getmdhm)")
                                .font(.system(size: 12))
                                .foregroundColor(Color("DisableColor"))
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 0))
                        }
                        Spacer()
                        Text("\(point.variance > 0 ? "+" : "-") \(point.variance)P")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(Color("DisableColor"))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                    }.listRowInsets(EdgeInsets())
                        
                }.animation(.easeInOut)
                .transition(.opacity)
                .listStyle(PlainListStyle())
                    
                
            }.frame(width: geometry.size.width, alignment: .leading)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("내 포인트", displayMode: .inline)
        .background(UINavigationConfiguration { nc in
            nc.navigationBar.barTintColor = .white
            nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryBlack")]
        })
    }
}

struct MyPointView_Previews: PreviewProvider {
    static var previews: some View {
        MyPointView(token: Token(), point: 0)
    }
}
