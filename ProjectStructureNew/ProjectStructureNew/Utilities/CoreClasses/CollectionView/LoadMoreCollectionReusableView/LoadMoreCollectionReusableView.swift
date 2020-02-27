//
//  LoadMoreCollectionReusableView.swift
//  MyTable
//
//  Created by baps on 28/05/19.
//  Copyright © 2019 Yagnik Suthar. All rights reserved.
//

import UIKit

class LoadMoreCollectionReusableView: CoreCollectionReusableView {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
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
