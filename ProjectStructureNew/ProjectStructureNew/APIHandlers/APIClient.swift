//
//  APIClient.swift
//  ProjectStructureNew
//
//  Created by Jay on 27/02/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation
import Alamofire

struct APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route: APIRouter, doShowLoading: Loading = (true, false), decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, AFError>) -> Void) -> DataRequest {
        print("Request: ")
        debugPrint(route.urlRequest!)
        if let headers = route.urlRequest?.headers {
            print("Headers: ")
            debugPrint(headers)
        }
        if let body = route.urlRequest?.httpBody {
            print("Params: ")
            debugPrint(String(data: body, encoding: .utf8) ?? "")
        }
        if doShowLoading.showLoader {
            LoadingView.showLoading()
        }
        
        func handle(response: DataResponse<T, AFError>) {
            LoadingView.hideLoading()
            if let urlResponse = response.response {
                print("Status Code: \(urlResponse.statusCode)")
                if !(urlResponse.statusCode >= 200 && urlResponse.statusCode <= 210) {
                    if let responseError = response.error {
                        completion(.failure(responseError))
                    } else {
                        completion(.failure(.sessionInvalidated(error: NSError(domain: "", code: urlResponse.statusCode, userInfo: [:]))))
                    }
                } else {
                    completion(response.result)
                }
            } else {
                completion(response.result)
            }
            if let data = response.data {
                print("Response: ")
                let responseString = String(data: data, encoding: .utf8) ?? ""
                print(responseString)
            }
        }
        
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                handle(response: response)
        }
    }
    
    static func fetchBooks(for category: BookCategory, withPage page: Int, search: String, doShowLoading: Loading = (true, false), completion: @escaping (Result<BookResponse, AFError>) -> Void){
        performRequest(route: APIRouter.fetchBooks(category: category, page: page, search: search), doShowLoading: doShowLoading, completion: completion)
    }
     
}
