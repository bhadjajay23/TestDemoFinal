//
//  CoreCollectionCell.swift
//  IgniteSolPracticalTest
//
//  Created by Grave Walker on 2/25/20.
//  Copyright © 2020 Rajat Mishra. All rights reserved.
//

import UIKit

class CoreCollectionCell: UICollectionViewCell {

    //MARK: - Properties
    static var identifier : String {
        return String(describing: self)
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
        
    }
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
