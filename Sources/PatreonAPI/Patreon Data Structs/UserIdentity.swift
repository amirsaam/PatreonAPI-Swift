//
//  UserIdentity.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation
import CodableAny

public struct PatreonUserIdentity: Codable {
    public let data: UserIdentityData
    public let included: [UserIdentityIncluded]?
    public let links: SelfLink
}

public struct UserIdentityData: Codable {
    public let attributes: Attributes
    public let id: String
    public let relationships: Relationships
    public let type: String
    
    public struct Attributes: Codable {
        public let about: String?
        public let can_see_nsfw: Bool?
        public let created: String
        public let email: String?
        public let first_name: String?
        public let full_name: String
        public let hide_pledges: Bool?
        public let image_url: String?
        public let is_email_verified: Bool?
        public let last_name: String?
        public let like_count: Int
        public let social_connections: SocialConnections
        public let thumb_url: String?
        public let url: String
        public let vanity: String?
        
        public struct SocialConnections: Codable {
            public let deviantart: SocialConnectionsData?
            public let discord: SocialConnectionsData?
            public let facebook: SocialConnectionsData?
            public let google: SocialConnectionsData?
            public let instagram: SocialConnectionsData?
            public let reddit: SocialConnectionsData?
            public let spotify: SocialConnectionsData?
            public let twitch: SocialConnectionsData?
            public let twitter: SocialConnectionsData?
            public let vimeo: SocialConnectionsData?
            public let youtube: SocialConnectionsData?
            
            public struct SocialConnectionsData: Codable {
                public let scopes: [String]?
                public let url: String
                public let user_id: String
            }
        }
    }

    public struct Relationships: Codable {
        public let memberships: IdTypeArray
    }
}
  
public struct UserIdentityIncluded: Codable {
    public let attributes: [String: CodableAny]
    public let id: String
    public let relationships: Relationships?
    public let type: String
    
    public struct Relationships: Codable {
        public let campaign: Campaign
        public let currently_entitled_tiers: IdTypeArray
        
        public struct Campaign: Codable {
            public let data: IdType
            public let links: RelatedLink
        }
    }
}
