//
//  ImagePickerController.swift
//  RateMaster
//
//  Created by Yagnik Suthar on 6/2/19.
//  Copyright © 2019 RateMaster. All rights reserved.
//

import UIKit
import AVFoundation

class ImagePickerController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
    fileprivate lazy var imagePickerController: CoreImagePickerController = {
        let ipc = CoreImagePickerController()
        ipc.delegate = self
        ipc.allowsEditing = true
        return ipc
    }()
    static let shared = ImagePickerController()
    var imagePickedCompletion: ((_ pickedImage: UIImage?, _ cancelled: Bool, _ removed: Bool)->()) = { _, _, _  in }

    //MARK: - Methods
    func showPicker(onController viewController: UIViewController, withRemoveOption: Bool = false, completion: @escaping (_ pickedImage: UIImage?, _ cancelled: Bool, _ removed: Bool)->Void) {
        var options = [("Take A New Photo", false),("Select From Photos", false)]
        if withRemoveOption {
            options.append(("Remove Photo", true))
        }
        CustomAlertController.showActionSheet(forTitle: "", message: "Choose any option", sender: viewController, withActionTitles: options, isCancellable: true) { (index) in
            self.imagePickedCompletion = completion
            switch index {
            case 0:
                self.imagePickerController.sourceType = .camera
                self.checkPermission(completion: { (isGranted) in
                    if isGranted {
                        viewController.present(self.imagePickerController, animated: true, completion: nil)
                    } else {
                        CustomAlertController.showAlertWithOkCancel(forTitle: "Camera permission needed!", message: "Please grant camera permission to capture photos", sender: viewController, okTitle: "Settings", okCompletion: {
                            if let appSettingsURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettingsURL) {
                                UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)
                            }
                        }, cancelCompletion: nil)
                    }
                })
                break
            case 1:
                self.imagePickerController.sourceType = .photoLibrary
                viewController.present(self.imagePickerController, animated: true, completion: nil)
                break
            case 2:
                completion(nil, !withRemoveOption, withRemoveOption)
            default:
                break
            }
        }
    }
    
    private func checkPermission(completion: @escaping boolCompletion) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            completion(true)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imagePickedCompletion(image, false, false)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imagePickedCompletion(nil, false, false)
    }
}

private class CoreImagePickerController: UIImagePickerController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos"
        navigationBar.barTintColor = UIColor.gray
        navigationBar.tintColor = UIColor.orange
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: AppFont.montserratRegular.getFont(withSize: 17)]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}
