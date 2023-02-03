//
//  PatreonOAuth.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation
import Alamofire
import Semaphore

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// MARK: - Patreon OAuth Calls
extension PatreonAPI {
    
    // 1st OAuth Call
    public func doOAuth() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.patreon.com"
        urlComponents.path = "/oauth2/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "redirect_uri", value: redirectURI)
        ]
        guard let url = urlComponents.url else { return }
        #if os(iOS)
            UIApplication.shared.open(url)
        #elseif os(macOS)
            NSWorkspace.shared.open(url)
        #endif
    }
    
    // Get User Tokens
    public func getOAuthTokens(callbackCode: String) async -> PatronOAuth? {
        let params: [String: String] = ["code": callbackCode,
                                        "grant_type": "authorization_code",
                                        "client_id": clientID,
                                        "client_secret": clientSecret,
                                        "redirect_uri": redirectURI]
        return await fetchOAuthResponse(params)
    }
    
    // Refresh User Tokens
    public func refreshOAuthTokens(userRefreshToken: String) async -> PatronOAuth? {
        let params: [String: String] = ["grant_type": "refresh_token",
                                        "refresh_token": userRefreshToken,
                                        "client_id": clientID,
                                        "client_secret": clientSecret]
        return await fetchOAuthResponse(params)
    }
    
    // Fetch Tokens Fucntion
    fileprivate func fetchOAuthResponse(
        _ params: Dictionary<String, String>
    ) async -> PatronOAuth? {
        
        let semaphore = AsyncSemaphore(value: 0)
        var requestResponse: PatronOAuth?
        
        guard let url = URL(string: "https://www.patreon.com/api/oauth2/token") else { return nil }
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   headers: headers)
        .responseDecodable(of: PatronOAuth.self) {
            (response: DataResponse<PatronOAuth, AFError>) in
            switch response.result {
            case .success(let data):
                requestResponse = data
            case .failure(let error):
                debugPrint(error)
                requestResponse = nil
            }
            semaphore.signal()
        }
        
        await semaphore.wait()
        return requestResponse
    }
}
