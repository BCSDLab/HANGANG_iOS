//
//  UploadLectureBankView.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/28.
//

import SwiftUI

struct UploadLectureBankView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var viewModel: UploadLectureBankViewModel
    @State private var showDocumentPicker: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showingSemesterActionSheet: Bool = false
    @State var writeSucceedDialog: Bool = false
    @State private var showingLectureSheet: Bool = false
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
                        HStack(spacing: 0) {
                            if(self.viewModel.selectedLecture == nil) {
                                TextField("과목명 검색", text: self.$viewModel.lectureName)
                                   .autocapitalization(.none)
                                   .font(.system(size: 16))
                                   .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 0))
                            } else {
                                HStack {
                                    Text("\(self.viewModel.selectedLecture!.name ?? "")")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("PrimaryBlack"))
                                        .padding(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 8))
                                    Text("\(self.viewModel.selectedLecture!.professor ?? "")")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color("DisableColor"))
                                        .padding(EdgeInsets(top: 7, leading: 0, bottom: 7, trailing: 0))
                                }
                            }
                             
                            Spacer()
                            Button(action: {
                                self.showingLectureSheet = true
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
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                            Spacer()
                            Button(action: {
                                self.showingSemesterActionSheet = true
                            }) {
                                HStack {
                                    Text("\(self.viewModel.semester.semester)")
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

                                        if(self.viewModel.assignment.contains(a)) {
                                            var index = self.viewModel.assignment.index(of: a);
                                            self.viewModel.assignment.remove(at: index!);
                                        } else {
                                            self.viewModel.assignment.append(a)
                                        }
                                        
                                    }) {
                                        Text("\(a)")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(self.viewModel.assignment.contains(a) ? .white : Color("PrimaryBlack"))
                                            .frame(width: 76, height: 32)
                                            
                                    }
                                    .background(self.viewModel.assignment.contains(a) ? Color("PrimaryBlue") : Color("BorderColor"))
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


                    ScrollView (.horizontal) {
                        HStack {
                            ForEach(self.viewModel.files, id: \.self) { (fileData: FileBank) in
                                //let fileName = fileData.attributes[FileAttributeKey.name]


                                //let size = fileData.attributes[FileAttributeKey.size] as! Int

                                if(fileData.isFile) {
                                    let fileName = fileData.url!.lastPathComponent
                                    let identifier = fileName.split(separator: ".").last
                                    //print(identifier)
                                    VStack {
                                        HStack{
                                            Image(String(identifier ?? "txt"))
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .padding(8)
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text("\(fileName)")
                                                    .fontWeight(.regular)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(Color("PrimaryBlack"))
                                                    .frame(height: 18, alignment: .center)
                                                    .padding(8)
                                        }
                                    }.frame(width: 100, height: 100, alignment: .topLeading)
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color("BorderColor"), lineWidth: 1)
                                            )
                                            .cornerRadius(8)
                                } else {

                                    /*Image(uiImage: fileData.image!)
                                            .resizable()
                                            .scaledToFit()
                                        .frame(width: 100)*/
                                    VStack {
                                        HStack{
                                            Image("png")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .padding(8)
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text("\(String(format:"%02X", fileData.image.hashValue)).png")
                                                    .fontWeight(.regular)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(Color("PrimaryBlack"))
                                                    .frame(height: 18, alignment: .center)
                                                    .padding(8)
                                        }
                                    }.frame(width: 100, height: 100, alignment: .topLeading)
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color("BorderColor"), lineWidth: 1)
                                            )
                                            .cornerRadius(8)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        self.viewModel.uploadLectureBank(user: self.authenticationViewModel.user)
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
                    .onReceive(self.viewModel.responseChange) { response in
                        self.writeSucceedDialog = true
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(/*self.viewModel.hashTags.isEmpty || self.viewModel.assignments.isEmpty ||
                                    self.viewModel.comment.isEmpty ? Color("DisabledBlue") : */Color("PrimaryBlue"))
                    .cornerRadius(24.0)
                    .padding(16)
                    
                    
                }
            }.sheet(isPresented: self.$showingLectureSheet) {
                SearchLectureView(query: self.viewModel.selectedLecture == nil ? self.viewModel.lectureName: "")
                        .environmentObject(self.viewModel)
                
            }.sheet(isPresented: self.$showDocumentPicker) {
                DocumentPicker(callback: { url in
                    do {
                        let attr = try FileManager.default.attributesOfItem(atPath: url.path)
                        let fileBank = FileBank(
                                url: url,
                                image: nil,
                        attributes: attr,
                        isFile: true
                        )
                        self.viewModel.files.append(fileBank)
                    } catch(let error) {
                        print(error)
                    }
                }, onDismiss: {
                    
                }
                )
            }.sheet(isPresented: self.$showImagePicker) {
                SUImagePicker(sourceType: .photoLibrary) { image in
                    let fileBank = FileBank(
                            url: nil,
                            image: image,
                            attributes: nil,
                            isFile: false
                    )
                    self.viewModel.files.append(fileBank)
                    //self.viewModel.images.append(image)
                }
            }.bottomSheet(isPresented: self.$showingSemesterActionSheet, height: geometry.size.height / 2) {
                VStack{
                    Text("제작 및 수강학기")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color("PrimaryBlack"))
                        .frame(height: 21)
                    
                    List(self.viewModel.semesters, id: \.self) { s in
                        Button(action: {
                            self.viewModel.semester = s
                            self.showingSemesterActionSheet = false
                        }) {
                            HStack {
                                Text("\(s.semester)")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("PrimaryBlack"))
                                    .frame(height: 21)
                                Spacer()
                                if(s == self.viewModel.semester) {
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
                        title: Text(""), message: Text("강의자료가 정상적으로 작성되었습니다.").font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("PrimaryBlack"))
                )
            }
            
        }
    }
}

struct UploadLectureBankView_Previews: PreviewProvider {
    static var previews: some View {
        UploadLectureBankView()
    }
}
