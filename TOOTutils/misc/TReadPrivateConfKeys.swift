//
//  TReadPrivateConfKeys.swift
//  TOOTutils
//
//  Created by thor on 23/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import Foundation

 

enum TReadPrivateConfKeys {
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
