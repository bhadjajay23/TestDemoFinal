//
//  BookResponse.swift
//  IgniteSolPracticalTest
//
//  Created by Grave Walker on 2/25/20.
//  Copyright © 2020 Rajat Mishra. All rights reserved.
//

import Foundation

struct BookResponse : Codable {
    
    let next : String?
    let count : Int?
    let previous : String?
 
    enum CodingKeys: String, CodingKey {

        case next = "next"
        case count = "count"
        case previous = "previous"
     }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
     }

}
