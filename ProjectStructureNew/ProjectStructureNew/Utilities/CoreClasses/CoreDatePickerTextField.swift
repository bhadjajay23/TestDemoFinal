//
//  CoreDatePickerTextField.swift
//  MyTable
//
//  Created by Yagnik Suthar on 6/8/19.
//  Copyright © 2019 MyTable. All rights reserved.
//

import UIKit

class CoreDatePickerTextField: CoreTextField {
    
    //MARK: - Controls
    public lazy var datePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        return pickerView
    }()
    private var toolBar: CoreToolbar!
    
    //MARK: - Properties
    var blockForCancelButtonTap: voidCompletion?
    var blockForDoneButtonTap: ((_ selectedDate: Date, _ selectedDateString: String)->Void)?
    var datePickerMode: UIDatePicker.Mode = .dateAndTime {
        didSet {
//            self.datePicker.minimumDate = Date()
            self.datePicker.datePickerMode = self.datePickerMode
        }
    }
    
    //MARK: - Methods
    override func commonInit() {
        super.commonInit()
        toolBar = CoreToolbar.getToolbar(doneTitle: doneButtonTitle,doneCompletion: {
            self.resignFirstResponder()
            var value = ""
            switch self.datePickerMode {
            case .time:
                value = self.datePicker.date.getString(inFormat: "hh:mm a")
                break
            case .date:
                value = self.datePicker.date.getString(inFormat: "dd-MM-yyyy")
                break
            case .dateAndTime:
                value = self.datePicker.date.getString(inFormat: "dd-MM-yyyy hh:mm:ss a")
                break
            case .countDownTimer:
                value = ""
                break
            @unknown default:
                break
            }
            self.blockForDoneButtonTap?((self.datePicker.date), value)
        }, cancelCompletion: {
            self.resignFirstResponder()
            self.blockForCancelButtonTap?()
        })
        toolBar.sizeToFit()
        inputView = datePicker
        inputAccessoryView = toolBar
    }
    
}
