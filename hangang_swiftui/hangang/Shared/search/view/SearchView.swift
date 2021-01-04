//
//  SearchView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/04.
//

import SwiftUI

struct SearchView: View {
    @State var tt: String = ""
    
    var body: some View {
        VStack { // <1>
            Text("Hello, SwiftUI!")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack{
                            TextField("교과명, 교수명, 과목코드 검색", text: $tt)
                                .padding(12)
                                .frame(maxWidth: 275, alignment: .leading)
                                
                            Spacer()
                            Image("SearchIcon")
                                .padding(.trailing, 10)
                        }
                        .frame(minWidth: 320, maxWidth: .infinity, alignment: .leading)
                        .background(Color("BorderColor"))
                        .cornerRadius(8.0)
                    }
                }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
