//
//  UserIdentity.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation
import CodableAny

// MARK: - Identity of a Signed In User
public struct PatreonUserIdentity: Codable {
    public let data: UserIdentityData
    public let included: [UserIdentityIncludedAny]
    public let links: SelfLink
}

// MARK: - Identity General Details
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
                public let url: String?
                public let user_id: String
            }
        }
    }

    public struct Relationships: Codable {
        public let memberships: IdTypeArray
    }
}

// MARK: - Identity Included Data

/// Used to retrive both `UserIdentityIncludedMembership` and `UserIdentityIncludedCampaign` at the same time.
public struct UserIdentityIncludedAny: Codable {
    public let attributes: [String: CodableAny]
    public let id: String
    public let relationships: UserIdentityIncludedRelationships?
    public let type: String
}

/// For decoding `UserIdentityIncludedAny` based on `type == "member"`
public struct UserIdentityIncludedMembership: Codable {
    public let attributes: MembershipDataAttributes
    public let id: String
    public let relationships: UserIdentityIncludedRelationships
    public let type: String
}

/// For decoding `UserIdentityIncludedAny` based on `type == "campaign"`
public struct UserIdentityIncludedCampaign: Codable {
    public let attributes: CampaignDataAttributes
    public let id: String
    public let type: String
}

//
public struct UserIdentityIncludedRelationships: Codable {
    public let campaign: Campaign
    public let currently_entitled_tiers: IdTypeArray
    
    public struct Campaign: Codable {
        public let data: IdType
        public let links: RelatedLink
    }
}
