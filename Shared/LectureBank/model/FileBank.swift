//
// Created by 정태훈 on 2021/07/07.
//

import Foundation
import UIKit

struct FileBank: Hashable {
    let url: URL?
    let image: UIImage?
    let attributes: [FileAttributeKey : Any]?
    let isFile: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(isFile ? "\(url)" : "\(image!.hashValue)")
    }

    static func == (lhs: FileBank, rhs: FileBank) -> Bool {
        return (lhs.isFile ? "\(lhs.url)": "\(lhs.image!.hashValue)")
                == (rhs.isFile ? "\(rhs.url)": "\(rhs.image!.hashValue)")
    }
}
