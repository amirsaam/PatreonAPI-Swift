//
//  UserAddress.swift
//  
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct PatreonUserAddress: Codable {
    public let attributes: PatreonUserAddressAttributes
    public let relationships: PatreonUserAddressRelationships
}

public struct PatreonUserAddressAttributes: Codable {
    public let addressee: String?
    public let city: String
    public let country: String
    public let created_at: String
    public let line_1: String?
    public let line_2: String?
    public let phone_number: String?
    public let postal_code: String?
    public let state: String?
}

public struct PatreonUserAddressRelationships: Codable {
    public let campaigns: [PatreonCampaignInfo]
    public let user: PatreonUserIdentity
}
