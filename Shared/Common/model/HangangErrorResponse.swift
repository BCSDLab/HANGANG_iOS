//
// Created by 정태훈 on 2021/01/31.
//

import Foundation
import Alamofire

class HangangErrorResponse: Decodable{
    let className: String?
    let errorMessage: String?
    let code: Int?
    let httpStatus: String?
    let errorTrace: String?

    init() {
        className = nil
        errorMessage = nil
        code = nil
        httpStatus = nil
        errorTrace = nil
    }
}
