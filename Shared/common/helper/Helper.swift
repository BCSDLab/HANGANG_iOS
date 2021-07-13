//
//  Helper.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/18.
//

import Foundation
import CommonCrypto
import SwiftUI
import UIKit

func sha256(str: String) -> String {
 
    if let strData = str.data(using: String.Encoding.utf8) {
        /// #define CC_SHA256_DIGEST_LENGTH     32
        /// Creates an array of unsigned 8 bit integers that contains 32 zeros
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
 
        /// CC_SHA256 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
        /// Takes the strData referenced value (const unsigned char *d) and hashes it into a reference to the digest parameter.
        strData.withUnsafeBytes {
            // CommonCrypto
            // extern unsigned char *CC_SHA256(const void *data, CC_LONG len, unsigned char *md)  -|
            // OpenSSL                                                                             |
            // unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md)        <-|
            CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
        }
 
        var sha256String = ""
        /// Unpack each byte in the digest array and add them to the sha256String
        for byte in digest {
            sha256String += String(format:"%02x", UInt8(byte))
        }
 
        return sha256String
    }
    return ""
}

extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()!
        self.setFill()
        ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func as1ptImageWithPercent(percent: Double) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

struct TripleEmptyNavigationLink: View {
    var body: some View {
        VStack {
            NavigationLink(destination: EmptyView()) {EmptyView()}
            NavigationLink(destination: EmptyView()) {EmptyView()}
            NavigationLink(destination: EmptyView()) {EmptyView()}

        }
    }
}


struct TripleEmptyNavigationLinkBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
                .background(TripleEmptyNavigationLink())
    }
}



extension View {
    func tripleEmptyNavigationLink()-> some View {
        self.modifier(TripleEmptyNavigationLinkBackground())
    }
}

extension String {
    func getArrayAfterRegex(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                    range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    var stringToDate:Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)!
    }

    var stringToNewDate:Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: self)!
    }
}

extension Int {
    var semesterToString: String {
        return "\(2019 + (self / 2))년 \(((self - 1) % 2) + 1)학기"
    }
}

extension Date {
    var getmdhm: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        
        return dateFormatter.string(from: self)
    }
    var getymd: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        return dateFormatter.string(from: self)
    }
    func timeAgoDisplay() -> String {
            let formatter = RelativeDateTimeFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: Date())
        }
}

func checkRegex(target: String, pattern: String) -> Bool {

    do {
        print(target)
        print(pattern)
        let range = NSRange(location: 0, length: target.utf16.count)
        let regex = try NSRegularExpression(pattern: pattern)
        let filtered = regex.matches(in: target, options: [], range: range)
        
        if (filtered.isEmpty) {
            return false
        } else {
            return true
        }
    } catch(let error) {
        print(error)
        return false
    }
    return false
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight))
    }
}


struct SelectableButtonStyle: ButtonStyle {

    var isSelected: Bool = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 64.0, height: 32.0, alignment: .center)
            //.padding(EdgeInsets(top: 6, leading: 0, bottom: 5, trailing: 0))
            .background(isSelected ? Color("PrimaryBlue") : Color("BorderColor"))
            .cornerRadius(20.0)
            /*.overlay(RoundedRectangle(cornerRadius: 20.0).foregroundColor(isSelected ? Color("PrimaryBlue") : Color("DisableColor")))*/
            .animation(.easeInOut)
    }
}

struct StatedButton<Label>: View where Label: View {
    private let action: (() -> ())?
    private let label: (() -> Label)?
    var isSelected: Bool = false
    @State var buttonStyle = SelectableButtonStyle()

    init(action: (() -> ())? = nil, isSelected: Bool, label: (() -> Label)? = nil) {
        self.action = action
        self.isSelected = isSelected
        self.label = label
    }

    var body: some View {
        Button(action: {
            self.buttonStyle.isSelected = isSelected
            self.action?()
        }) {
            label?()
        }
        .buttonStyle(buttonStyle)
    }
}


struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
