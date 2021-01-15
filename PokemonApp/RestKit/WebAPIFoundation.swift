//
//  WebAPIFoundation.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

// MARK:- HTTPHeader
// public typealias HTTPHeader = (field: String, value: String)
public typealias HTTPHeader = [String: String]


// MARK:- HTTPScheme
public enum HTTPScheme {
    
    case Http
    case Https
    case CustomHTTP(Int)
    case CustomHTTPS(Int)
    
    init?(port: Int) {
        switch port {
        case 80: self = .Http
        case 443: self = .Https
        default:
            return nil
        }
    }
    
    var port : Int {
        switch self {
        case .Http:
            return 80
        case .Https:
            return 443
        case .CustomHTTP(let value),
             .CustomHTTPS(let value):
            return value
        }
    }
    
    var description : String {
        switch self {
        case .CustomHTTP: return "http"
        case .CustomHTTPS: return "https"
        default:
            return "\(self)".components(separatedBy: "(").first ?? ""
        }
    }
    
    
}

// MARK:- HTTPMethod
public enum HTTPMethod : String {
    
    case Get     = "GET"
    case Post    = "POST"
    case Put     = "PUT"
    case Delete  = "DELETE"
    case Head    = "HEAD"
    case Connect = "CONNECT"
    case Options = "OPTIONS"
    case Patch   = "PATCH"
}


// MARK:- WebAPIFoundation
public protocol WebAPIFoundation { }

public extension WebAPIFoundation  {
    
    private var DEBUG_LOG: Bool { false }
    private var DEBUG_LOG_HEADER_DETAIL: Bool { false }
    private var DEBUG_LOG_BODY_DETAIL: Bool { false }
    
    // MARK:- logError(_:error:)
    // Debug Error provide detailed logs for troubleshooting
    func logError<T>(_ error: T, file: String = #file, line: Int = #line, function: String = #function) {
        if DEBUG_LOG {
            print("\n\(file.components(separatedBy: "/").last ?? "")", line, function)
            print("@@@@@@@@@@@ Error::\n---")
            print(customErrorDescription(error))
        }
    }
    
    
    // MARK:- logSession(_:(..))
    func logSession(_ result: (request: URLRequest, data: Data?, response: URLResponse?, error: Error?), file: String = #file, line: Int = #line, function: String = #function) {
        if DEBUG_LOG {
            print("\n\(file.components(separatedBy: "/").last ?? "")", #line, #function)
            print("@@@@@@@@@@@ HTTP Request::\n---")
            print(customURLRequestDescription(result.request))
        }
        
        result.error ?! {
            if DEBUG_LOG {
                print("@@@@@@@@@@@ Error::\n---")
                print(customErrorDescription($0))
                return
            }
        }
        
        result.response as? HTTPURLResponse ?! { response in
            if DEBUG_LOG_HEADER_DETAIL {
                print("@@@@@@@@@@@ HTTP Response::\n---")
                print(customURLResponseDescription(response))
            }
        }
        
        result.data ?! { data in
            if DEBUG_LOG_BODY_DETAIL {
                print("\nBody:")
                print(String(decoding: data, as: UTF8.self), "\n")
            }
        }
        
    }
    
    // MARK:- customURLResponseDescription(_:)
    func customURLResponseDescription(_ response: HTTPURLResponse) -> String {
        var attributes : [String?] = []
        attributes.append(contentsOf: [response.url ?! { "URL: \($0.absoluteString)"},
                                       "Status code: \(response.statusCode) (\(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))",
                                       "\nHeader:"])
        response.allHeaderFields.forEach({ (key, value) in
            attributes.append(" \(key) = `\(value)`")
        })
        
        return attributes.compactMap { $0 }.joined(separator: "\n") + "\n"
    }
    
    // MARK:- customURLRequestDescription(_:)
    func customURLRequestDescription(_ request: URLRequest) -> String {
        var attributes : [String?] = []
        attributes.append(contentsOf: [request.url ?! { "URL: \($0.absoluteString)"},
                                       request.httpMethod ?! { "Method: \($0)" },
                                       "\nHeader:"])
        request.allHTTPHeaderFields?.forEach({ (key, value) in
            attributes.append(" \(key) = `\(value)`")
        })
        
        attributes.append(request.httpBody ?! { "\($0)" })
        return attributes.compactMap { $0 }.joined(separator: "\n") + "\n"
    }
    
    // MARK:- customErrorDescription(_:)
    func customErrorDescription<E>(_ error: E) -> String {
        var attributes : [String?] = []
        switch error {
        case let error as DecodingError:
            switch error {
            case .keyNotFound(let key, let context):
                attributes.append(contentsOf: ["Key '\(key)' not found:", context.debugDescription])
            case .valueNotFound(let value, let context):
                attributes.append(contentsOf: ["Value '\(value)' not found:", context.debugDescription])
            case .typeMismatch(let type, let context):
                attributes.append(contentsOf: ["Type '\(type)' mismatch:", context.debugDescription])
            case .dataCorrupted(let context):
                attributes.append(context.debugDescription)
            default:
                attributes.append(contentsOf: [error.errorDescription,
                                               error.failureReason,
                                               error.recoverySuggestion])
            }
            
        case let error as URLError:
            attributes.append(contentsOf: [error.localizedDescription,
                                           error.code.localizedDescription])
//                                           error.backgroundTaskCancelledReason?.localizedDescription,
//                                           error.networkUnavailableReason?.localizedDescription])
        case let error as NSError:
            attributes.append(contentsOf: [error.localizedDescription,
                                           error.localizedFailureReason,
                                           error.localizedRecoverySuggestion])
        case let error as LocalizedError:
            attributes.append(contentsOf: [error.errorDescription,
                                           error.failureReason,
                                           error.recoverySuggestion])
        default:
            attributes.append("Unhandled error code")
        }
        return attributes.compactMap { $0 }.joined(separator: " ")
    }
    
    
    
}


