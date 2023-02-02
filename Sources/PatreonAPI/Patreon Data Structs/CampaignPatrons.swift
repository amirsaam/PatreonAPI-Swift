//
//  CampaignPatrons.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

// MARK: - Campaign's Patrons List
public struct PatreonCampaignMembers: Codable {
    public let data: [CampaignMembersData]
    public let included: [CampaignMembersIncluded]?
    public let meta: CampaignMembersMeta
}

public struct CampaignMembersData: Codable {
    public let attributes: Attributes
    public let id: String
    public let relationships: Relationships
    public let type: String
    
    public struct Attributes: Codable {
        public let full_name: String
        public let is_follower: Bool
        public let last_charge_date: String?
        public let last_charge_status: String?
        public let lifetime_support_cents: Int
        public let currently_entitled_amount_cents: Int
        public let patron_status: String?
    }
    
    public struct Relationships: Codable {
        public let address: IdTypePlain
        public let currently_entitled_tiers: IdTypeArray
    }
}
  
public struct CampaignMembersIncluded: Codable {
    public let attributes: IncludedAttributes
    public let id: String
    public let type: String
    
    public struct IncludedAttributes: Codable {
        public let address: AddressAttributes?
        public let tier: TierAttributes?
        
        public struct AddressAttributes: Codable {
            public let addressee: String?
            public let city: String?
            public let country: String?
            public let created_at: String?
            public let line_1: String?
            public let line_2: String?
            public let phone_number: String?
            public let postal_code: String?
            public let state: String?
        }
        
        public struct TierAttributes: Codable {
            public let amount_cents: Int?
            public let created_at: String?
            public let description: String?
            public let discord_role_ids: [String]?
            public let edited_at: String?
            public let patron_count: Int?
            public let published: Bool?
            public let published_at: String?
            public let requires_shipping: Bool?
            public let title: String?
            public let url: String?
        }
    }
}

public struct CampaignMembersMeta: Codable {
    public let pagination: Pagination
    
    public struct Pagination: Codable {
        public let cursors: Cursors
        public let total: Int
        
        public struct Cursors: Codable {
            public let next: String?
        }
    }
}

// MARK: - A Patron's Details
public struct PatronFetchedByID: Codable {
    public let data: ByPatronIDData
    public let included: [ByPatronIDIncluded]
    public let links: SelfLink
}

public struct ByPatronIDData: Codable {
    public let attributes: Attributes
    public let id: String
    public let relationships: Relationships
    public let type: String
    
    public struct Attributes: Codable {
        public let full_name: String
        public let is_follower: Bool
        public let last_charge_date: String
    }
    
    public struct Relationships: Codable {
        public let address: RelationshipData
        public let user: RelationshipData
        
        public struct RelationshipData: Codable {
            public let data: IdType
            public let links: RelatedLink
        }
    }
}
  
public struct ByPatronIDIncluded: Codable {
    public let attributes: IncludedAttributes
    public let id: String
    public let type: String
    
    public struct IncludedAttributes: Codable {
        public let addressee: String?
        public let city: String?
        public let line_1: String?
        public let line_2: String?
        public let postal_code: String?
    }
}
