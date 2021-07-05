//
//  ContentView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @State var selectedTab = "Home"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @Namespace var animation
    var tabs = ["Home","ClipboardCheck","DocumentText","Template","User"]
    
    
    var body: some View{
              
              VStack(spacing: 0){
                  
                  GeometryReader{_ in
                    /*
                     HomeView()
                     .opacity(selectedTab == "Home" ? 1 : 0)
                 
                 ReviewView()
                     .opacity(selectedTab == "ClipboardCheck" ? 1 : 0)
                 
                 LectureBankView()
                     .opacity(selectedTab == "DocumentText" ? 1 : 0)
                 
               TimeTableView()
                     .opacity(selectedTab == "Template" ? 1 : 0)
               
               MyView(token: self.authenticationViewModel.token)
                   .opacity(selectedTab == "User" ? 1 : 0)
                     */
                      
                    switch(selectedTab) {
                    case "Home":
                        HomeView()
                    case "ClipboardCheck":
                        ReviewView()
                    case "DocumentText":
                        LectureBankView()
                    case "Template":
                        TimeTableView()
                    case "User":
                        MyView(token: self.authenticationViewModel.token)
                    default:
                        EmptyView()
                    }
                  }
                  // TabView...
                  
                  HStack(spacing: 0){
                      
                      ForEach(tabs,id: \.self){tab in
                          
                        TabButton(tab: tab, selectedTab: self.$selectedTab,animation: animation)
                            
                      }
                  }
                  //.padding(.horizontal,30)
                  // for iphone like 8 and SE
                  .padding(.bottom,(edges?.bottom ?? 0) == 0 ? 15 : (edges?.bottom ?? 0))
                  .background(Color.white)
              }
              
              .ignoresSafeArea(.all, edges: .bottom)
              .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
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

struct TabButton : View {
      
    var tab: String
      @Binding var selectedTab : String
      var animation : Namespace.ID
      
      var body: some View{
          
          Button(action: {
              withAnimation{selectedTab = tab}
          }) {
              
              VStack(spacing: 6){
                  
                  ZStack{
                      
                      CustomShape()
                          .fill(Color("BorderColor"))
                        .frame(maxWidth: .infinity, minHeight: 1.5, maxHeight: 1.5)
                      
                      if selectedTab == tab{
                          
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
                      .foregroundColor(selectedTab == tab ? Color("PrimaryBlue") : Color("DisableColor"))
                      .frame(width: 24, height: 24)
                  
                Text(tabsTitle[tab] ?? "")
                      .font(.system(size: 11))
                    .foregroundColor(selectedTab == tab ? Color("PrimaryBlue") : Color("DisableColor"))
              }.frame(maxWidth: .infinity)
          }
      }
  }

struct CustomShape: Shape {
      
      func path(in rect: CGRect) -> Path {
          
          /*let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))*/
        let path = UIBezierPath(rect: rect)
          
          return Path(path.cgPath)
      }
  }
  
