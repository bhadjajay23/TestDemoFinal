//
//  NoDataFoundController.swift
//  MyTable
//
//  Created by Yagnik Suthar on 4/24/19.
//  Copyright © 2019 bito1. All rights reserved.
//

import UIKit

class NoDataFoundController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var noDataImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var actionButton1: UIButton!
    @IBOutlet private weak var actionButton2: UIButton!
    @IBOutlet private weak var actionButton1HeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var actionButton2HeightConstraint: NSLayoutConstraint!
    
    //MARK: Properties
    var noDataImage: UIImage?
    var setupActionButton1: ((_ button: UIButton) -> Void)?
    var setupActionButton2: ((_ button: UIButton) -> Void)?
    var noDataTitle: String = "" {
        didSet {
            if titleLabel != nil {
                titleLabel.text = noDataTitle
            }
        }
    }
    var noDataDescription: String = "" {
        didSet {
            if descriptionLabel != nil {
                descriptionLabel.text = noDataDescription
            }
        }
    }
    var doHideActionButton1: Bool = false {
        didSet {
            if actionButton1 != nil {
                actionButton1.isHidden = doHideActionButton1
            }
        }
    }
    var doHideActionButton2: Bool = false {
        didSet {
            if actionButton2 != nil {
                actionButton2.isHidden = doHideActionButton2
            }
        }
    }
    var actionButton1Height: CGFloat = 0.0 {
        didSet {
            if actionButton1 != nil && actionButton1HeightConstraint != nil {
                actionButton1HeightConstraint.constant = actionButton1Height
            }
        }
    }
    var actionButton2Height: CGFloat = 0.0 {
        didSet {
            if actionButton2 != nil && actionButton2HeightConstraint != nil {
                actionButton2HeightConstraint.constant = actionButton2Height
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }

    private func setupData() {
        titleLabel.text = noDataTitle
        descriptionLabel.text = noDataDescription
        noDataImageView.image = noDataImage
        actionButton1.isHidden = setupActionButton1 == nil
        actionButton2.isHidden = setupActionButton2 == nil
        view.isUserInteractionEnabled = !(actionButton1.isHidden && actionButton2.isHidden)
        setupActionButton1?(actionButton1)
        setupActionButton2?(actionButton2)
    }
    
    static func loadNib() -> NoDataFoundController {
        let noDataFoundVC = NoDataFoundController(nibName: Nib.NoDataFoundController, bundle: Bundle.main)
        return noDataFoundVC
    }
    
}
