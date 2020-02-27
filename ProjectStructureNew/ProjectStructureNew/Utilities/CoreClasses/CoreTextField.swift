//
//  CoreTextField.swift
//  IgniteSolPracticalTest
//
//  Created by Grave Walker on 2/25/20.
//  Copyright © 2020 Rajat Mishra. All rights reserved.
//

import UIKit

class CoreTextField: UITextField, UITextFieldDelegate {
    
    //MARK: - Properties
    @IBInspectable var fontFamily: Int = 0 {
        didSet {
            setFont()
        }
    }
    @IBInspectable var fontSize: CGFloat = 15 {
        didSet {
            setFont()
        }
    }
    @IBInspectable var localizePlaceholderKey: String = "" {
        didSet {
            placeholder = localizePlaceholderKey
        }
    }
    @IBInspectable var localizeTextKey: String = "" {
        didSet {
            
        }
    }
    @IBInspectable var leftImage: UIImage? = nil {
        didSet {
            setupLeftImage()
        }
    }
    @IBInspectable var rightImage: UIImage? = nil {
        didSet {
            setupRightImage()
        }
    }
    @IBInspectable var leftRightImageWidth: CGFloat = 21 {
        didSet {
            rightView?.frame = CGRect(x: 0, y: 0, width: leftRightImageWidth+8+12, height: frame.size.height)
            leftView?.frame = CGRect(x: 0, y: 0, width: leftRightImageWidth+8+6, height: frame.size.height)
        }
    }
    @IBInspectable var doneButtonTitle: String = "Done"
    
    static let defaultRightPadding: CGFloat = 4
    static let defaultLeftPadding: CGFloat = 14
    var padding = UIEdgeInsets(top: 0, left: CoreTextField.defaultLeftPadding, bottom: 0, right: CoreTextField.defaultRightPadding)
    override var placeholder: String? {
        didSet {
            if let newPlaceHolder = placeholder {
                let placeHoderFont = UIFont.montserratSemiBold(withSize: fontSize)
                attributedPlaceholder = NSAttributedString(string: newPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: placeHoderFont])
            }
        }
    }
    var blockForShouldReturn: (()->Bool)?
    var blockForShouldBeginEditing: (()->Bool)?
    var blockForShouldChangeCharacters: ((_ range: NSRange, _ replacementString: String)->Bool)?
    var blockForTextChange: ((_ newText: String)->Void)? {
        didSet {
            if blockForTextChange != nil {
                addTarget(self, action: #selector(textFieldEditingChange(_:)), for: .editingChanged)
            }
        }
    }
    var rightViewTapped: voidCompletion? {
        didSet {
            if rightViewTapped != nil {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(rightViewTapped(gesture:)))
                rightView?.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    //MARK: - Setup Methods
    func commonInit() {
        setFont()
        delegate = self
        enablesReturnKeyAutomatically = true
    }
    private func setFont () {
        if fontFamily == 0 {
            font = UIFont.montserratSemiBold(withSize: fontSize)
        }
    }
    private func setupLeftImage() {
        if let img = self.leftImage {
            let rightVw = UIView(frame: CGRect(x: 0, y: 0, width: leftRightImageWidth+8+6, height: frame.size.height))
            let imgView = UIImageView(image: img)
            imgView.contentMode = .scaleAspectFit
            rightVw.addSubview(imgView)
            rightVw.addConstraintsWithFormat("H:|-8-[v0]-6-|", views: imgView)
            rightVw.addConstraintsWithFormat("V:|-6-[v0]-6-|", views: imgView)
            leftView = rightVw
            leftViewMode = .always
            updatePadding()
        } else {
            leftViewMode = .always
        }
    }
    
    private func setupRightImage() {
        if let img = self.rightImage {
            let rightVw = UIView(frame: CGRect(x: 0, y: 0, width: leftRightImageWidth+8+12, height: frame.size.height))
            let imgView = UIImageView(image: img)
            imgView.contentMode = .scaleAspectFit
            rightVw.addSubview(imgView)
            rightVw.addConstraintsWithFormat("H:|-8-[v0]-12-|", views: imgView)
            rightVw.addConstraintsWithFormat("V:|-6-[v0]-6-|", views: imgView)
            rightView = rightVw
            rightViewMode = .always
            updatePadding()
        } else {
            rightViewMode = .never
        }
    }
    
    private func updatePadding() {
        if let rightVw = rightView {
            padding.right = rightVw.frame.size.width
        } else {
            padding.right = CoreTextField.defaultRightPadding
        }
        
        if let rightVw = leftView {
            padding.left = rightVw.frame.size.width
        } else {
            padding.left = CoreTextField.defaultLeftPadding
        }
    }
    
    @objc private func rightViewTapped(gesture: UITapGestureRecognizer) {
        rightViewTapped?()
    }
    
    @objc func textFieldEditingChange(_ sender: UITextField) {
        blockForTextChange?(sender.text!)
    }
    
    func bind(callback :@escaping (String) -> ()) {
        self.blockForTextChange = callback
    }
    
    //MARK: - UITextFieldDelegate Methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let returnBlock = blockForShouldBeginEditing {
            return returnBlock()
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let returnBlock = blockForShouldReturn {
            let res = returnBlock()
            if res {
                self.resignFirstResponder()
            }
            return res
        }
        self.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return blockForShouldChangeCharacters?((range), string) ?? true
    }
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        commonInit()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }
    
}
