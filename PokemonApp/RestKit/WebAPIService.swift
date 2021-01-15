//
//  WebService.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

// MARK:- WebService
public protocol WebAPIService : WebAPIFoundation {
    
    var scheme      : HTTPScheme        { get }
    var host        : String            { get }
    var path        : String            { get }
    var port        : Int               { get }
    var queryItems  : [URLQueryItem]?   { get }
    var method      : HTTPMethod        { get }
    var headers     : HTTPHeader?       { get }
    var payload     : Data?             { get }
    
    func base64EncodedCredentials(user: String, secret: String) throws -> String
    
}

public extension WebAPIService {

    var scheme      : HTTPScheme        { .Https }
    var path        : String            { "/" }
    var port        : Int               { scheme.port }
    var queryItems  : [URLQueryItem]?   { nil }
    var method      : HTTPMethod        { .Get }
    var headers     : HTTPHeader?       { nil }
    var payload     : Data?             { nil }
    
    
// MARK:- Public methods
    
    
    
    // MARK:- base64EncodedCredentials(_:)
    func base64EncodedCredentials(user: String, secret: String) -> String {
        guard let encodedString = String(format: "%@:%@", user, secret).data(using: .utf8) else {
            print("Basic authentication base64 string failed to generate due to invalid characters in user or secret params")
            return String()
        }
        return encodedString.base64EncodedString()
    }
    
}
