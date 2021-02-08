//
//  ReviewView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/08.
//

import SwiftUI

struct ReviewView: View {
    @State var tt: String = ""
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ScrollView{
                    VStack(spacing: 8){
                        ZStack{
                            ScrollView(.horizontal){
                                HStack(spacing: 8){
                                    ForEach(0..<10) { index in
                                        Button(action: {
                                            
                                        }) {
                                            Text("교양")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color("PrimaryBlack"))
                                                    .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                                        }.background(Color("BorderColor"))
                                        .cornerRadius(20)
                                    }
                                }.padding(.horizontal, 8)
                            }
                            HStack(spacing: 0){
                                Spacer()
                                Rectangle()
                                    .frame(width: 48).foregroundColor(.clear)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.0), Color.white]), startPoint: .leading, endPoint: .trailing))
                                VStack{
                                    Button(action: {}) {
                                        Image("Adjust")
                                            .renderingMode(.original)
                                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 16))
                                    }
                                }
                                    .frame(width: 48).background(Color.white)
                            }
                        }
                        
                        ForEach(0..<9) { index in
                            VStack(alignment: .leading, spacing: 0){
                                HStack(spacing: 0){
                                        Text("문명과 역사")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 21)
                                        Text(" (0)")
                                            .font(.system(size: 11))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("DisableColor"))
                                            .frame(height: 16)
                                        Spacer()
                                        Text("교양필수")
                                            .font(.system(size: 12))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("PrimaryBlue"))
                                            .frame(height: 18)
                                    }
                                Text("김사랑")
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .frame(height: 21)
                                    .padding(.bottom, 9)
                                    
                                HStack(alignment:.bottom,spacing: 0){
                                    ForEach(0..<3) { hash in
                                        Text("#배운거 많음 ")
                                            .font(.system(size: 12))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("DisableColor"))
                                            .frame(height: 18)
                                    }
                                        Spacer()
                                        Text("3.5")
                                            .font(.system(size: 20))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 30)
                                    }
                                }.padding(16)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color("BorderColor"), lineWidth: 1)
                                )
                            .padding(.horizontal, 16)

                        }
                    }
                }.padding(.top, 16).navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack{
                            TextField("교과명, 교수명, 과목코드 검색", text: $tt)
                                .padding(12)
                                .frame(maxWidth: 275, alignment: .leading)
                            
                            Spacer()
                            Image("SearchIcon")
                                .padding(.trailing, 10)
                        }
                        .frame(width: geometry.size.width - 32, alignment: .leading)
                        .background(Color("BorderColor"))
                        .cornerRadius(8.0)
                    }
                }.background(UINavigationConfiguration { nc in
                    nc.navigationBar.barTintColor = .white
                    /*nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)*/
                    nc.navigationBar.shadowImage = UIImage()
                    nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                })
            }
        }
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
