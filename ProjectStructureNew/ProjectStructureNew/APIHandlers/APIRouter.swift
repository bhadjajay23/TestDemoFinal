//
//  APIRouter.swift
//  ProjectStructureNew
//
//  Created by Jay on 2/25/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case fetchBooks(category: BookCategory, page: Int, search: String)
     
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .fetchBooks: return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .fetchBooks: return "books"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
            //        case .register(_ , _, _):
        //            return [:]
        case .fetchBooks(let category, let page, let search):
            return [ParameterKey.page: page, ParameterKey.topic: category.title, ParameterKey.search: search]
        }
    }
    
    var formData: MultipartFormData? {
        var params: MultipartFormData?
        switch self {
            //        case .register(let user, let profilePic, let guest_user_id):
            //            params = MultipartFormData()
            //            params?.add(key: ParameterKey.first_name, value: user.first_name ?? "")
            //            if let profileImage = profilePic, let imageData = profileImage.jpegData(compressionQuality: 0.7) {
            //                params?.append(imageData, withName: ParameterKey.photo, fileName: "image\(Date()).jpg", mimeType: "image/jpeg")
        //            }
        default:
            return params
        }
    }
    
    
    //MARK: - Headers
    /*private var headers: HTTPHeaders {
     let defaultHeaders = HTTPHeaders([HTTPHeaderField.authorization: ""])
     switch self {
     default:
     break
     }
     return defaultHeaders
     }*/
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: Environment.rootURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        //urlRequest.headers = headers        
        do {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        return urlRequest
    }
}
