//
//  File.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/12/24.
//

import Foundation

final class JSONConverter{
    static func decodeJsonArray<T: Codable>(data: Data) -> [T]? {
        do {
            let result = try JSONDecoder().decode([T].self, from: data)
            return result
        }catch{
            guard let error = error as? DecodingError else {return nil}
            switch error {
            case .dataCorrupted(let context):
                print(context.codingPath, context.debugDescription, context.underlyingError ?? "", separator: "\n")
                return nil
            default:
                return nil
            }
        }
    }
    
    static func decodeJson<T: Codable>(data: Data) -> T? {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        }catch{
            guard let error = error as? DecodingError else {return nil}
            switch error {
            case .dataCorrupted(let context):
                print(context.codingPath, context.debugDescription, context.underlyingError ?? "", separator: "\n")
                return nil
            default:
                return nil
            }
        }
    }
    
    static func decodeVocabListJson<T: Codable>(data: Data) -> T? {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch let error as DecodingError {
            switch error {
            case .dataCorrupted(let context):
                print(context.codingPath, context.debugDescription, context.underlyingError ?? "", separator: "\n")
            case .keyNotFound(let key, let context):
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .valueNotFound(let value, let context):
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .typeMismatch(let type, let context):
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            @unknown default:
                print("Unknown decoding error")
            }
            return nil
        } catch {
            print("Unexpected error:", error)
            return nil
        }
    }
    
    static func decodeVocabListJsonArray<T: Codable>(data: Data) -> [T]? {
        do {
            let result = try JSONDecoder().decode([T].self, from: data)
            return result
        } catch let error as DecodingError {
            switch error {
            case .dataCorrupted(let context):
                print(context.codingPath, context.debugDescription, context.underlyingError ?? "", separator: "\n")
            case .keyNotFound(let key, let context):
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .valueNotFound(let value, let context):
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .typeMismatch(let type, let context):
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            @unknown default:
                print("Unknown decoding error")
            }
            return nil
        } catch {
            print("Unexpected error:", error)
            return nil
        }
    }
    
    
    static func encodeJson<T:Codable>(param: T) -> Data? {
        do {
            let result = try JSONEncoder().encode(param)
            return result
        }catch{
            return nil
        }
    }
}
