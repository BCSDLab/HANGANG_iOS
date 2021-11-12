//
//  TimeTableView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/01.
//

import SwiftUI
import ElliotableSwiftUI
import BottomSheet
import PartialSheet

struct TimeTableView: View {
    //@State private var query: String = ""
    @State var isSheetShown = false
    @State var isMenuSheet = false
    @State var isNameChangeSheet = false
    @State var isNotDeleteTimeTable = false
    @State var changeTimeTableName = ""
    @State var timeTableRect: CGRect = .zero

    @ObservedObject var viewModel: TimeTableViewModel
    @State var timeTableView: ElliotableView = ElliotableView(
            data: []
    )
    
    init() {
        self.viewModel = TimeTableViewModel()
    }

    func generateTimetableView() {
        let tView = ElliotableView(
                data: self.viewModel.timeTableLecture.flatMap({ lecture in
                    lecture.event
                })
        )
        /*
         dayCount: Int,
            borderColor: Color,
            symbolBackgroundColor: Color,
            itemBackgroundColor: Color,
            symbolHeaderTextColor: Color,
            timeHeaderTextColor: Color,
            daySymbols: [String],
            header: CGFloat,
            item: CGFloat
         */



        //MARK: 초반에는 저장된 데이터 가져오는 걸로 함(데이터 로딩문제 개선)
        /*tView.dayCount(count: 5)
        tView.daySymbols(symbols: daySymbols)
        tView.borderColor(color: Color("BorderColor"))
        tView.headerFont(font: .system(size: 12))
        tView.symbolBackgroundColor(color: .white)
        tView.timeHeaderTextColor(color: Color("PrimaryBlack"))
        tView.timeFont(font: .system(size: 10))*/
        //var courseList: [ElliottEvent] = []


        //print("CourseList: \(courseList)")
        //tView.courseList(list: )

        self.timeTableView = tView
    }
    
    
    
    var body: some View {

        GeometryReader { geometry in
            NavigationView {
                ZStack{
                    self.timeTableView
                    .onReceive(self.viewModel.objectWillChange) {
                        generateTimetableView()
                    }



                    VStack {
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
                    }.sheet(isPresented: self.$isSheetShown) {
                        TimeTableLectureView()
                                .environmentObject(self.viewModel)
                        
                    }
                    
                    

                }.background(Color.white)
                        .actionSheet(isPresented: self.$isMenuSheet) {
                     ActionSheet(title: Text(""),
                             buttons: [
                                 .default(Text("메인 시간표 설정")) {
                                     self.viewModel.setMainTimeTable()
                                 },
                                 .default(Text("이미지로 저장")) {
                                     let image = self.timeTableView.snapshot()

                                     UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                                 },
                                 .default(Text("이름 수정")) {
                                     self.isMenuSheet = false
                                     self.isNameChangeSheet = true
                                 },
                                 .default(Text("시간표 삭제")) {
                                    // 메인시간표면 삭제X
                                     if(self.viewModel.mainTimeTable == self.viewModel.selectedTimeTable) {
                                         self.isNotDeleteTimeTable = true
                                     } else {
                                         self.viewModel.deleteMainTimeTable()
                                     }
                                 },
                                 .cancel()
                             ])
                }
                        .alert(isPresented:  self.$isNameChangeSheet, TextAlert(title: "시간표 이름 수정",
                                message: "",
                                keyboardType: .default) { result in
                            self.viewModel.changeMainTimeTableName(name: result ?? "")
                        })
                        .alert(isPresented:  self.$isNotDeleteTimeTable) {
                            Alert(title: Text("시간표를 삭제할 수 없습니다."), message: Text("메인 시간표는 삭제가 불가능합니다."))
                        }
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            NavigationLink(
                                    destination: SelectTimeTableView()
                                    .environmentObject(self.viewModel)
                            ){
                                Image(systemName: "list.dash")
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .accentColor(Color("PrimaryBlack"))
                            }
                            Text(self.viewModel.semesters.first { semester in
                                return ((Int(self.viewModel.selectedTimeTable?.tableSemesterDate ?? "") ?? -1) == semester.id)
                            }?.semester ?? "")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.isMenuSheet = true
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

struct RectGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }

    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}
