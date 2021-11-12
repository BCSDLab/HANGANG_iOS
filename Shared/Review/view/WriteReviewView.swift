//
//  WriteReviewView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/19.
//

import SwiftUI
import StarRating
import BottomSheet

struct WriteReviewView: View {
    @ObservedObject var viewModel: WriteReviewViewModel
    @State var writeSucceedDialog: Bool = false
    let grade: [String] = ["", "하", "중", "상"]
    let gradePortion: [String] = ["", "아쉽게주심", "적당히주심", "후하게주심"]
    let assignment:[Assignment] = [
        Assignment(
            id: 1,
            name: "팀플"
        ),
        Assignment(
            id: 2,
            name: "레포트"
        ),
        Assignment(
            id: 3,
            name: "토론"
        ),
        Assignment(
            id: 4,
            name: "퀴즈"
        )]
    
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
    
    @State private var showingSemesterActionSheet: Bool = false
    @State var customConfig = StarRatingConfiguration(
        spacing: 6,
        numberOfStars: 5,
        borderWidth: 0,
        emptyColor: Color("BorderColor"),
        shadowRadius: 0,
        fillColors: [Color("PrimaryOrenge")]
    )
    
    init(lecture: Lecture?) {
        UITextView.appearance().backgroundColor = .clear
        self.viewModel = WriteReviewViewModel(
            lecture: lecture
        )
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    VStack(spacing: 32){
                        VStack(alignment:.leading, spacing: 0) {
                            Text("수강학기")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 24)
                                .padding(.bottom, 16)
                            
                            HStack {
                                Button(action: {
                                    self.showingSemesterActionSheet = true
                                }) {
                                    HStack {
                                        Text("\(self.viewModel.semester?.semester ?? "")")
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("PrimaryBlack"))
                                            .frame(height: 21)
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                    }
                                    .padding(.horizontal, 12)
                                    .frame(width: 160, height: 40)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                    .stroke(Color("BorderColor"), lineWidth: 1)
                                    )
                                }
                                Spacer()
                            }
                        }
                        
                        VStack(alignment:.leading, spacing: 0) {
                            Text("출첵빈도")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 24)
                                .padding(.bottom, 16)
                            
                            HStack(alignment: .center, spacing: 8){
                                ForEach(self.grade.reversed(), id: \.self) { g in
                                    if(g == "") {
                                        EmptyView()
                                    } else {
                                        Button(action: {
                                            self.viewModel.attendanceFrequency = self.grade.firstIndex(of: g)!
                                        }) {
                                            Text("\(g)")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(self.viewModel.attendanceFrequency == self.grade.firstIndex(of: g)! ? .white : Color("PrimaryBlack"))
                                                .frame(width: 64, height: 32)
                                        }
                                        .background(self.viewModel.attendanceFrequency == self.grade.firstIndex(of: g)! ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20.0)
                                        .animation(.easeInOut)
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        VStack(alignment:.leading, spacing: 0) {
                            HStack {
                                Text("과제정보")
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .frame(height: 24)
                                    .padding(.trailing, 8)
                                
                                Text("중복선택")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("DisableColor"))
                                    .frame(height: 18)
                                    
                            }.padding(.bottom, 16)
                            
                            HStack(alignment: .center, spacing: 8){
                                ForEach(self.assignment) { g in
                                    Button(action: {
                                        if(self.viewModel.assignments.contains(g.id)) {
                                            let index = self.viewModel.assignments.firstIndex(of: g.id)
                                            self.viewModel.assignments.remove(at: index!)
                                        } else {
                                            self.viewModel.assignments.append(g.id)
                                        }
                                    }) {
                                        Text("\(g.name)")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(self.viewModel.assignments.contains(g.id) ? .white : Color("PrimaryBlack"))
                                            .frame(width: 64, height: 32)
                                            
                                    }
                                    .background(self.viewModel.assignments.contains(g.id) ? Color("PrimaryBlue") : Color("BorderColor"))
                                    .cornerRadius(20.0)
                                    .animation(.easeInOut)
                                }
                                Spacer()
                            }
                        }
                        
                        VStack(alignment:.leading, spacing: 0) {
                            Text("과제량")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 24)
                                .padding(.bottom, 16)
                            
                            HStack(alignment: .center, spacing: 8){
                                ForEach(self.grade.reversed(), id: \.self) { g in
                                    if(g == "") {
                                        EmptyView()
                                    } else {
                                        Button(action: {
                                            self.viewModel.assignmentAmount = self.grade.firstIndex(of: g)!
                                        }) {
                                            Text("\(g)")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(self.viewModel.assignmentAmount == self.grade.firstIndex(of: g)! ? .white : Color("PrimaryBlack"))
                                                .frame(width: 64, height: 32)
                                        }
                                        .background(self.viewModel.assignmentAmount == self.grade.firstIndex(of: g)! ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20.0)
                                        .animation(.easeInOut)
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        VStack(alignment:.leading, spacing: 0) {
                            Text("시험 난이도")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 24)
                                .padding(.bottom, 16)
                            
                            HStack(alignment: .center, spacing: 8){
                                ForEach(self.grade.reversed(), id: \.self) { g in
                                    if(g == "") {
                                        EmptyView()
                                    } else {
                                        Button(action: {
                                            self.viewModel.difficulty = self.grade.firstIndex(of: g)!
                                        }) {
                                            Text("\(g)")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(self.viewModel.difficulty == self.grade.firstIndex(of: g)! ? .white : Color("PrimaryBlack"))
                                                .frame(width: 64, height: 32)
                                        }
                                        .background(self.viewModel.difficulty == self.grade.firstIndex(of: g)! ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20.0)
                                        .animation(.easeInOut)
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        VStack(alignment:.leading, spacing: 0) {
                            Text("성적비율")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 24)
                                .padding(.bottom, 16)
                            
                            HStack(alignment: .center, spacing: 8){
                                ForEach(self.gradePortion.reversed(), id: \.self) { g in
                                    if(g == "") {
                                        EmptyView()
                                    } else {
                                        Button(action: {
                                            self.viewModel.gradePortion = self.gradePortion.firstIndex(of: g)!
                                        }) {
                                            Text("\(g)")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(self.viewModel.gradePortion == self.gradePortion.firstIndex(of: g)! ? .white : Color("PrimaryBlack"))
                                                .frame(width: 109, height: 32)
                                        }
                                        .background(self.viewModel.gradePortion == self.gradePortion.firstIndex(of: g)! ? Color("PrimaryBlue") : Color("BorderColor"))
                                        .cornerRadius(20.0)
                                        .animation(.easeInOut)
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        VStack(alignment:.leading, spacing: 0) {
                            HStack {
                                Text("해시태그")
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .frame(height: 24)
                                    .padding(.trailing, 8)
                                
                                Text("1~3개 선택")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("DisableColor"))
                                    .frame(height: 18)
                                    
                            }.padding(.bottom, 16)
                            
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 8), count: 3), spacing: 8) {
                                ForEach(self.hashtag, id: \.self) { g in
                                    Button(action: {
                                        if(self.viewModel.hashTags.contains(g.id)) {
                                            let index = self.viewModel.hashTags.firstIndex(of: g.id)
                                            self.viewModel.hashTags.remove(at: index!)
                                        } else {
                                            if(self.viewModel.hashTags.count < 3) {
                                                self.viewModel.hashTags.append(g.id)
                                            }
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
                            }
                        }
                        
                        VStack(alignment:.leading, spacing: 0) {
                            HStack {
                                Text("총평")
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .frame(height: 24)
                                    .padding(.bottom, 16)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                StarRating(initialRating: 5, configuration: $customConfig) { newRating in
                                    
                                    self.viewModel.rating = newRating
                                    
                                }.frame(width: 250, height: 40)
                                Spacer()
                            }
                        }
                        
                        ZStack {
                            HStack {
                                VStack(alignment:.leading, spacing: 0) {
                                    Text("이 강의에 대한 총평을 자유롭게 적어주세요!")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 16)
                                    Text("(시험정보, 과제정보, 팁 등)")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 16)
                                    Text("")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 16)
                                    Text("허위사실이나 지나친 비방 내용을 작성할 시,")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 16)
                                    Text("승인이 불가할 수 있습니다.")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 16)
                                    Text("")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 16)
                                    Text("강의평 작성이 완료될 시, 수정이나 삭제가 불가합니다.")
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 16)
                                }
                                Spacer()
                            }.padding(16)
                            .opacity(self.viewModel.comment.isEmpty ? 1.0 : 0.0)
                            TextEditor(text: self.$viewModel.comment)
                                .padding(.horizontal,16)
                                .padding(.vertical,8)
                                .font(.system(size: 14))
                                .background(Color.clear)
                        }
                        .background(Color("BackgroundColor"))
                        .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color("BorderColor"), lineWidth: 1)
                        )
                        
                        Button(action: {
                            self.viewModel.addReview()
                        }) {
                            HStack{
                                Spacer()
                                Text("작성완료 (+10P)")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color.white)
                                    .padding(.vertical, 10)
                                Spacer()
                            }
                        }
                        .disabled(
                            self.viewModel.hashTags.isEmpty ||
                                self.viewModel.assignments.isEmpty ||
                                self.viewModel.comment.isEmpty
                        )
                        .onReceive(self.viewModel.responseChange) { (response: HangangResponse) in
                            if(response.message == "리뷰가 정상적으로 작성되었습니다.") {
                                self.writeSucceedDialog = true
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(self.viewModel.hashTags.isEmpty || self.viewModel.assignments.isEmpty ||
                                        self.viewModel.comment.isEmpty ? Color("DisabledBlue") : Color("PrimaryBlue"))
                        .cornerRadius(24.0)
                        
                    }
                    
                    .padding(.horizontal, 16)
                    .padding(.bottom, 50)
                    .navigationBarTitleDisplayMode(.inline)
                    
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("\(self.viewModel.lecture?.name ?? "")")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                        }
                        
                    }.background(UINavigationConfiguration { nc in
                        nc.navigationBar.barTintColor = .white
                        /*nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)*/
                        nc.navigationBar.shadowImage = UIImage()
                        nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
                    })
                }
            }.bottomSheet(isPresented: self.$showingSemesterActionSheet, height: geometry.size.height / 2) {
                VStack{
                    Text("수강학기")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                        .frame(height: 21)
                    
                    List(self.viewModel.semesters, id: \.self) { semester in
                        Button(action: {
                            self.viewModel.semester = semester
                            self.showingSemesterActionSheet = false
                        }) {
                            HStack {
                                Text("\(semester?.semester ?? "")")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .frame(height: 21)
                                Spacer()
                                if(semester == self.viewModel.semester) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("PrimaryBlue"))
                                }
                            }
                        }
                            .listRowInsets(EdgeInsets())
                            
                    }
                    .listStyle(PlainListStyle())
                    
                    
                }
                .background(Color.white)
                .foregroundColor(.white)
            }.alert(isPresented: self.$writeSucceedDialog) {
                Alert(
                        title: Text(""), message: Text("리뷰가 정상적으로 작성되었습니다.").font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("PrimaryBlack"))
                )
            }
            
        }
    }
}

/*struct WriteReviewView_Previews: PreviewProvider {
    static var previews: some View {
        WriteReviewView()
    }
}*/
