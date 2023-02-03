# PatreonAPI-Swift
> The missing library for interacting with Patreon's API in Swift.

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

Since I needed to show the Patreon campaign in one of our projects and there was no Swift Package or base code for Patreon's API in Swift, I needed to write my own and I think there was need for it in the community, so I just made it a package in order to make fellow developers' life easier since the API is a total nightmare!

## Installation

Add this project on your `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/amirsaam/PatreonAPI-Swift.git", from: "0.9.9"),
    ]
)
```

## Usage example


Surely import the package
```swift
import PatreonAPI
```

Initialise the Class
```swift
let patreonAPI = PatreonAPI(clientID: "YOUR CLIENT ID",
                            clientSecret: "YOUR CLIENT SECRET",
                            creatorAccessToken: "YOUR CREATOR'S ACCESS TOKEN",
                            creatorRefreshToken: "YOUR CREATOR'S REFRESH TOKEN",
                            redirectURI: "YOUR CLIENT REDIRECT URL",
                            campaignID: "YOUR CAMPAIGN ID")
```

Use built-in Functions
```swift
// For Authentication: 
patreonAPI.doOAuth() // Uses Client ID and Redirect URI from Initialiser
var oauthData = await patreonAPI.getOAuthTokens(callbackCode: "CALLBACK CODE FROM doOAuth()") // Uses Client ID, Client Secret and Redirect URI from Initialiser
oauthData = await patreonAPI.refreshOAuthTokens(userRefreshToken: oauthData?.refresh_token ?? "") // Uses Client Secret and Redirect URI from Initialiser

// For Retrieving Data:
let userIdentity = await patreonAPI.getUserIdentity(userAccessToken: oauthData?.access_token ?? "")
let userCampaigns = await patreonAPI.getUserOwnedCampaigns(userAccessToken: oauthData?.access_token ?? "")
let creatorCampaign = await patreonAPI.getDataForCampaign() // Uses Creator Access Token and Campaign ID from Initialiser
let creatorCampaignMembersList = await patreonAPI.getMembersForCampaign() // Uses Creator Access Token and Campaign ID from Initialiser
let specificMemberFromCreatorCampaign = await patreonAPI.getMemberForCampaignByID(memberID: "MEMBER OF CAMPAIGN ID") // Uses Creator Access Token from Initialiser. `memberID` should be retrieved from `membersList`
```

Handling `doOAuth()`:
- First you need to handle the redirect, rather storing the returning data to your online database or redirect them to your app with url scheme that first needs to be redirected to your website because Patreon doesn't support App URL Scheme.
- If you choosed URL Scheme, after redirect to it the function will return a URL with some queries (read more in Patreon docs)
- You can parse the url manually or you can use such code as below for automatic parse:
```swift
extension URL {
    func params() -> [String : Any] {
        var dict = [String : Any]()
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if let queryItems = components.queryItems {
                for item in queryItems {
                    dict[item.name] = item.value!
                }
            }
            return dict
        } else {
            return [:]
        }
    }
}
```
that can be used like this for the future usages:
```swift
.onOpenURL { url in
  let callback = url.params()
  if callback.isEmpty {
      // handle callback being unsuccessful
  } else {
      let patreonCallbackCode = callback["code"] as! String
      let patreonCallbackState = callback["state"] as! String
  }
}
```
then you can pass `patreonCallbackCode` to the `getOAuthTokens` function.

## A Problem in Patreon's API

Unfortunately, when I was trying to retrieve all data about Creator's campaign, I have encountered a bizarre situation where returning data with same name with no any distinguishing ability could have various structures and I needed to just use them with native Swift experience with decoding structs.
So I made something called [CodableAny](https://github.com/amirsaam/CodableAny) (that is in this package's dependencies) for fixing my own issue.
Basically when we call `getDataForCampaign` function, we will return:
```swift
public struct PatreonCampaignInfo: Codable {
    public let data: CampaignData
    public let included: [CampaignIncludedAny]
    public let links: SelfLink
}
```
and `CampaignIncludedAny` is:
```swift
public struct CampaignIncludedAny: Codable {
    public let attributes: [String: CodableAny]
    public let id: String
    public let type: String
}
```
So we retrived any data that is in the `Included` part of the API call in one network call, but it is not decoded so an extra local step is required! In your ViewModel for Patreon you can use such thing to decode that `Included` part based on if it's a Tier data or a Benefit data:
```swift
@Published var campaignTiers: [CampaignIncludedTier] = []
@Published var campaignBenefits: [CampaignIncludedBenefit] = []
@Published var patreonCampaign: PatreonCampaignInfo? {
    didSet {
        if let campaign = patreonCampaign {
            campaignTiers = extractCampaignTiers(from: campaign.included)
            campaignBenefits = extractCampaignBenefits(from: campaign.included)
        } else {
            campaignTiers = []
            campaignBenefits = []
        }
    }
}

func extractCampaignTiers(from campaign: [CampaignIncludedAny]) -> [CampaignIncludedTier] {
    var decodedArray = [CampaignIncludedTier]()
    for campaignIncluded in campaign {
        if campaignIncluded.type == "tier" {
            let decoded = try? JSONDecoder().decode(CampaignIncludedTier.self, from: try JSONEncoder().encode(campaignIncluded))
            if let decoded = decoded {
                decodedArray.append(decoded)
            }
        }
    }
    return decodedArray
}

func extractCampaignBenefits(from campaign: [CampaignIncludedAny]) -> [CampaignIncludedBenefit] {
    var decodedArray = [CampaignIncludedBenefit]()
    for campaignIncluded in campaign {
        if campaignIncluded.type == "benefit" {
            let decoded = try? JSONDecoder().decode(CampaignIncludedBenefit.self, from: try JSONEncoder().encode(campaignIncluded))
            if let decoded = decoded {
                decodedArray.append(decoded)
            }
        }
    }
    return decodedArray
}
```
For more information about decoding structs please go to [this directory](https://github.com/amirsaam/PatreonAPI-Swift/tree/master/Sources/PatreonAPI/Patreon%20Data%20Structs)


## To Do

- [ ] Write Xcode Tests
- [ ] Make Pod
- [ ] Deply Github Action

## Dependencies 

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Semaphore](https://github.com/groue/Semaphore)
- [CodableAny](https://github.com/amirsaam/CodableAny)

## Meta

Amir Mohammadi – [@amirsaam](https://twitter.com/amirsaam) – amirsaam [at] me [dot] com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/amirsaam/PatreonAPI-Swift/](https://github.com/amirsaam/PatreonAPI-Swift)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
