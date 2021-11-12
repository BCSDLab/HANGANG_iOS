//
//  TabViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/01.
//

import Foundation

class TabViewModel: ObservableObject, Identifiable {
    
    @Published var showingHome: Bool = false
    @Published var showingReview: Bool = false
    @Published var showingLectureBank: Bool = false
    @Published var showingTimeTable: Bool = false
    @Published var showingMy: Bool = false
    @Published var major: String? = nil

    init() {
        self.showingHome = true
        self.showingReview = false
        self.showingLectureBank = false
        self.showingTimeTable = false
        self.showingMy = false
    }

        func menuTapped(_ menu: String) -> Void {
            print("Clicked: \(menu)")
            clearState()

            if(menu == "Home") {
                self.showingHome = true
            } else if(menu == "ClipboardCheck") {
                self.showingReview = true
            } else if(menu == "DocumentText") {
                self.showingLectureBank = true
            } else if(menu == "Template") {
                self.showingTimeTable = true
            } else if(menu == "User") {
                self.showingMy = true
            }

            /*switch menu {
            case "Home":
                showingHome = true
            case "ClipboardCheck":
                showingReview = true
            case "DocumentText":
                showingLectureBank = true
            case "Template":
                showingTimeTable = true
            case "User":
                showingMy = true
            default:
                break
            }*/
        }

    func isSelected(_ menu: String) -> Bool {
        switch menu {
        case "Home":
            return self.showingHome
        case "ClipboardCheck":
            return self.showingReview
        case "DocumentText":
            return self.showingLectureBank
        case "Template":
            return self.showingTimeTable
        case "User":
            return self.showingMy
        default:
            return false
        }
    }
    
    func clearState() {
        self.showingHome = false
        self.showingReview = false
        self.showingLectureBank = false
        self.showingTimeTable = false
        self.showingMy = false
    }
}
