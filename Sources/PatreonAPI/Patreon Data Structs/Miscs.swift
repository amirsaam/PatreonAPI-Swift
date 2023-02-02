//
//  Miscs.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct IdType: Codable {
    public let id: String
    public let type: String
}

public struct IdTypePlain: Codable {
    public let data: InnerData
    
    public struct InnerData: Codable {
        public let id: String
        public let type: String
    }
}

public struct IdTypeArray: Codable {
    public let data: [InnerArray]
    
    public struct InnerArray: Codable {
        public let id: String
        public let type: String
    }
}

public struct IdTypeDataLink: Codable {
    public let data: IdType
    public let links: RelatedLink
}

public struct SelfLink: Codable {
    public let `self`: String
}

public struct RelatedLink: Codable {
    public let related: String
}

public struct PaginationPlain: Codable {
    public let pagination: Pagination

    public struct Pagination: Codable {
        public let total: Int
    }
}

public struct PaginationCursor: Codable {
    public let pagination: Pagination
    
    public struct Pagination: Codable {
        public let cursors: Cursors
        public let total: Int
        
        public struct Cursors: Codable {
            public let next: String?
        }
    }
}
