//
//  TiersAttsRel.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct CampaignTier: Codable {
    public let attributes: CampaignTierAttributes
    public let relationships: CampaignTierRelationships
}

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
    
public struct CampaignTierRelationships: Codable {
    public let benefits: [CampaignBenefit]
    public let campaign: PatreonCampaignInfo
    public let tier_image: PatreonMedia
}
