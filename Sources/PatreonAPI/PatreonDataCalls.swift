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
            URLQueryItem(name: "include", value: "memberships.campaign,memberships.currently_entitled_tiers"),
            URLQueryItem(name: "fields[user]", value: fieldsUserQueryValue.replacingOccurrences(of: "\n", with: "")),
            URLQueryItem(name: "fields[member]", value: fieldsMemberQueryValue.replacingOccurrences(of: "\n", with: ""))
        ]
        let fetchedData = await fetchPatreonData(accessToken: userAccessToken,
                                                 apiPath: path, apiQueries: queries,
                                                 returnType: PatreonUserIdentity.self)
        if let identity = fetchedData {
            returnValue = identity
        } else {
            returnValue = nil
        }
        return returnValue
    }
    
    // Returns Campaigns owned by the User
    public func getUserOwnedCampaigns(userAccessToken: String) async -> PatronOwnedCampaigns? {
        let returnValue: PatronOwnedCampaigns?
        let path = "campaigns"
        let queries = [
            URLQueryItem(name: "fields[campaign]", value: fieldsCampaignQueryValue.replacingOccurrences(of: "\n", with: ""))
        ]
        let fetchedData = await fetchPatreonData(accessToken: userAccessToken,
                                                 apiPath: path, apiQueries: queries,
                                                 returnType: PatronOwnedCampaigns.self)
        if let ownedCampaigns = fetchedData {
            returnValue = ownedCampaigns
        } else {
            returnValue = nil
        }
        return returnValue
    }
    
    // Returns details about a Campaign identified by ID
    public func getDataForCampaign() async -> PatreonCampaignInfo? {
        let returnValue: PatreonCampaignInfo?
        let path = "campaigns/" + campaignID
        let queries = [
            URLQueryItem(name: "include", value: "creator,tiers,benefits,goals"),
            URLQueryItem(name: "fields[campaign]", value: fieldsCampaignQueryValue.replacingOccurrences(of: "\n", with: "")),
            URLQueryItem(name: "fields[tier]", value: fieldsTierQueryValue.replacingOccurrences(of: "\n", with: "")),
            URLQueryItem(name: "fields[benefit]", value: fieldsBenefitQueryValue.replacingOccurrences(of: "\n", with: "")),
            URLQueryItem(name: "fields[goal]", value: fieldsGoalQueryValue.replacingOccurrences(of: "\n", with: ""))
        ]
        let fetchedData = await fetchPatreonData(accessToken: creatorAccessToken,
                                                 apiPath: path, apiQueries: queries,
                                                 returnType: PatreonCampaignInfo.self)
        if let campaignData = fetchedData {
            returnValue = campaignData
        } else {
            returnValue = nil
        }
        return returnValue
    }
    
    // Returns a list Patrons of a Campaign identified by ID
    public func getMembersForCampaign() async -> PatreonCampaignMembers? {
        let returnValue: PatreonCampaignMembers?
        let path = "campaigns/" + campaignID + "/members"
        let queries = [
            URLQueryItem(name: "include", value: "user,address,campaign,currently_entitled_tiers"),
            URLQueryItem(name: "fields[member]", value: fieldsMemberQueryValue.replacingOccurrences(of: "\n", with: "")),
            URLQueryItem(name: "fields[tier]", value: fieldsTierQueryValue.replacingOccurrences(of: "\n", with: "")),
            URLQueryItem(name: "fields[address]", value: fieldsAddressQueryValue.replacingOccurrences(of: "\n", with: ""))
        ]
        let fetchedData = await fetchPatreonData(accessToken: creatorAccessToken,
                                                 apiPath: path, apiQueries: queries,
                                                 returnType: PatreonCampaignMembers.self)
        if let campaignMembers = fetchedData {
            returnValue = campaignMembers
        } else {
            returnValue = nil
        }
        return returnValue
    }
    
    // Returns Details about a Campaign Patron identifies by ID
    public func getMemberForCampaignByID(memberID: String) async -> PatronFetchedByID? {
        let returnValue: PatronFetchedByID?
        let path = "members/" + memberID
        let queries = [
            URLQueryItem(name: "include", value: "user,address,campaign,currently_entitled_tiers"),
            URLQueryItem(name: "fields[member]", value: fieldsMemberQueryValue.replacingOccurrences(of: "\n", with: "")),
            URLQueryItem(name: "fields[tier]", value: fieldsTierQueryValue.replacingOccurrences(of: "\n", with: "")),
            URLQueryItem(name: "fields[address]", value: fieldsAddressQueryValue.replacingOccurrences(of: "\n", with: ""))
        ]
        let fetchedData = await fetchPatreonData(accessToken: creatorAccessToken,
                                                 apiPath: path, apiQueries: queries,
                                                 returnType: PatronFetchedByID.self)
        if let fetchedPatron = fetchedData {
            returnValue = fetchedPatron
        } else {
            returnValue = nil
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
        debugPrint("PatreonAPI: Trying to fetch data from URL: \(url)")
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: T.self) {
            (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                data = value
                debugPrint("PatreonAPI: Data of type \(T.self) fetched.")
            case .failure(let error):
                data = nil
                debugPrint("PatreonAPI: Failed to fetch data of type \(T.self). Alamofire error log: \(error)")
            }
            semaphore.signal()
        }
        
        await semaphore.wait()
        return data
    }
}
