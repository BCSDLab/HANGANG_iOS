//
//  UploadLectureBankViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/28.
//

import Foundation
import Combine
import UIKit

class UploadLectureBankViewModel: ObservableObject, Identifiable {
    @Published var title: String = ""
    @Published var lectureName: String = ""
    @Published var semester: Int = 1
    @Published var semesters: [Int] = [1,2,3,4,5,6]
    @Published var assignment: String = "기출자료"
    @Published var content: String = ""
    @Published var files: [URL] = []
    @Published var fileDescriptor: [[FileAttributeKey : Any]] = []
    @Published var images: [UIImage] = []
    
    
    private var disposables: Set<AnyCancellable> = []

    
    init() {
        
        
        
    }
    
    
    func uploadFile(fileUrl: URL) {
        
        do {
            
        } catch (let error) {
            print(error)
        }
        
        //let file = Data(contentsOf: fileUrl, options: <Data.ReadingOptions>)
    }
    
    func uploadImage(image: UIImage) {
        let imgData = image.jpegData(compressionQuality: 0.5)!
        
        
    }
}
