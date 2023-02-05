//
//  PatreonAPICalls.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation
import Alamofire
import Semaphore

// MARK: - Patreon API Calls
extension PatreonAPI {
    
    // Returns User's Patreon Account Information
    public func getUserIdentity(userAccessToken: String) async -> PatreonUserIdentity? {
        let returnValue: PatreonUserIdentity?
        let path = "identity"
        let queries = [
            URLQueryItem(name: "include", value: "memberships,campaign"),
            URLQueryItem(name: "fields[user]", value: fieldsUserQueryValue)
        ]
        let fetchedData = await fetchPatreonData(accessToken: userAccessToken,
                                                 apiPath: path, apiQueries: queries,
                                                 returnType: PatreonUserIdentity.self)
        if let identity = fetchedData {
            returnValue = identity
            debugPrint(identity)
        } else {
            returnValue = nil
            debugPrint("failed to fetch identity")
        }
        return returnValue
    }
    
    // Returns Campaigns owned by the User
    public func getUserOwnedCampaigns(userAccessToken: String) async -> PatronOwnedCampaigns? {
        let returnValue: PatronOwnedCampaigns?
        let path = "campaigns"
        let queries = [
            URLQueryItem(name: "fields[campaign]", value: fieldsCampaignQueryValue)
        ]
        let fetchedData = await fetchPatreonData(accessToken: userAccessToken,
                                                 apiPath: path, apiQueries: queries,
                                                 returnType: PatronOwnedCampaigns.self)
        if let ownedCampaigns = fetchedData {
            returnValue = ownedCampaigns
            debugPrint(ownedCampaigns)
        } else {
            returnValue = nil
            debugPrint("failed to fetch ownedCampaigns")
        }
        return returnValue
    }
    
    // Returns details about a Campaign identified by ID
    public func getDataForCampaign() async -> PatreonCampaignInfo? {
        let returnValue: PatreonCampaignInfo?
        let path = "campaigns/" + campaignID
        let queries = [
            URLQueryItem(name: "include", value: "benefits,creator,goals,tiers"),
            URLQueryItem(name: "fields[campaign]", value: fieldsCampaignQueryValue),
            URLQueryItem(name: "fields[tier]", value: fieldsTierQueryValue),
            URLQueryItem(name: "fields[benefit]", value: fieldsBenefitQueryValue)
        ]
        let fetchedData = await fetchPatreonData(accessToken: creatorAccessToken,
                                                 apiPath: path, apiQueries: queries,
                                                 returnType: PatreonCampaignInfo.self)
        if let campaignData = fetchedData {
            returnValue = campaignData
            debugPrint(campaignData)
        } else {
            returnValue = nil
            debugPrint("failed to fetch campaignData")
        }
        return returnValue
    }
    
    // Returns a list Patrons of a Campaign identified by ID
    public func getMembersForCampaign() async -> PatreonCampaignMembers? {
        let returnValue: PatreonCampaignMembers?
        let path = "campaigns/" + campaignID + "/members"
        let query = [
            URLQueryItem(name: "include", value: "address,campaign,currently_entitled_tiers,user"),
            URLQueryItem(name: "fields[member]", value: fieldsMemberQueryValue),
            URLQueryItem(name: "fields[tier]", value: fieldsTierQueryValue),
            URLQueryItem(name: "fields[address]", value: fieldsAddressQueryValue)
        ]
        let fetchedData = await fetchPatreonData(accessToken: creatorAccessToken,
                                                 apiPath: path, apiQueries: query,
                                                 returnType: PatreonCampaignMembers.self)
        if let campaignMembers = fetchedData {
            returnValue = campaignMembers
            debugPrint(campaignMembers)
        } else {
            returnValue = nil
            debugPrint("failed to fetch campaignMembers")
        }
        return returnValue
    }
    
    // Returns Details about a Campaign Patron identifies by ID
    public func getMemberForCampaignByID(memberID: String) async -> PatronFetchedByID? {
        let returnValue: PatronFetchedByID?
        let path = "members/" + memberID
        let query = [
            URLQueryItem(name: "include", value: "address,campaign,currently_entitled_tiers,user"),
            URLQueryItem(name: "fields[member]", value: fieldsMemberQueryValue),
            URLQueryItem(name: "fields[tier]", value: fieldsTierQueryValue),
            URLQueryItem(name: "fields[address]", value: fieldsAddressQueryValue)
        ]
        let fetchedData = await fetchPatreonData(accessToken: creatorAccessToken,
                                                 apiPath: path, apiQueries: query,
                                                 returnType: PatronFetchedByID.self)
        if let fetchedPatron = fetchedData {
            returnValue = fetchedPatron
            debugPrint(fetchedPatron)
        } else {
            returnValue = nil
            debugPrint("failed to fetch fetchedPatron")
        }
        return returnValue
    }
    
    // Fetch Patreon Data Fucntion
    fileprivate func fetchPatreonData<T: Codable>(
        accessToken: String,
        apiPath: String,
        apiQueries: [URLQueryItem],
        returnType: T.Type
    ) async -> T? {
        
        let semaphore = AsyncSemaphore(value: 0)
        var data: T?
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.patreon.com"
        urlComponents.path = "/api/oauth2/v2/" + apiPath
        urlComponents.queryItems = apiQueries
        
        guard let url = urlComponents.url else { return nil }
        debugPrint(url)
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: T.self) {
            (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                data = value
            case .failure(let error):
                data = nil
                debugPrint(error)
            }
            semaphore.signal()
        }
        
        await semaphore.wait()
        return data
    }
}
