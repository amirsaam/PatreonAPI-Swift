//
//  PatreonAPI.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

// MARK: - Patreon Class
final class PatreonAPI {
    internal let clientID: String
    internal let clientSecret: String
    internal let creatorAccessToken: String
    internal let creatorRefreshToken: String
    internal let redirectURI: String
    internal let campaignID: String
    
    public init(clientID: String,
                clientSecret: String,
                creatorAccessToken: String,
                creatorRefreshToken: String,
                redirectURI: String,
                campaignID: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.creatorAccessToken = creatorAccessToken
        self.creatorRefreshToken = creatorRefreshToken
        self.redirectURI = redirectURI
        self.campaignID = campaignID
    }
}
