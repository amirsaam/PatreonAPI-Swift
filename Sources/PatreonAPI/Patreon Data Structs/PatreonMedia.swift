//
//  PatreonMedia.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

public struct PatreonMedia: Codable {
    public let attributes: MediaAttributes
    
    public struct MediaAttributes: Codable {
        public let created_at: String
        public let download_url: String
        public let file_name: String
        public let image_urls: [String: String]
        public let metadata: [String: String]?
        public let mimetype: String
        public let owner_id: String
        public let owner_relationship: String
        public let owner_type: String
        public let size_bytes: String
        public let state: String
        public let upload_expires_at: String
        public let upload_parameters: String
        public let upload_url: String
    }
}
