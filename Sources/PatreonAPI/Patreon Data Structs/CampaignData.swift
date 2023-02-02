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
    public let meta: Meta
    
    public struct Meta: Codable {
        public let pagination: Pagination
        public struct Pagination: Codable {
            public let total: Int
        }
    }
}

// MARK: - Specific Campaign Details
public struct PatreonCampaignInfo: Codable {
    public let data: CampaignData
    public let included: [CampaignIncludedAny]
    public let links: SelfLink
}

// MARK: - Campaign General Details
public struct CampaignData: Codable {
    public let attributes: CampaignAttributes
    public let id: String
    public let relationships: CampaignRelationships
    public let type: String
    
    public struct CampaignAttributes: Codable {
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
    
    public struct CampaignRelationships: Codable {
        public let benefits: IdTypeArray?
        public let creator: Creator
        public let goals: IdTypeArray?
        public let tiers: IdTypeArray?
    }
    
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
    public let type: String
}

/// For decoding `CampaignIncludedAny` based on `type == "tier"`
public struct CampaignIncludedTier: Codable {
    public let attributes: CampaignTierAttributes
    public let id: String
    public let type: String
    
    public struct CampaignTierAttributes: Codable {
        public let amount_cents: Int
        public let created_at: String
        public let description: String?
        public let discord_role_ids: [String: String]?
        public let edited_at: String
        public let image_url: String?
        public let patron_count: Int
        public let post_count: Int?
        public let published: Bool
        public let published_at: String?
        public let remaining: Int?
        public let requires_shipping: Bool
        public let title: String
        public let unpublished_at: String?
        public let url: String
        public let user_limit: Int?
    }
}

/// For decoding `CampaignIncludedAny` based on `type == "benefit"`
public struct CampaignIncludedBenefit: Codable {
    public let attributes: CampaignBenefitAttributes
    public let id: String
    public let type: String
    
    public struct CampaignBenefitAttributes: Codable {
        public let app_external_id: String?
        public let app_meta: [String: String]?
        public let benefit_type: String?
        public let created_at: String
        public let deliverables_due_today_count: Int
        public let delivered_deliverables_count: Int
        public let description: String?
        public let is_deleted: Bool
        public let is_ended: Bool
        public let is_published: Bool
        public let next_deliverable_due_date: String?
        public let not_delivered_deliverables_count: Int
        public let rule_type: String?
        public let tiers_count: Int
        public let title: String
    }
}
