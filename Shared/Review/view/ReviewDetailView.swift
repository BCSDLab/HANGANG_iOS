//
//  ReviewDetailView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/31.
//

import SwiftUI
import SwiftUICharts

struct ReviewDetailView: View {
    @ObservedObject var viewModel: ReviewDetailViewModel
    /*let chartStyle = ChartStyle(backgroundColor: Color("BackgroundColor"), accentColor: Color("PrimaryOrenge"), secondGradientColor: Color("PrimaryOrenge"),  textColor: Color("PrimaryBlack"), legendTextColor: Color.clear, dropShadowColor: Color.clear )*/
    let chartStyle = ChartStyle(backgroundColor: Color("BackgroundColor"), foregroundColor: ColorGradient(
        Color("PrimaryOrenge"), Color("PrimaryOrenge")
    ))
    let grade: [String] = ["", "하", "중", "상"]
    let gradePortion: [String] = ["", "아쉽게주심", "적당히주심", "후하게주심"]
    @State var openTimetable: Bool = false

    
    init(lecture: Lecture) {
        self.viewModel = ReviewDetailViewModel(
            lecture: lecture
        )
        viewModel.getTotalEvaluation()
        viewModel.getRating()
        viewModel.getReviews()
    }
    
    var body: some View {
        ScrollView {
            VStack{
                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing: 0){
                        Text("\(viewModel.lecture?.name ?? "")")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 27)
                        Text(" \(viewModel.lecture?.code ?? "")")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(Color("DisableColor"))
                                .frame(height: 27)
                            Spacer()
                        Text("\(viewModel.lecture?.classification ?? "")")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlue"))
                                .frame(height: 27)
                        }.padding(.bottom, 8)

                    Text("\(viewModel.lecture?.professor ?? "")")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color("PrimaryBlack"))
                        .frame(height: 21)
                        .padding(.bottom, 8)
                    Text("개설학기")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(Color("DisableColor"))
                            .frame(height: 21)
                        .padding(.bottom, 4)
                    HStack(alignment:.bottom,spacing: 0){
                        if((viewModel.lecture?.semesterData ?? []).count > 0) {
                            ForEach(viewModel.lecture?.semesterData ?? [], id: \.self) { semester in
                                Text("\(semester) ")
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .frame(height: 21)
                            }
                        }
                            Spacer()
                         Button(action: {
                             if(!(self.viewModel.subLecture?.isScraped ?? false)) {
                                viewModel.scrapLecture()
                             }
                         }) {
                             Image((self.viewModel.subLecture?.isScraped ?? false) ? "Scrap.fill" : "Scrap")
                                     .resizable()
                                     .scaledToFit()
                                     .frame(width:24)
                         }
                        }
                }.padding(.horizontal, 16)
                Divider()
                VStack(alignment: .leading, spacing: 8){
                    Text("시간표 정보")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(Color("PrimaryBlack"))
                            .frame(height: 24)
                            .padding(.bottom, 8)

                    HStack(spacing: 0){
                        Text("학점")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(width: 34, alignment: .leading)
                        Text("\(self.viewModel.subLecture?.grade ?? 0)학점")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                        Spacer()
                    }
                    HStack(spacing: 0){
                        Text("시간")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(width: 34, alignment: .leading)
                        Text("분반과 시간을 확인하세요.")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                        Spacer()
                        Button(action: {
                            openTimetable.toggle()
                        }) {
                            Image(systemName: openTimetable ? "chevron.up" : "chevron.down")
                                .foregroundColor(Color("CheckboxBorderColor"))
                        }
                    }
                    if(openTimetable) {
                        VStack(spacing: 8){
                            ForEach(self.viewModel.timeTableLecture, id: \.self) { tl in
                                HStack{
                                    Text("\(tl.classTimeString) (\(tl.classNumber))")
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("PrimaryBlack"))
                                    Spacer()
                                    Button(action: {
                                        if(tl.selectedTableId.isEmpty) {
                                            //self.timeTableViewModel.deleteLecture(lecture: lecture)
                                        } else {
                                            //self.timeTableViewModel.addLecture(lecture: lecture)
                                        }
                                    }) {
                                        Text(tl.selectedTableId.isEmpty ? "담기" : "빼기" )
                                                .font(.system(size: 12))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.white)
                                                .frame(height: 18)
                                                .padding(EdgeInsets(top: 5, leading: 17, bottom: 5, trailing: 17))
                                    }.background(tl.selectedTableId.isEmpty ? Color("PrimaryBlue") : Color("PrimaryOrenge") )
                                            .cornerRadius(20)
                                }.padding(.leading, 50 - 16)
                            }
                        }.animation(.easeInOut)
                                .transition(.opacity)
                    }

                }.padding(.horizontal, 16)
                Divider()
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        Text("종합평가")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 24)
                        Spacer()
                        }.padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    ZStack(alignment: .topLeading) {
                        HStack(alignment: .top, spacing: 0) {


                            HStack (spacing: 1){
                                let maxRating = viewModel.rating.max() ?? 0.0
                                ForEach(viewModel.rating, id: \.self) { rating in
                                    BarView(value: CGFloat(maxRating == 0.0 || rating == 0.0 ? 1.0 : rating / maxRating * 130))
                                }
                                            }
                                                .animation(.default)
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity,
                                  alignment: .trailing
                                )
                            .padding(.top, 16)
                            .padding(.trailing, 11)
                            VStack(alignment: .trailing, spacing: 0){
                                Text("전체 평가 수")
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("DisableColor"))
                                    .frame(height: 16)
                                Text("\(viewModel.lecture?.reviewCount ?? 0)명")
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("DisableColor"))
                                    .frame(height: 16)
                            }.padding(.top, 16)
                            .padding(.trailing, 16)
                        }
                        HStack(spacing: 0){
                            Text("평점")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(height: 21)
                                .padding(.trailing, 8)
                            Text(String(format: "%.1f", viewModel.totalEvaluation?.rating ?? 0.0))
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 21)

                        }.frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .topLeading
                          ).padding(.top, 16)
                        .padding(.leading, 16)
                    }.background(Color("BackgroundColor"))

                    HStack(alignment: .top, spacing: 0) {


                        HStack (spacing: 1){
                            ForEach([0.0,1.0,0.0,2.0,0.0,3.0,0.0,4.0,0.0,5.0], id: \.self) { rating in
                                Text(String(format: "%.1f", rating))
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(rating == 0.0 ? .clear : Color("DisableColor"))
                                    .frame(width: 20, height: 16, alignment: .center)
                            }
                                        }
                                            .animation(.default)
                        .frame(
                              minWidth: 0,
                              maxWidth: .infinity,
                              alignment: .trailing
                        ).padding(.trailing, 11)

                        VStack(alignment: .trailing, spacing: 0){
                            Text("전체 평가 수")
                                .font(.system(size: 11))
                                .fontWeight(.regular)
                                .foregroundColor(.clear)
                                .frame(height: 16)
                        }.padding(.trailing, 16)

                    }.padding(.bottom, 16)

                    HStack(spacing: 0){
                        HStack(spacing: 0){
                            Text("출첵빈도")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(width: 68, alignment: .leading)
                            Text("\(grade[viewModel.totalEvaluation?.attendanceFrequency ?? 0])")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                        }.frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                          )
                        HStack(spacing: 0){
                            Text("시험 난이도")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(width: 84, alignment: .leading)
                            Text("\(grade[viewModel.totalEvaluation?.difficulty ?? 0])")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                        }.frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                          )
                    }.padding(.horizontal, 16)
                    .padding(.bottom, 16)

                    HStack(spacing: 0){
                        HStack(spacing: 0){
                            Text("과제량")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(width: 68, alignment: .leading)
                            Text("\(grade[viewModel.totalEvaluation?.assignmentAmount ?? 0])")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                        }.frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                          )
                        HStack(spacing: 0){
                            Text("성적비율")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("DisableColor"))
                                .frame(width: 84, alignment: .leading)
                            Text("\(gradePortion[viewModel.totalEvaluation?.gradePortion ?? 0])")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                        }.frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                          )
                    }.padding(.horizontal, 16)
                    .padding(.bottom, 24)

                    HStack(alignment:.bottom,spacing: 0){
                        if((viewModel.lecture?.top3HashTag ?? []).count > 0) {
                            ForEach(viewModel.lecture?.top3HashTag ?? [], id: \.self) { hash in
                                Text("#\(hash.tag) ")
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("DisableColor"))
                                    .frame(height: 21)
                            }
                        }
                            Spacer()
                        }.padding(.horizontal, 16)


                    }
                Divider()
                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing: 0){
                        Text("개인 평가 (\(viewModel.reviewCount))")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 24)
                            Spacer()
                        Text("좋아요순")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("PrimaryBlack"))
                                .frame(height: 18)
                        }.padding(.bottom, 8)
                    ForEach(self.viewModel.reviewResult, id: \.self) { review in
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("\(review.semesterDate) 수강자")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .frame(height: 18)
                                Spacer()
                            }.padding(.bottom, 4)
                                    .padding(.top, 16)

                            HStack {
                                Text("과제정보")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 18)
                                        .padding(.trailing, 4)

                                Text("\(review.assignment.map {$0.name}.joined(separator: ","))")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .frame(height: 18)

                            }.padding(.bottom, 8)
                            Text("\(review.comment)")
                                    .font(.system(size: 12))
                                    .lineLimit(nil)
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .frame(height: 18)
                                    .padding(.bottom, 9)
                            HStack {
                                Button(action: {
                                    self.viewModel.recommendReview(review: review)
                                }) {
                                    HStack{
                                        Image("ThumbUp")
                                                .renderingMode(.template)
                                                .foregroundColor(review.isLiked ? Color("PrimaryBlue") : Color("DisableColor"))
                                        Text("\(review.likes)")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color("PrimaryBlue"))
                                                .frame(height: 18)
                                    }
                                }
                                Spacer()
                                Text("신고")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color("DisableColor"))
                                        .frame(height: 18)
                            }.padding(.bottom, 15)
                            Divider()

                        }
                    }
                            .listStyle(PlainListStyle())


                }.padding(.horizontal, 16)

            }.onReceive(self.viewModel.objectWillChange) {

            }//.padding(16)
        }/*.onAppear {
            viewModel.getTotalEvaluation()
            viewModel.getRating()
            viewModel.getReviews()
        }*/.navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: WriteReviewView(
                    lecture: viewModel.lecture
                )) {
                    
                    Text("작성")
                }
            }
            ToolbarItem(placement: .principal) {
                Text("강의평")
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
}

/*struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(
            lecture: Lecture()
        )
    }
}*/
