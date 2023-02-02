//
//  BenefitsAttsRel.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct CampaignBenefit: Codable {
    public let attributes: CampaignBenefitAttributes
    public let relationships: CampaignBenefitRelationships
    
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
    
    public struct CampaignBenefitRelationships: Codable {
        public let campaign: PatreonCampaignInfo
        public let deliverables: [CampaignDeliverable]
        public let tiers: [CampaignTier]
    }
}
