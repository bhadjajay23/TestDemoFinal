//
//  Constants.swift
//  IgniteSolPracticalTest
//
//  Created by Grave Walker on 2/25/20.
//  Copyright © 2020 Rajat Mishra. All rights reserved.
//

import UIKit

typealias SegueIdentifiers = Storyboard.SegueIdentifiers
typealias Loading = (showLoader: Bool, showTransparentView: Bool)
typealias boolCompletion = ((_ success: Bool)->Void)
typealias voidCompletion = (()->Void)
typealias Nib = Storyboard.Nib
typealias VCIdentifier = Storyboard.VCIdentifier

enum AppFont : Int {
    case montserratRegular = 0
    
    func getFont(withSize size: CGFloat = 18) -> UIFont {
        switch self {
        case .montserratRegular:
            return UIFont.montserratRegular(withSize: size)
        }
    }
}

enum Storyboard {
    
    enum SegueIdentifiers {
//        static let ShowBooksVC = "ShowBooksVC"
    }
    
    enum VCIdentifier {
//        static let ShowBooksVC = "ShowBooksVC"
    }
    
    enum Nib {
        static let NoDataFoundController = "NoDataFoundController"
    } 
}

enum AppTimeZone {
    case current
    case utc
}

enum BookCategory: CaseIterable {
    case fiction
    case drama
    case humor
    case politics
    case philosophy
    case history
    case adventure
    
    var title: String {
        switch self {
        case .fiction: return "FICTION"
        case .drama: return "DRAMA"
        case .humor: return "HUMOUR"
        case .politics: return "POLITICS"
        case .philosophy: return "PHILOSOPHY"
        case .history: return "HISTORY"
        case .adventure: return "ADVENTURE"
        }
    }
    
    var image: UIImage {
        switch self {
        case .fiction: return "Fiction".originalImage
        case .drama: return "Drama".originalImage
        case .humor: return "Humour".originalImage
        case .politics: return "Politics".originalImage
        case .philosophy: return "Philosophy".originalImage
        case .history: return "History".originalImage
        case .adventure: return "Adventure".originalImage
        }
    }
}
