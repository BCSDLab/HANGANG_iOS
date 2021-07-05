//
//  TimeTableView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/01.
//

import SwiftUI
import ElliotableSwiftUI
import BottomSheet


struct TimeTableView: View {
    @State private var query: String = ""
    @State var isSheetShown = false
    @ObservedObject var viewModel: TimeTableViewModel
    
    let daySymbols = ["월", "화", "수", "목", "금", "토", "일"]
    
    init() {
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        
        self.viewModel = TimeTableViewModel(
        token: Token(
            refresh_token: "",
            access_token: accessToken ?? ""
            )
        )
        
    }
    
    func generateTimetableView() -> ElliotableView {
        let view = ElliotableView()
        view.dayCount(count: 5)
        view.daySymbols(symbols: daySymbols)
        view.borderColor(color: Color("BorderColor"))
        view.headerFont(font: .system(size: 12))
        view.symbolBackgroundColor(color: .white)
        view.timeHeaderTextColor(color: Color("PrimaryBlack"))
        view.timeFont(font: .system(size: 10))
        
            
            let courseList = [
                ElliottEvent(courseId: "217", courseName: "운영체제", courseNum: "03", roomName: "ROOM1", professor: "김덕수", courseDay: .monday, startTime: "09:00", endTime: "11:00", backgroundColor: .systemBlue),
                ElliottEvent(courseId: "217", courseName: "운영체제", courseNum: "03", roomName: "ROOM2", professor: "김덕수", courseDay: .wednesday, startTime: "11:00", endTime: "12:00", backgroundColor: .systemBlue)]
            
            
            /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.viewModel.loadMainTable { (mainTable) in
                    var courseList: [ElliottEvent] = []
                    
                    mainTable!.lectureList.forEach({ lecture in
                        lecture.event.forEach { event in
                            courseList.append(event)
                        }
                    })
                    
                    print("CourseList: \(courseList)")
                
                    
            }
            
        }*/
        view.courseList(list: courseList)
        return view
    }
    
    
    var body: some View {

        return GeometryReader { geometry in
            NavigationView {
                ZStack{
                    generateTimetableView()
                        .background(Color.white)
                        
                        
                    
                    /*VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                self.isSheetShown = true
                            }, label: {
                                Image("Edit")
                                    .padding(12)
                            })
                            .background(Color("PrimaryBlue"))
                            .cornerRadius(38.5)
                            .padding(.bottom, 24)
                            .padding(.trailing, 16)
                            
                            
                        }
                    }.bottomSheet(isPresented: self.$isSheetShown, height: geometry.size.height / 2) {
                        VStack{
                            HStack{
                                TextField("교과명, 교수명, 키워드 검색", text: self.$viewModel.query)
                                    .onChange(of: self.viewModel.query, perform: { value in
                                        self.viewModel.search()
                                    })
                                    .padding(12)
                                    .frame(maxWidth: 275, alignment: .leading)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                Image("SearchIcon")
                                    .padding(.trailing, 10)
                            }
                            .frame(width: geometry.size.width - 32, alignment: .leading)
                            .background(Color("BorderColor"))
                            .cornerRadius(8.0)
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
                                        Button(action: {
                                            
                                        }) {
                                            Image("Adjust")
                                                .renderingMode(.original)
                                                .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 16))
                                        }
                                    }
                                        .frame(width: 48).background(Color.white)
                                }
                            }.frame(height: 50)
                            
                            List(self.viewModel.lectureResult, id: \.self) { lecture in
                                Button(action: {
                                    self.viewModel.addLecture(lectureId: lecture.id)
                                }) {
                                    LectureListItem(lecture: lecture)
                                }.listRowInsets(EdgeInsets())
                                    
                            }.animation(.easeInOut)
                            .transition(.opacity)
                            .listStyle(PlainListStyle())
                            
                            
                        }
                        .background(Color.white)
                        .foregroundColor(.white)
                    }*/
                    
                    
                        
                }
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Button(action: {
                                
                            }){
                                Image(systemName: "list.dash")
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .accentColor(Color("PrimaryBlack"))
                            }
                            Text("2020년 2학기(1)")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color("PrimaryBlack"))
                                .accentColor(Color("PrimaryBlack"))
                        }
                    }
                }.background(UINavigationConfiguration { nc in
                    nc.navigationBar.barTintColor = .white
                    nc.navigationBar.shadowImage = UIImage()
                    nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                })
            }
        }
    }
}

struct TimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableView()
            
    }
}
