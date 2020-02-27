//
//  NetworkingSetup.swift
//  ProjectStructureNew
//
//  Created by Jay on 2/25/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation
import Alamofire

typealias ParameterKey = NetworkingSetup.APIParameterKey
typealias HTTPHeaderField = NetworkingSetup.HTTPHeaderField
typealias ContentType = NetworkingSetup.ContentType
typealias PageLimit = NetworkingSetup.PageLimit
let PAGINATION_LIMIT = "10"

struct NetworkingSetup {
    
    struct APIParameterKey {
        static let page = "page"
        static let topic = "topic"
        static let mime_type = "mime_type"
        static let search = "search"
    }
    
    struct HTTPHeaderField {
        
    }
    
    struct ContentType {
        static let json = "application/json"
    }
    
    struct PageLimit {
        let page: String
        var limit: String = PAGINATION_LIMIT
        init(page: String, limit: String = PAGINATION_LIMIT) {
            self.page = page
            self.limit = limit
        }
    }
}
