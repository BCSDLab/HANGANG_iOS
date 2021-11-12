//
//  SelectTimeTableView.swift
//  hangang
//
//  Created by 정태훈 on 2021/08/08.
//
//

import SwiftUI

struct SelectTimeTableView: View {
    @EnvironmentObject var timeTableViewModel: TimeTableViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24){
                HStack {
                    Text("※ 학기 당 5개, 총 50개의 시간표를 추가할 수 있습니다.")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DisableColor"))
                    Spacer()
                    Text("\(self.timeTableViewModel.timeTables.count)/50")
                            .font(.system(size: 12))
                            .foregroundColor(Color("PrimaryBlack"))
                }.padding([.top, .leading, .trailing], 16)

                ForEach(self.timeTableViewModel.semesters, id: \.self) { s in
                    if(self.timeTableViewModel.timeTables.contains(where: { t in
                        return t.semesterDateID == s.id
                    })) {
                        VStack(alignment: .leading, spacing: 24){
                            Text("\(s.semester)")
                                    .fontWeight(.medium)
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .padding(.leading, 16)
                            ForEach(self.timeTableViewModel.timeTables.filter { t in
                                return t.semesterDateID == s.id
                            }, id: \.self) { t in
                                Button(action: {
                                    self.timeTableViewModel.getTimeTable(timeTableId: t.id)
                                }) {
                                    HStack(spacing: 0) {
                                        Text("\(t.name)")
                                                .font(.system(size: 14))
                                                .foregroundColor(
                                                        (self.timeTableViewModel.selectedTimeTable?.id ?? -1) == t.id ?
                                                                Color("PrimaryBlue"):
                                                                Color("PrimaryBlack")
                                                )
                                        if((self.timeTableViewModel.mainTimeTable?.id ?? -1) == t.id) {
                                            Image("TimetableCheck")
                                                    .renderingMode(.original)
                                                    .padding(.leading, 8)
                                        }

                                        Spacer()
                                    }

                                }.padding(.leading, 16)
                            }
                            Divider()
                                .foregroundColor(Color("BorderColor"))

                        }
                    }
                }.onReceive(self.timeTableViewModel.objectWillChange) {

                }

            }
        }.navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    /*ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {

                        }){
                            Image(systemName: "list.dash")
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .accentColor(Color("PrimaryBlack"))
                        }
                    }*/
                    ToolbarItem(placement: .principal) {
                        Text("시간표 목록")
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {

                        }) {
                            Text("추가")
                        }
                    }
                }.background(UINavigationConfiguration { nc in
                    nc.navigationBar.barTintColor = .white
                    nc.navigationBar.shadowImage = UIImage()
                    nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                })
    }
}

struct SelectTimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTimeTableView()
    }
}
