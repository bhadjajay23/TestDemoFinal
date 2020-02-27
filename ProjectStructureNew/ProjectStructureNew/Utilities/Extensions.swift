//
//  Extensions.swift
//  IgniteSolPracticalTest
//
//  Created by Grave Walker on 2/25/20.
//  Copyright © 2020 Rajat Mishra. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

typealias imageDownloadCompletionBlock = (Bool, UIImage?)->()

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) -> Void {
        var viewsDirectory = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDirectory[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDirectory))
    }
    
    private static let kRotationAnimationKey = "rotationanimationkey"
    func startRotation(clockWise: Bool = true) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        let fromValue = clockWise ? (Double.pi * 2) : 0
        let toValue = clockWise ? 0 : (Double.pi * 2)
        rotation.fromValue = NSNumber(value: fromValue)
        rotation.toValue = NSNumber(value: toValue)
        rotation.duration = 0.7
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: UIView.kRotationAnimationKey)
    }
}

extension String {
    
    var templatedImage: UIImage {
        return UIImage(named: self)!.withRenderingMode(.alwaysTemplate)
    }
    
    var originalImage: UIImage {
        return UIImage(named: self)!.withRenderingMode(.alwaysOriginal)
    }
    
}

extension UIFont {
    
    class func montserratRegular(withSize size: CGFloat = 13) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    
    class func montserratSemiBold(withSize size: CGFloat = 13) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size)!
    }
}

extension UIColor {
//    static let appPurple = UIColor(named: "appPurple")!
}

extension UIColor {
    @nonobjc class var appPurple: UIColor {
        return UIColor(named: "appPurple")!
    }
     
}

extension DateFormatter {
    ///DateFormatter with current timezone.
    static let MyDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
}

extension UIBarButtonItem { 
    static let flexibleBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
}

extension Date {
    func getString(inFormat: String, apptimeZone: AppTimeZone = .current) -> String {
        let dateFormatter = DateFormatter.MyDateFormatter
        dateFormatter.dateFormat = inFormat
        var timeZone: TimeZone!
        if apptimeZone == .current {
            timeZone = TimeZone.current
        } else {
            timeZone = TimeZone(abbreviation: "UTC")!
        }
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
}

extension UIView {
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            if let bColor = self.layer.borderColor {
                return UIColor(cgColor: bColor)
            }
            return UIColor.black
        }set {
            self.layer.borderColor  = newValue.cgColor
            self.layer.masksToBounds = true
        }
    }
}

protocol StoryboardInstantiable: class {
    static var storyboardIdentifier: String {get}
    static func instantiateFromStoryboard(storyboard: UIStoryboard) -> Self
}

extension UIViewController: StoryboardInstantiable {
    static var storyboardIdentifier: String {
        let classString = NSStringFromClass(self)
        let components = classString.components(separatedBy: ".")
        assert(components.count > 0, "Failed extract class name from \(classString)")
        return components.last!
    }
    
    class func instantiateFromStoryboard(storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> Self {
        return instantiateFromStoryboard(storyboard: storyboard, type: self)
    }
    
    private class func instantiateFromStoryboard<T: UIViewController>(storyboard: UIStoryboard, type: T.Type) -> T {
        return storyboard.instantiateViewController(withIdentifier: self.storyboardIdentifier) as! T
    }
    
    var noDataFoundController: NoDataFoundController? {
        for childVC in children {
            if let noDataFoundVC = childVC as? NoDataFoundController {
                return noDataFoundVC
            }
        }
        print("NoDataFoundController not found")
        return nil
    }
    
    func setupNoDataView(withTitle title: String, description: String, image: UIImage? = nil, onView parentView: UIView? = nil, customFrame: CGRect? = nil, bgColor: UIColor = .clear, setupActionButton1: ((_ button: UIButton) -> Void)?, setupActionButton2: ((_ button: UIButton) -> Void)?) {
        var noDataParentView: UIView!
        if let tempParentView = parentView {
            noDataParentView = tempParentView
        } else {
            noDataParentView = self.view
        }
        let noDataFoundVC = NoDataFoundController.loadNib()
        noDataFoundVC.noDataTitle = title
        noDataFoundVC.noDataDescription = description
        noDataFoundVC.noDataImage = image
        noDataFoundVC.setupActionButton1 = setupActionButton1
        noDataFoundVC.setupActionButton2 = setupActionButton2
        self.addChild(noDataFoundVC)
        noDataParentView.addSubview(noDataFoundVC.view)
        if let customFrame = customFrame {
            noDataFoundVC.view.frame = customFrame
        } else {
            noDataFoundVC.view.frame = noDataParentView.frame
        }
        noDataParentView.sendSubviewToBack(noDataFoundVC.view)
        noDataFoundVC.view.backgroundColor = bgColor
        noDataFoundVC.view.isHidden = true
        noDataFoundVC.didMove(toParent: self)
    }
    
    func hideNoDataView() {
        if let noDataView = noDataFoundController?.view, let noDataSuperView = noDataView.superview {
            noDataSuperView.sendSubviewToBack(noDataView)
            noDataView.isHidden = true
        }
    }
}

//extension UIAlertController {
//
//    class func showAlertWithOk(forTitle title: String, message: String,sender: UIViewController, okTitle: String = "OK", okCompletion: (() -> Void)?) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: okTitle, style: .default) { (okAlertAction) in
//            okCompletion?()
//        }
//        alertController.addAction(okAction)
//        sender.present(alertController, animated: true, completion: nil)
//    }
//
//}


extension UIImageView {
    
    func downloadImage(forURL imageURL: String, placeHolderImage: UIImage? = "no_image".originalImage, withName imageName: String = "", completion: imageDownloadCompletionBlock? = nil) {
        sd_setImage(with: URL(string: imageURL), placeholderImage: placeHolderImage) { (img, error, _, _) in
            if let downloadedImage = img {
                self.image = downloadedImage
            }
            completion?(error == nil, img)
        }
    }
    
}

extension NSObject {
    
    class var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
    var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
}
