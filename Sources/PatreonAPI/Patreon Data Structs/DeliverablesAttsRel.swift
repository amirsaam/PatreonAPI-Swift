//
//  DeliverablesAttsRel.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct CampaignDeliverable: Codable {
    public let attributes: CampaignDeliverableAttributes
    public let relationships: CampaignDeliverableRelationships
}

public struct CampaignDeliverableAttributes: Codable {
    public let completed_at: String
    public let delivery_status: String
    public let due_at: String
}
    
public struct CampaignDeliverableRelationships: Codable {
    public let benefit: CampaignBenefit
    public let campaign: PatreonCampaignInfo
    public let member: String
    public let user: String
}
