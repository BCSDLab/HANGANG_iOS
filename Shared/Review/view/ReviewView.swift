//
//  ReviewView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/08.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var viewModel: ReviewViewModel
    @State var showingFilterSheet: Bool = false
    
    init() {
        self.viewModel = ReviewViewModel()
    }
    
    var majorList: [String] = [
        "교양학부",
        "HRD학과",
        "기계공학부",
        "디자인ㆍ건축공학부",
        "메카트로닉스공학부",
        "산업경영학부",
        "에너지신소재화학공학부",
        "전기ㆍ전자ㆍ통신공학부",
        "컴퓨터공학부"
    ]
    
    var sortList: [String] = [
        "평점순",
        "평가순",
        "최신순"
    ]
    
    var typeList: [String] = [
        "교양필수",
        "교양선택",
        "전공필수",
        "전공선택",
        "MSC필수",
        "MSC선택",
        "HRD필수",
        "HRD선택"
    ]
    
    let hashtag:[HashTag] = [
        HashTag(
            id: 1,
            tag: "그저그러함"
        ),
        HashTag(
            id: 2,
            tag: "학점웰케짜"
        ),
        HashTag(
            id: 3,
            tag: "리얼수면제"
        ),
        HashTag(
            id: 4,
            tag: "수업개빡셈"
        ),
        HashTag(
            id: 5,
            tag: "배운거많음"
        ),
        HashTag(
            id: 6,
            tag: "좋은교수님"
        ),
        HashTag(
            id: 7,
            tag: "진심꿀과목"
        ),
        HashTag(
            id: 8,
            tag: "이거듣지마"
        ),
        HashTag(
            id: 9,
            tag: "조금아쉬움"
        )
    ]
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ScrollView{
                    VStack(spacing: 8){
                        ZStack{
                            ScrollView(.horizontal){
                                HStack(spacing: 8){
                                    ForEach(0..<majorList.count) { index in
                                        Button(action: {
                                            viewModel.department = majorList[index]
                                        }) {
                                            Text(majorList[index])
                                                    .font(.system(size: 14))
                                                    .foregroundColor(viewModel.department == majorList[index] ?
                                                                        .white : Color("PrimaryBlack"))
                                                    .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                                        }.background(viewModel.department == majorList[index] ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20)
                                    }
                                        
                                }.padding(.horizontal, 8)
                                .padding(.trailing, 60)
                            }
                            HStack(spacing: 0){
                                Spacer()
                                Rectangle()
                                    .frame(width: 48).foregroundColor(.clear)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.0), Color.white]), startPoint: .leading, endPoint: .trailing))
                                VStack{
                                    Button(action: {
                                        self.showingFilterSheet = true
                                    }) {
                                        Image("Adjust")
                                            .renderingMode(.original)
                                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 16))
                                    }
                                }
                                    .frame(width: 48).background(Color.white)
                            }
                        }
                        
                        if(viewModel.lectureResult.count > 0) {
                            ForEach(0..<viewModel.lectureResult.count) { index in
                                LectureItem(lecture: viewModel.lectureResult[index])
                            }
                        }
                    }
                }.fullScreenCover(isPresented: self.$showingFilterSheet) {
                    VStack {
                        HStack {
                            Text("필터를 적용해 보세요.")
                                .font(.system(size: 14))
                                .foregroundColor(Color("DisableColor"))
                            Spacer()
                            Button(action: {
                                self.showingFilterSheet = false
                            }) {
                                Image(systemName: "xmark")
                            }
                        }.padding(.horizontal, 16)
                        
                        Group {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("정렬")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                                    Spacer()
                                }
                                
                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 8), count: 4), spacing: 8) {
                                    ForEach(self.sortList, id: \.self) { a in
                                        Button(action: {
                                            self.viewModel.sort = a
                                            
                                        }) {
                                            Text("\(a)")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(self.viewModel.sort == a ? .white : Color("PrimaryBlack"))
                                                .frame(width: 76, height: 32)
                                                
                                        }
                                        .background(self.viewModel.sort == a ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20.0)
                                        .animation(.easeInOut)
                                    }
                                }.padding(.horizontal, 16)
                                
                            }
                        }
                        Group {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("유형")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                                    Spacer()
                                }
                                
                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 8), count: 4), spacing: 8) {
                                    ForEach(self.typeList, id: \.self) { a in
                                        Button(action: {
                                            if(self.viewModel.types.contains(a)) {
                                                let index = self.viewModel.types.firstIndex(of: a)
                                                self.viewModel.types.remove(at: index!)
                                            } else {
                                                self.viewModel.types.append(a)
                                            }
                                            
                                        }) {
                                            Text("\(a)")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(self.viewModel.types.contains(a) ? .white : Color("PrimaryBlack"))
                                                .frame(width: 76, height: 32)
                                                
                                        }
                                        .background(self.viewModel.types.contains(a) ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20.0)
                                        .animation(.easeInOut)
                                    }
                                }.padding(.horizontal, 16)
                            }
                        }
                        Group {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("해시태그")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                                    Spacer()
                                }
                                
                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 8), count: 3), spacing: 8) {
                                    ForEach(self.hashtag, id: \.self) { g in
                                        Button(action: {
                                            if(self.viewModel.hashTags.contains(g.id)) {
                                                let index = self.viewModel.hashTags.firstIndex(of: g.id)
                                                self.viewModel.hashTags.remove(at: index!)
                                            } else {
                                                self.viewModel.hashTags.append(g.id)
                                            }
                                            
                                        }) {
                                            Text("#\(g.tag)")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(self.viewModel.hashTags.contains(g.id) ? .white : Color("PrimaryBlack"))
                                                .frame(width: 109, height: 32)
                                                
                                        }
                                        .background(self.viewModel.hashTags.contains(g.id) ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20.0)
                                        .animation(.easeInOut)
                                    }
                                }.padding(.horizontal, 16)
                            }
                        }
                        Spacer()
                    }.padding(.vertical, 24)
                }
                .padding(.top, 16)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack{
                            TextField("교과명, 교수명, 과목코드 검색", text: self.$viewModel.query)
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
