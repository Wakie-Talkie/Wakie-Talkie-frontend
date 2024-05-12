//
//  HTTPMethod.swift
//  Wakie-Talkie
//
//  Created by jiin on 5/12/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    
    var description:String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
