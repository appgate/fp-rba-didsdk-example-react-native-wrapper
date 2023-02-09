//
//  Dictionary+JSON.swift
//  DIDReact
//
//  Created by Camilo Ortegon on 10/12/22.
//

import Foundation

extension Dictionary {
  
  func toJson() -> String {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
      return String(data: jsonData, encoding: .utf8) ?? "{}"
    } catch {
      print(error.localizedDescription)
      return "{}"
    }
  }
  
}
