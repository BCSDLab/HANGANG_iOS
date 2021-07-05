//
//  UploadLectureBankView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/28.
//

import SwiftUI

struct UploadLectureBankView: View {
    @ObservedObject var viewModel: UploadLectureBankViewModel
    @State private var showDocumentPicker: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showingSemesterActionSheet: Bool = false
    var assignments: [String] = ["기출자료", "필기자료", "과제자료", "강의자료", "기타자료"]
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        self.viewModel = UploadLectureBankViewModel()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        HStack {
                            TextField("제목을 입력해주세요.", text: self.$viewModel.title)
                                .onChange(of: self.viewModel.title, perform: { value in
                                    //self.viewModel.checkNickname()
                                })
                                .autocapitalization(.none)
                                .font(.system(size: 16))
                                .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                        }
                        Divider()
                            .background(Color("BorderColor"))
                    }
                    Group {
                        HStack {
                            TextField("과목명 검색", text: self.$viewModel.lectureName)
                                .autocapitalization(.none)
                                .font(.system(size: 16))
                                .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 0))
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Text("검색")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 28)
                            }
                            .background(Color("PrimaryBlue"))
                            .cornerRadius(20.0)
                            .padding(.trailing, 16)
                        }
                        Divider()
                            .background(Color("BorderColor"))
                    }
                    Group {
                        HStack {
                            Text("제작 및 수강학기")
                                .font(.system(size: 16))
                                .foregroundColor(Color("DisableColor"))
                                .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                            Spacer()
                            Button(action: {
                                self.showingSemesterActionSheet = true
                            }) {
                                HStack {
                                    Text("\(self.viewModel.semester.semesterToString)")
                                        .font(.system(size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .frame(height: 21)
                                    Image(systemName: "chevron.down")
                                }
                            }.padding(.trailing, 16)
                        }
                        Divider()
                            .background(Color("BorderColor"))
                    }
                    Group {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("자료유형")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("DisableColor"))
                                    .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                                Spacer()
                            }
                            
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 8), count: 4), spacing: 8) {
                                ForEach(self.assignments, id: \.self) { a in
                                    Button(action: {
                                        self.viewModel.assignment = a
                                        
                                    }) {
                                        Text("\(a)")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(self.viewModel.assignment == a ? .white : Color("PrimaryBlack"))
                                            .frame(width: 76, height: 32)
                                            
                                    }
                                    .background(self.viewModel.assignment == a ? Color("PrimaryBlue") : Color("BorderColor"))
                                    .cornerRadius(20.0)
                                    .animation(.easeInOut)
                                }
                            }.padding(.horizontal, 16)
                        }
                        Divider()
                            .background(Color("BorderColor"))
                    }
                    Group {
                        ZStack(alignment: .topLeading){
                            HStack{
                                VStack(alignment:.leading, spacing: 0) {
                                    Text("자료에 대한 설명을 작성해주세요. (저작권법 제133조에")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("DisableColor"))
                                            .frame(height: 16)
                                    Text("따라 타인 또는 유포금지 자료를 업로드할 경우, 저작권에")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("DisableColor"))
                                            .frame(height: 16)
                                    Text("위배되어 경고 없이 삭제될 수 있습니다.)")
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
                                    Spacer()
                                }
                                Spacer()
                            }.padding(16)
                            .opacity(self.viewModel.content.isEmpty ? 1.0 : 0.0)
                            
                            TextEditor(text: self.$viewModel.content)
                                .padding(.horizontal,16)
                                .padding(.vertical,8)
                                .font(.system(size: 14))
                                .background(Color.clear)
                        }.frame(height: 233)
                        Divider()
                            .background(Color("BorderColor"))
                    }
                    Text("자료를 최소 1개 이상 업로드 해주세요. ( 0KB / 50MB )")
                        .font(.system(size: 14))
                        .foregroundColor(Color("DisableColor"))
                        .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                    HStack {
                        Button(action: {
                                showDocumentPicker = true
                        }) {
                            Image("file")
                        }
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Image("image")
                        }
                    }.padding(.horizontal, 16)
                    
                    Button(action: {
                        
                    }) {
                        HStack{
                            Spacer()
                            Text("작성완료 (+70P)")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                            Spacer()
                        }
                    }
                    /*.disabled(
                        self.viewModel.hashTags.isEmpty ||
                            self.viewModel.assignments.isEmpty ||
                            self.viewModel.comment.isEmpty
                    )*/
                    /*.onReceive(self.viewModel.responseChange) { response in
                        if(response.httpStatus == "OK") {
                            print("OKOKOKOKOK")
                        } else {
                            
                        }
                    }*/
                    .buttonStyle(PlainButtonStyle())
                    .background(/*self.viewModel.hashTags.isEmpty || self.viewModel.assignments.isEmpty ||
                                    self.viewModel.comment.isEmpty ? Color("DisabledBlue") : */Color("PrimaryBlue"))
                    .cornerRadius(24.0)
                    .padding(16)
                    
                    
                }
            }.sheet(isPresented: self.$showDocumentPicker) {
                DocumentPicker(callback: { url in
                    self.viewModel.files.append(url)
                    do {
                        let attr = try FileManager.default.attributesOfItem(atPath: url.path)
                        self.viewModel.fileDescriptor.append(attr)
                    } catch(let error) {
                        print(error)
                    }
                }, onDismiss: {
                    
                }
                )
            }.sheet(isPresented: self.$showImagePicker) {
                SUImagePicker(sourceType: .photoLibrary) { image in
                    self.viewModel.images.append(image)
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
                                Text("\(semester.semesterToString)")
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
            }
            
        }
    }
}

struct UploadLectureBankView_Previews: PreviewProvider {
    static var previews: some View {
        UploadLectureBankView()
    }
}
