//
//  Dictionary.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    mutating func union(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
    
    var description : String {
        var description : [String] = []
        for (key, value) in self {
            switch value {
            case let value as Int:
                description.append("\(key): \(value)")
            case let value as Int8:
                description.append("\(key): \(value)")
            case let value as Int16:
                description.append("\(key): \(value)")
            case let value as Int32:
                description.append("\(key): \(value)")
            case let value as Int64:
                description.append("\(key): \(value)")
            case let value as UInt:
                description.append("\(key): \(value)")
            case let value as UInt8:
                description.append("\(key): \(value)")
            case let value as UInt16:
                description.append("\(key): \(value)")
            case let value as UInt32:
                description.append("\(key): \(value)")
            case let value as UInt64:
                description.append("\(key): \(value)")
            case let value as Float:
                description.append("\(key): \(value)")
            case let value as Float64:
                description.append("\(key): \(value)")
            case let value as Float80:
                description.append("\(key): \(value)")
            case let value as Double:
                description.append("\(key): \(value)")
            case let value as String:
                description.append("\(key): \(value)")
            case let value as Dictionary:
                description.append("\(key): \(value)")
            case let value as Array<Any>:
                description.append("\(key): \(value)")
            default:
                description.append("\(key): \(value)")
            }
        }
        return "[\(description.sorted(by: { $0 > $1 }).joined(separator: ", "))]"
    }
    
    
}
