//
//  HTTPManager.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/12/24.
//

import Foundation
import os

final class HTTPManager{
    static func requestGET(url: String, complete: @escaping (Data) -> ()){
        guard let validURL = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = HTTPMethod.get.description
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else { return }
            guard let response = urlResponse as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                if let response = urlResponse as? HTTPURLResponse {
                    os_log("%@", "\(response.statusCode)")
                }
                return
            }
            
            complete(data)
        }.resume()
    }
    
    static func requestPOST(url: String, encodingData: Data? = nil, complete: @escaping (Data) -> ()){
        guard let validURL = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url:validURL)
        urlRequest.httpMethod = HTTPMethod.post.description
        
        if let data = encodingData{
            urlRequest.httpBody = data
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else { return }
            guard let response = urlResponse as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                if let response = urlResponse as? HTTPURLResponse {
                    os_log("%@", "\(response.statusCode)")
                }
                return
            }
            complete(data)
        }.resume()
    }
    
    static func requestPATCH(url: String, encodingData: Data, complete: @escaping (Data) -> ()) {
        guard let validURL = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url:validURL)
        urlRequest.httpMethod = HTTPMethod.patch.description
        urlRequest.httpBody = encodingData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("\(encodingData.count)", forHTTPHeaderField: "Content-Length")
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else { return }
            guard let response = urlResponse as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                if let response = urlResponse as? HTTPURLResponse {
                    os_log("%@", "\(response.statusCode)")
                }
                return
            }
            complete(data)
        }.resume()
    }
    
    static func requestDELETE(url: String, encodingData: Data, complete: @escaping (Data) -> ()) {
        guard let validURL = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url:validURL)
        urlRequest.httpMethod = HTTPMethod.delete.description
        urlRequest.httpBody = encodingData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else { return }
            guard let response = urlResponse as? HTTPURLResponse, (200..<300).contains(response.statusCode) else { return }
            complete(data)
        }.resume()
    }
}
