//
//  CodableConverter.swift
//  tfp-did-mobile-sdk-detectid-plugin-react-native
//
//  Created by Daniel Ayala on 31/10/22.
//

import Foundation

enum CodableConverterError: Int, Error {
    case errorDecoding
}

struct CodableConverter {
    
    static func getCodable<T : Codable>(jsonDictionary: Dictionary<String, Any>) throws -> T {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CodableConverterError.errorDecoding
        }
    }
    
    static func getCodable<T : Codable>(jsonString: String) throws -> T {
        do {
            let data = Data(jsonString.utf8)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CodableConverterError.errorDecoding
        }
    }
    
    static  func getData<T: Codable>(codable: T) -> Data? {
        do {
            return try JSONEncoder().encode(codable)
        } catch {
            return nil
        }
    }
    
    static func getDictionary<T: Codable>(codable: T) -> [String: Any]? {
        guard let jsonData = self.getData(codable: codable) else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        } catch {
            return nil
        }
    }
}
