//
//  CustomError.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 5.06.2022.
//

import Foundation

enum CustomError: Int {
    case unknownError = -1
    case noResponseData = 1
    case invalidData = 2
    case noData = 3
    
    private var message: String {
        switch self {
        case .unknownError:
            return "error_unknown"
        case .noResponseData:
            return "error_no_response"
        case .invalidData:
            return "error_invalid_data"
        case .noData:
            return "error_no_data"
        }
    }
    
    var error: Error {
        return NSError(domain: "Movinvio", code: self.rawValue, userInfo: [NSLocalizedDescriptionKey : message])
    }
    
    static func errorWithMessage(message: String?) -> Error {
        if let message = message {
            return NSError(domain: "Movinvio", code: -1, userInfo: [NSLocalizedDescriptionKey : message])
        }
        return CustomError.unknownError.error
    }
}
