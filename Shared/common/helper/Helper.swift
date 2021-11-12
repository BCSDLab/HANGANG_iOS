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

class FileDownloader {

    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }

    func flattenedArray(array:[Any]) -> [Any] {
        var myArray = [Any]()
        for element in array {
            if let element = element as? Any {
                myArray.append(element)
            }
            if let element = element as? [Any] {
                let result = flattenedArray(array: element)
                for i in result {
                    myArray.append(i)
                }

            }
        }
        return myArray
    }

    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
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

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
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
    
    var stringToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self) ?? Date()
    }

    var stringToNewDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: self) ?? Date()
    }
}

/*extension Int {
    var semesterToString: String {
        return "\(2019 + (self / 2))년 \(((self - 1) % 2) + 1)학기"
    }
}*/

public struct TextAlert {
    public var title: String // Title of the dialog
    public var message: String // Dialog message
    public var placeholder: String = "" // Placeholder text for the TextField
    public var accept: String = "OK" // The left-most button label
    public var cancel: String? = "Cancel" // The optional cancel (right-most) button label
    public var secondaryActionTitle: String? = nil // The optional center button label
    public var keyboardType: UIKeyboardType = .default // Keyboard tzpe of the TextField
    public var action: (String?) -> Void // Triggers when either of the two buttons closes the dialog
    public var secondaryAction: (() -> Void)? = nil // Triggers when the optional center button is tapped
}

extension UIAlertController {
    convenience init(alert: TextAlert) {
        self.init(title: alert.title, message: alert.message, preferredStyle: .alert)
        addTextField {
            $0.placeholder = alert.placeholder
            $0.keyboardType = alert.keyboardType
        }
        if let cancel = alert.cancel {
            addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
                alert.action(nil)
            })
        }
        if let secondaryActionTitle = alert.secondaryActionTitle {
            addAction(UIAlertAction(title: secondaryActionTitle, style: .default, handler: { _ in
                alert.secondaryAction?()
            }))
        }
        let textField = self.textFields?.first
        addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
            alert.action(textField?.text)
        })
    }
}

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alert: TextAlert
    let content: Content

    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }

    final class Coordinator {
        var alertController: UIAlertController?
        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
        uiViewController.rootView = content
        if isPresented && uiViewController.presentedViewController == nil {
            var alert = self.alert
            alert.action = {
                self.isPresented = false
                self.alert.action($0)
            }
            context.coordinator.alertController = UIAlertController(alert: alert)
            uiViewController.present(context.coordinator.alertController!, animated: true)
        }
        if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
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
    public func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
        AlertWrapper(isPresented: isPresented, alert: alert, content: self)
    }
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight))
    }
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
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
