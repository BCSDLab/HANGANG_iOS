//
//  MyView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/07.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                ScrollView{
                    VStack{
                        Text("Bada")
                                .fontWeight(.medium)
                                .font(.system(size: 18))
                                .foregroundColor(Color("PrimaryBlack"))
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 0))
                            .frame(width: geometry.size.width, alignment: .leading)
                        Text("컴퓨터공학부")
                                .fontWeight(.regular)
                                .font(.system(size: 12))
                                .foregroundColor(Color("DisableColor"))
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0))
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        HStack{
                            Text("120P")
                                .fontWeight(.medium)
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(height: 36)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                        }
                        .padding(.horizontal, 16)
                        .frame(width: geometry.size.width - 32)
                        .background(Color("PrimaryBlue"))
                        .cornerRadius(8)
                        
                        HStack(spacing: 32){
                            ForEach(0..<5) { index in
                                if(index % 2 == 0) {
                                    VStack(spacing: 0){
                                        Text("16")
                                            .fontWeight(.medium)
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 24, alignment: .center)
                                            .padding(.bottom, 2)
                                        
                                        Text("강의평가")
                                                .fontWeight(.regular)
                                                .font(.system(size: 12))
                                                .foregroundColor(Color("DisableColor"))
                                            .frame(height: 18)
                                    }
                                } else {
                                    Divider()
                                        .frame(height: 16)
                                }


                            }
                        }.padding(.vertical, 24)
                        Divider()


                    }
                }.frame(width: geometry.size.width, alignment: .leading)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitle("", displayMode: .inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: SearchView()) {
                                    Image("Config")
                                }
                            }
                        }
                        .background(UINavigationConfiguration { nc in
                            nc.navigationBar.barTintColor = .white
                            nc.navigationBar.shadowImage = UIImage()
                            nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                        })
            }
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
