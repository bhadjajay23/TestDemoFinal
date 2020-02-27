//
//  LoadingView.swift
//  IgniteSolPracticalTest
//
//  Created by Grave Walker on 2/25/20.
//  Copyright © 2020 Rajat Mishra. All rights reserved.
//

import UIKit

class LoadingView: NSObject {
    
    static let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.5
        return view
    }()
    
    static let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    static let progressImageView: UIImageView = {
        let aiView = UIImageView()
        aiView.image = "ic_progress".templatedImage
        aiView.tintColor = .red
        aiView.translatesAutoresizingMaskIntoConstraints = false
        return aiView
    }()
    
    static let activityIndicatorView: UIActivityIndicatorView = {
        let aiView = UIActivityIndicatorView()
        aiView.style = UIActivityIndicatorView.Style.large
        aiView.color = .red
        aiView.translatesAutoresizingMaskIntoConstraints = false
        return aiView
    }()
    
    
    class func showLoading() {
        if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first {
            
            window.addSubview(transparentView)
            window.addConstraintsWithFormat("H:|[v0]|", views: transparentView)
            window.addConstraintsWithFormat("V:|[v0]|", views: transparentView)
            
            window.addSubview(containerView)
            window.addConstraints([
                NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: window, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: window, attribute: .height, multiplier: 0.15, constant: 0),
                NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1, constant: 0)])
            
            containerView.addSubview(activityIndicatorView)
            
            containerView.addConstraints([
                NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: activityIndicatorView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0.8, constant: 0),
                NSLayoutConstraint(item: activityIndicatorView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1, constant: 0)])
            activityIndicatorView.startAnimating()
//            progressImageView.startRotation(clockWise: false)
        }
    }
    
    class func hideLoading() {
        progressImageView.removeFromSuperview()
        transparentView.removeFromSuperview()
        containerView.removeFromSuperview()
        activityIndicatorView.stopAnimating()
    }
    
    
}
