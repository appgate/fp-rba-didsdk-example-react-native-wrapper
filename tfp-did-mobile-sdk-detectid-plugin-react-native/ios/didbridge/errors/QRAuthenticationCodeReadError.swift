//
//  QRAuthenticationCodeReadError.swift
//  Pods
//
//  Created by Daniel Ayala on 1/11/22.
//

import Foundation

enum QRAuthenticationCodeReadError : Error {
    case serverError
}

extension QRAuthenticationCodeReadError : CustomStringConvertible {
    public var description: String {
        switch self {
            case .serverError:
            return "Server Error response."
        }
    }
}
