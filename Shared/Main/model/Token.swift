//
// Created by 정태훈 on 2021/01/31.
//

import Foundation

struct Token: Codable {
    let refresh_token: String
    let access_token: String

    init() {
        refresh_token = ""
        access_token = ""
    }

    init(refresh_token: String, access_token: String) {
        self.refresh_token = refresh_token
        self.access_token = access_token
    }
}
