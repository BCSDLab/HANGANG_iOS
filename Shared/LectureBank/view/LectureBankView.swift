//
//  LectureBankView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/21.
//

import SwiftUI

struct LectureBankView: View {
    @ObservedObject var viewModel: LectureBankViewModel
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
    
    var sortList: [Order] = [
        Order(
            id: "id",
            name: "최신순"
        ),
        Order(
            id: "hits",
            name: "좋아요순"
        ),
    ]
    
    var typeList: [String] = [
        "기출자료",
        "필기자료",
        "과제자료",
        "강의자료",
        "기타자료"
    ]
    
    @State var showingFilterSheet: Bool = false
    
    init() {
        self.viewModel = LectureBankViewModel()
    }
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack {
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
                            
                            ForEach(self.viewModel.lectureBankResult, id: \.self) { lectureBank in
                                
                                NavigationLink(destination: LectureBankDetailView(
                                    lectureBankId: lectureBank.id
                                )) {
                                    HStack(spacing: 0){
                                        /*AsyncImage(url: URL(string: "https://picsum.photos/102")!,
                                                       placeholder: { Text("Loading ...") },
                                                       image: { Image(uiImage: $0).resizable()})*/
                                            
                                        
                                        VStack {
                                            Image("\(lectureBank.uploadFiles?.first?.ext ?? "txt")")
                                                .resizable()
                                                .frame(width: 33, height: 33)
                                        }
                                        .frame(width: 102, height: 102)
                                        .cornerRadius(8, corners: [.topLeft, .bottomLeft])
                                        
                                        VStack(alignment: .leading, spacing: 0){
                                            HStack(spacing: 0){
                                                Text(lectureBank.title)
                                                        .font(.system(size: 14))
                                                        .fontWeight(.medium)
                                                        .foregroundColor(Color("PrimaryBlack"))
                                                        .frame(height: 21)
                                                    Spacer()
                                                Text("\(lectureBank.category.joined(separator: ", "))")
                                                        .font(.system(size: 12))
                                                        .fontWeight(.regular)
                                                        .foregroundColor(Color("PrimaryBlue"))
                                                        .frame(height: 18)
                                                }
                                            Text(lectureBank.user.nickname)
                                                .font(.system(size: 12))
                                                .fontWeight(.regular)
                                                .foregroundColor(Color("PrimaryBlack"))
                                                .frame(height: 18)
                                                Spacer()
                                                
                                            HStack(alignment:.bottom,spacing: 0){
                                                Text("\(lectureBank.lecture.name)")
                                                    .font(.system(size: 12))
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("DisableColor"))
                                                    .frame(height: 18)
                                                Text(" | ")
                                                    .font(.system(size: 12))
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("DisableColor"))
                                                    .frame(height: 18)
                                                Text("\(lectureBank.lecture.professor)")
                                                    .font(.system(size: 12))
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color("DisableColor"))
                                                    .frame(height: 18)
                                                Spacer()
                                                Image("ThumbUp")
                                                    .frame(width: 16, height: 16)
                                                    .padding(.trailing, 4)
                                                
                                                Text("\(lectureBank.hits)")
                                                        .font(.system(size: 12))
                                                        .fontWeight(.regular)
                                                        .foregroundColor(Color("DisableColor"))
                                                        .frame(height: 18)
                                                }
                                        }.padding(9)
                                    }
                                        .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color("BorderColor"), lineWidth: 1)
                                        )
                                    .padding(.horizontal, 16)
                                }

                            }
                        }
                    }.padding(.top, 16)
                    
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            NavigationLink(destination: UploadLectureBankView(), label: {
                                Image("Edit")
                                    .padding(12)
                            })
                            .background(Color("PrimaryBlue"))
                            .cornerRadius(38.5)
                            .padding(.bottom, 24)
                            .padding(.trailing, 16)
                            
                            
                        }
                    }
                    
                }.navigationBarTitleDisplayMode(.inline)
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
                                    self.viewModel.sort = a.id
                                    
                                }) {
                                    Text("\(a.name)")
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundColor(self.viewModel.sort == a.id ? .white : Color("PrimaryBlack"))
                                        .frame(width: 76, height: 32)
                                        
                                }
                                .background(self.viewModel.sort == a.id ? Color("PrimaryBlue") : Color("BorderColor"))
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
                                    if(self.viewModel.categories.contains(a)) {
                                        let index = self.viewModel.categories.firstIndex(of: a)
                                        self.viewModel.categories.remove(at: index!)
                                    } else {
                                        self.viewModel.categories.append(a)
                                    }
                                    
                                    
                                    
                                }) {
                                    Text("\(a)")
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundColor(self.viewModel.categories.contains(a) ? .white : Color("PrimaryBlack"))
                                        .frame(width: 76, height: 32)
                                        
                                }
                                .background(self.viewModel.categories.contains(a) ? Color("PrimaryBlue") : Color("BorderColor"))
                                .cornerRadius(20.0)
                                .animation(.easeInOut)
                            }
                        }.padding(.horizontal, 16)
                    }
                }
                
                Spacer()
            }.padding(.vertical, 24)
        }
        
    }
}

struct LectureBankView_Previews: PreviewProvider {
    static var previews: some View {
        LectureBankView()
    }
}
