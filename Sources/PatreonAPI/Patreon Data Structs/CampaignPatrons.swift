//
//  CampaignPatrons.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation
import CodableAny

// MARK: - Campaign's Patrons List
public struct PatreonCampaignMembers: Codable {
    public let data: [CampaignMembersData]
    public let included: [CampaignMembersIncluded]?
    public let meta: PaginationCursor
}

// MARK: - A Patron's Details
public struct PatronFetchedByID: Codable {
    public let data: CampaignMembersData
    public let included: [CampaignMembersIncluded]
    public let links: SelfLink
}

// MARK: - Campaign Members General Details
public struct CampaignMembersData: Codable {
    public let attributes: Attributes
    public let id: String
    public let relationships: Relationships
    public let type: String
    
    public struct Attributes: Codable {
        public let campaign_lifetime_support_cents: Int
        public let currently_entitled_amount_cents: Int
        public let email: String?
        public let full_name: String
        public let is_follower: Bool
        public let last_charge_date: String?
        public let last_charge_status: String?
        public let lifetime_support_cents: Int
        public let next_charge_date: String?
        public let note: String?
        public let patron_status: String?
        public let pledge_cadence: Int
        public let pledge_relationship_start: String?
        public let will_pay_amount_cents: Int
    }
    
    public struct Relationships: Codable {
        public let address: RelationshipsAddress
        public let campaign: IdTypeDataLink
        public let currently_entitled_tiers: IdTypeArray
        public let user: IdTypeDataLink

        public struct RelationshipsAddress: Codable {
            public let data: PatreonUserAddressAttributes
        }
    }
}

// MARK: - Members' Included Data
public struct CampaignMembersIncluded: Codable {
    public let attributes: [String: CodableAny]
    public let id: String
    public let type: String
}
