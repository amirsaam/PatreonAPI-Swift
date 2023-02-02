//
//  GoalsAttsRel.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct CampaignGoal: Codable {
    public let attributes: CampaignGoalAttributes
    public let relationships: CampaignGoalRelationships
}

public struct CampaignGoalAttributes: Codable {
    public let amount_cents: Int
    public let completed_percentage: Int
    public let created_at: String
    public let description: String?
    public let reached_at: String?
    public let title: String
}
    
public struct CampaignGoalRelationships: Codable {
    public let campaign: PatreonCampaignInfo
}
