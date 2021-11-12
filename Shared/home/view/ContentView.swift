//
//  ContentView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/01.
//

import SwiftUI
import PartialSheet

struct ContentView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

    //@State var selectedTab = "Home"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @Namespace var animation
    var tabs = ["Home","ClipboardCheck","DocumentText","Template","User"]
    @ObservedObject var viewModel: TabViewModel

    init() {
        self.viewModel = TabViewModel()
    }


    var body: some View{

        GeometryReader { geometry in
            VStack(spacing: 0){

                GeometryReader{ geometry in

                    if(self.viewModel.showingHome) {
                        HomeView()
                                .environmentObject(self.viewModel)
                                .tripleEmptyNavigationLink()
                    }else if(self.viewModel.showingReview) {
                        ReviewView(
                                major: self.viewModel.major
                        )
                                .tripleEmptyNavigationLink()
                    }else if(self.viewModel.showingLectureBank) {
                        LectureBankView()
                                .tripleEmptyNavigationLink()
                    } else if(self.viewModel.showingTimeTable) {
                        TimeTableView()
                    } else if(self.viewModel.showingMy) {
                        MyView()
                                .environmentObject(authenticationViewModel)
                                .tripleEmptyNavigationLink()
                    } else {
                        EmptyView()
                    }

                    /*switch(selectedTab) {
                    case "Home":
                        HomeView()
                    case "ClipboardCheck":
                        ReviewView()
                    case "DocumentText":
                        LectureBankView()
                    case "Template":

                    case "User":

                    default:
                        EmptyView()
                    }*/
                }
                // TabView...

                HStack(spacing: 0){

                    ForEach(tabs,id: \.self){tab in

                        Button(action: {
                            withAnimation {
                                self.viewModel.menuTapped(tab)
                            }
                        }) {

                            VStack(spacing: 6){

                                ZStack{

                                    CustomShape()
                                            .fill(Color("BorderColor"))
                                            .frame(maxWidth: .infinity, minHeight: 1.5, maxHeight: 1.5)

                                    if self.viewModel.isSelected(tab){

                                        CustomShape()
                                                .fill(Color("PrimaryBlue"))
                                                .frame(maxWidth: .infinity, minHeight: 1.5, maxHeight: 1.5)
                                        /*.matchedGeometryEffect(id: "Tab_Change", in: animation)*/
                                    }
                                }
                                        .padding(.bottom,10)

                                Image(tab)
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundColor(self.viewModel.isSelected(tab) ? Color("PrimaryBlue") : Color("DisableColor"))
                                        .frame(width: 24, height: 24)

                                Text(tabsTitle[tab] ?? "")
                                        .font(.system(size: 11))
                                        .foregroundColor(self.viewModel.isSelected(tab) ? Color("PrimaryBlue") : Color("DisableColor"))
                            }.frame(maxWidth: .infinity)
                        }

                    }
                }
                        //.padding(.horizontal,30)
                        // for iphone like 8 and SE
                        //.padding(.bottom,(edges?.bottom ?? 0) == 0 ? 15 : (edges?.bottom ?? 0))
                        .background(Color.white)
            }.addPartialSheet(style: PartialSheetStyle(
                background: .solid(.white),
                accentColor: .clear,
                enableCover: false,
                coverColor: .clear,
                cornerRadius: 16,
                minTopDistance: geometry.size.height / 2
            ))
                    .background(Color.white)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var tabsTitle = [
    "Home":"홈",
    "ClipboardCheck":"강의평",
    "DocumentText":"강의자료",
    "Template":"시간표",
    "User":"마이페이지"
]



/*struct TabButton : View {
    var tab: String
    @EnvironmentObject var viewModel: TabViewModel
    var animation : Namespace.ID

    var body: some View{


    }
}*/

struct CustomShape: Shape {

    func path(in rect: CGRect) -> Path {

        /*let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))*/
        let path = UIBezierPath(rect: rect)

        return Path(path.cgPath)
    }
}

