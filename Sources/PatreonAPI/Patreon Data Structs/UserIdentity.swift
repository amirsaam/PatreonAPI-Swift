//
//  UserIdentity.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct PatreonUserIdentity: Codable {
    public let data: IdentityData
    public let included: [IdentityIncluded]?
    public let links: SelfLink
}

public struct IdentityData: Codable {
    public let attributes: Attributes
    public let id: String
    public let relationships: Relationships?
    public let type: String
    
    public struct Attributes: Codable {
        public let email: String?
        public let full_name: String
    }
    
    public struct Relationships: Codable {
        public let campaign: Campaign
        
        public struct Campaign: Codable {
            public let data: IdType
            public let links: RelatedLink
        }
    }
}
  
public struct IdentityIncluded: Codable {
    public let attributes: IncludedAttributes
    public let id: String
    public let type: String
    
    public struct IncludedAttributes: Codable {
        public let is_monthly: Bool
        public let summary: String
    }
}
