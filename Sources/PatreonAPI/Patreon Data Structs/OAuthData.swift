//
//  OAuthData.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct PatronOAuth: Codable {
    public let access_token: String
    public let refresh_token: String
    public let expires_in: Int
    public let scope: String
    public let token_type: String
}
