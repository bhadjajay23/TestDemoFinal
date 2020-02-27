//
//  LoadMoreTableHeaderFooterView.swift
//  MyTable
//
//  Created by baps on 28/05/19.
//  Copyright © 2019 Yagnik Suthar. All rights reserved.
//

import UIKit

class LoadMoreTableHeaderFooterView: CoreTableHeaderFooterView {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    class func fromNib() -> LoadMoreTableHeaderFooterView {
        return Bundle.main.loadNibNamed(String(describing: LoadMoreTableHeaderFooterView.self), owner: nil, options: nil)![0] as! LoadMoreTableHeaderFooterView
    }
    
    func isAnimating() -> Bool {
        return activityIndicator.isAnimating
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }

}
