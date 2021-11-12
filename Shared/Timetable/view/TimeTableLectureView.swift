//
//  TimeTableLectureView.swift
//  hangang
//
//  Created by 정태훈 on 2021/08/29.
//
//

import SwiftUI

struct TimeTableLectureView: View {
    @EnvironmentObject var viewModel: TimeTableViewModel
    @State var searchQuery: String = ""
    @State var major: String = "교양학부"
    let majorList: [String] = [
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
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                HStack{
                    TextField("교과명, 교수명, 키워드 검색", text: self.$searchQuery, onCommit: {
                        self.viewModel.search(query: self.searchQuery, department: self.major)
                    })
                            .padding(12)
                            .frame(maxWidth: 275, alignment: .leading)
                            .foregroundColor(.black)
                }
                        .frame(width: geometry.size.width - 32, alignment: .leading)
                        .background(Color("BorderColor"))
                        .cornerRadius(8.0)
                        .padding(.top, 16)
                ZStack{
                    ScrollView(.horizontal){
                        HStack(spacing: 8){
                            ForEach(self.majorList, id: \.self) { major in
                                Button(action: {
                                    self.major = major
                                    self.viewModel.search(query: self.searchQuery, department: self.major)
                                }) {
                                    Text(major)
                                            .font(.system(size: 14))
                                            .foregroundColor(self.major == major ?
                                                    .white : Color("PrimaryBlack"))
                                            .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                                }.background(self.major == major ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20)
                            }

                        }.padding(.horizontal, 8)
                                .padding(.trailing, 60)
                    }
                    /*HStack(spacing: 0){
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
                    }*/
                }.frame(height: 48)
                VStack(alignment: .center, spacing: 0){


                    List(self.viewModel.lectureResult, id: \.self) { lecture in
                        Button(action: {
                            if(self.viewModel.timeTableLecture.contains(lecture)) {
                                self.viewModel.deleteLecture(lecture: lecture)
                            } else {
                                self.viewModel.addLecture(lecture: lecture)
                            }
                        }) {
                            LectureListItem(lecture: lecture)
                                    .environmentObject(self.viewModel)

                        }.listRowInsets(EdgeInsets(
                                top: 16, leading: 16, bottom: 16, trailing: 16
                        )).onAppear {
                            if(lecture == self.viewModel.lectureResult.last) {
                                self.viewModel.fetch()
                            }
                        }


                    }.animation(.easeInOut)
                            .transition(.opacity)
                            .listStyle(PlainListStyle())


                }
                        .background(Color.white)
                        .foregroundColor(.white)
            }.onReceive(self.viewModel.objectWillChange) {

            }
        }
    }
}

struct TimeTableLectureView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableLectureView()
    }
}
