//
//  CampaignData.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation
import CodableAny

// MARK: - Campaigns owned by a User
public struct PatronOwnedCampaigns: Codable {
    public let data: [CampaignData]
    public let meta: PaginationPlain
}

// MARK: - Specific Campaign Details
public struct PatreonCampaignInfo: Codable {
    public let data: CampaignData
    public let included: [CampaignIncludedAny]
    public let links: SelfLink
}

// MARK: - Campaign General Details
public struct CampaignData: Codable {
    public let attributes: CampaignDataAttributes
    public let id: String
    public let relationships: CampaignDataRelationships
    public let type: String
}

public struct CampaignDataAttributes: Codable {
    public let created_at: String
    public let creation_name: String?
    public let discord_server_id: String?
    public let google_analytics_id: String?
    public let has_rss: Bool
    public let has_sent_rss_notify: Bool
    public let image_small_url: String
    public let image_url: String
    public let is_charged_immediately: Bool?
    public let is_monthly: Bool
    public let is_nsfw: Bool
    public let main_video_embed: String?
    public let main_video_url: String?
    public let one_liner: String?
    public let patron_count: Int
    public let pay_per_name: String?
    public let pledge_url: String
    public let published_at: String?
    public let summary: String?
    public let thanks_embed: String?
    public let thanks_msg: String?
    public let thanks_video_url: String?
    public let url: String
    public let vanity: String?
}
    
public struct CampaignDataRelationships: Codable {
    public let benefits: IdTypeArray?
    public let creator: Creator
    public let goals: IdTypePlain?
    public let tiers: IdTypeArray?
    
    public struct Creator: Codable {
        public let data: IdType?
        public let links: RelatedLink
    }
}

// MARK: - Campaign Included Data

/// Used to retrive both `CampaignIncludedTier` and `CampaignIncludedBenefit` at the same time.
public struct CampaignIncludedAny: Codable {
    public let attributes: [String: CodableAny]
    public let id: String
    public let relationships: CampaignIncludedRelationship?
    public let type: String
}

/// For decoding `CampaignIncludedAny` based on `type == "tier"`
public struct CampaignIncludedTier: Codable {
    public let attributes: CampaignTierAttributes
    public let id: String
    public let type: String
}

/// For decoding `CampaignIncludedAny` based on `type == "benefit"`
public struct CampaignIncludedBenefit: Codable {
    public let attributes: CampaignBenefitAttributes
    public let id: String
    public let relationships: CampaignIncludedRelationship
    public let type: String
}

//
public struct CampaignIncludedRelationship: Codable {
    public let tiers: IdTypeArray
}
