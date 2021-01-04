//
//  ContentView.swift
//  Shared
//
//  Created by 정태훈 on 2020/12/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                ScrollView{
                    VStack{
                        Text("강의랭킹")
                            .fontWeight(.medium)
                            .font(.system(size: 16))
                            .foregroundColor(Color("PrimaryBlack"))
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
                            .frame(width: geometry.size.width, alignment: .leading)
                        VStack(spacing: 0){
                            ScrollView(.horizontal){
                                HStack(spacing: 16){
                                    ForEach(0..<10) { index in
                                        Text("교양")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("DisableColor"))
                                            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                                    }
                                }.padding(.horizontal, 8)
                            }
                            ForEach(0..<9) { index in
                                if(index % 2 == 0) {
                                    HStack{
                                        Text("\((index / 2) + 1)")
                                            .fontWeight(.medium)
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .padding(.trailing, 16)
                                        VStack(alignment: .leading){
                                            Text("사랑의 역사")
                                                .fontWeight(.medium)
                                                .font(.system(size: 14))
                                                .foregroundColor(Color("PrimaryBlack"))
                                            Text("김사랑")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color("DisableColor"))
                                        }
                                        Spacer()
                                        Text("4.2")
                                            .fontWeight(.medium)
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("PrimaryBlack"))
                                    }.padding(16)
                                } else {
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color("BorderColor"))
                                }
                                
                                
                            }
                        }
                        .frame(width: geometry.size.width - 32)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("BorderColor"), lineWidth: 1)
                                )
                        .padding(.horizontal, 16)
                        
                        Text("학부별 탐색")
                            .fontWeight(.medium)
                            .font(.system(size: 16))
                            .foregroundColor(Color("PrimaryBlack"))
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        ScrollView(.horizontal){
                            HStack(spacing: 8){
                                ForEach(0..<10) { index in
                                    VStack {
                                        
                                    }.frame(width: 87, height: 87, alignment: .bottom)
                                    .background(Color("BorderColor"))
                                    .cornerRadius(8)
                                }
                            }.padding(.horizontal, 16)
                        }
                        
                        Text("내 시간표")
                            .fontWeight(.medium)
                            .font(.system(size: 16))
                            .foregroundColor(Color("PrimaryBlack"))
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
                            .frame(width: geometry.size.width, alignment: .leading)
                    }
                }.frame(width: geometry.size.width, alignment: .leading)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack{
                            Text("한강")
                                .font(.custom("NanumSquareRoundOTFEB", size: 20))
                                .foregroundColor(Color("PrimaryBlue"))
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SearchView()) {
                            Image("SearchIcon")
                        }
                    }
                }
                .background(UINavigationConfiguration { nc in
                    nc.navigationBar.barTintColor = .white
                    /*nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)*/
                    nc.navigationBar.shadowImage = UIImage()
                    nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                            })
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
