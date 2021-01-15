//
//  URLError.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

@available(iOS 13.0, *)
extension URLError {
    
    static func localizedDescription(forNetworkUnavailableReasonCode code: URLError.NetworkUnavailableReason) -> String {
        return code.localizedDescription
    }
    
    static func localizedDescription(forBackgroundTaskCancelledReasonCode code: URLError.BackgroundTaskCancelledReason) -> String {
        return code.localizedDescription
    }
    
    static func localizedDescription(forURLErrorCode code: URLError.Code) -> String {
        return code.localizedDescription
    }
    
}

@available(iOS 13.0, *)
extension URLError.NetworkUnavailableReason : LocalizedError {
    
    public var localizedDescription: String {
        switch self {
        case .cellular:
            return "Network is unavailable because the interface is cellular and cellular network is disabled"
        case .constrained:
            return "Netowrk is unavailable because the user enabled 'Low Data Mode' in the Settings App"
        case .expensive:
            return "Netowrk is unavailable because the system marked interface as expensive"
        @unknown default:
            return "Unhandled error code"
        }
    }
}

@available(iOS 13.0, *)
extension URLError.BackgroundTaskCancelledReason : LocalizedError {
    
    public var localizedDescription: String {
        switch self {
            case .backgroundUpdatesDisabled:
                return "System canceled the background task because background tasks are disabled"
            case .insufficientSystemResources:
                return "System canceled the background task because it lacks sufficent resources to perform the task"
            case .userForceQuitApplication:
                return "System canceled the background task because the user force-quit the application"
            @unknown default:
                return "Unhandled error code"
        }
    }
}

extension URLError.Code : LocalizedError {
    
    public var localizedDescription: String {
        switch self {
        case .appTransportSecurityRequiresSecureConnection:
            return "App Transport Security disallowed a connection because there is no secure network connection."
        case .backgroundSessionInUseByAnotherProcess:
            return "An app or app extension attempted to connect to a background session that is already connected to a process."
        case .backgroundSessionRequiresSharedContainer:
            return "The shared container identifier of the URL session configuration is needed but has not been set."
        case .backgroundSessionWasDisconnected:
            return "The app is suspended or exits while a background data task is processing."
        case .badServerResponse:
            return "The URL Loading system received bad data from the server."
        case .badURL:
            return "A malformed URL prevented a URL request from being initiated."
        case .callIsActive:
            return "A connection was attempted while a phone call is active on a network that does not support simultaneous phone and data communication (EDGE or GPRS)."
        case .cancelled:
            return "An asynchronous load has been canceled."
        case .cannotCloseFile:
            return "A download task couldn’t close the downloaded file on disk."
        case .cannotConnectToHost:
            return "An attempt to connect to a host failed."
        case .cannotCreateFile:
            return "A download task couldn’t create the downloaded file on disk because of an I/O failure."
        case .cannotDecodeContentData:
            return "Content data received during a connection request had an unknown content encoding."
        case .cannotDecodeRawData:
            return "Content data received during a connection request could not be decoded for a known content encoding."
        case .cannotFindHost:
            return "The host name for a URL could not be resolved."
        case .cannotLoadFromNetwork:
            return "A request to load an item only from the cache could not be satisfied."
        case .cannotMoveFile:
            return "A download task was unable to move a downloaded file on disk."
        case .cannotOpenFile:
            return "A download task was unable to open the downloaded file on disk."
        case .cannotParseResponse:
            return "A task could not parse a response."
        case .cannotRemoveFile:
            return "A download task was unable to remove a downloaded file from disk."
        case .cannotWriteToFile:
            return "A download task was unable to write to the downloaded file on disk."
        case .clientCertificateRejected:
            return "A server certificate was rejected."
        case .clientCertificateRequired:
            return "A client certificate was required to authenticate an SSL connection during a request."
        case .dataLengthExceedsMaximum:
            return "The length of the resource data exceeds the maximum allowed."
        case .dataNotAllowed:
            return "The cellular network disallowed a connection."
        case .dnsLookupFailed:
            return "The host address could not be found via DNS lookup."
        case .downloadDecodingFailedMidStream:
            return "A download task failed to decode an encoded file during the download."
        case .downloadDecodingFailedToComplete:
            return "A download task failed to decode an encoded file after downloading."
        case .fileDoesNotExist:
            return "A file does not exist."
        case .fileIsDirectory:
            return "A request for an FTP file resulted in the server responding that the file is not a plain file, but a directory."
        case .httpTooManyRedirects:
            return "A redirect loop has been detected or the threshold for number of allowable redirects has been exceeded (currently 16)."
        case .internationalRoamingOff:
            return "The attempted connection required activating a data context while roaming, but international roaming is disabled."
        case .networkConnectionLost:
            return "A client or server connection was severed in the middle of an in-progress load."
        case .noPermissionsToReadFile:
            return "A resource couldn’t be read because of insufficient permissions."
        case .notConnectedToInternet:
            return "A network resource was requested, but an internet connection has not been established and cannot be established automatically."
        case .redirectToNonExistentLocation:
            return "A redirect was specified by way of server response code, but the server did not accompany this code with a redirect URL."
        case .requestBodyStreamExhausted:
            return "A body stream is needed but the client did not provide one."
        case .resourceUnavailable:
            return "A requested resource couldn’t be retrieved."
        case .secureConnectionFailed:
            return "An attempt to establish a secure connection failed for reasons that can’t be expressed more specifically."
        case .serverCertificateHasBadDate:
            return "A server certificate had a date which indicates it has expired, or is not yet valid."
        case .serverCertificateHasUnknownRoot:
            return "A server certificate was not signed by any root server."
        case .serverCertificateNotYetValid:
            return "A server certificate is not yet valid."
        case .serverCertificateUntrusted:
            return "A server certificate was signed by a root server that isn’t trusted."
        case .timedOut:
            return "An asynchronous operation timed out."
        case .unknown:
            return "The URL Loading System encountered an error that it can’t interpret."
        case .unsupportedURL:
            return "A properly formed URL couldn’t be handled by the framework."
        case .userAuthenticationRequired:
            return "Authentication is required to access a resource."
        case .userCancelledAuthentication:
            return "An asynchronous request for authentication has been canceled by the user."
        case .zeroByteResource:
            return "A server reported that a URL has a non-zero content length, but terminated the network connection gracefully without sending any data."
        default:
            return "Unhandled error code"
        }
        
    }
    
    
}
