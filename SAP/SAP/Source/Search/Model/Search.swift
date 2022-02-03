//
//  SearchResponse.swift
//  SAP
//
//  Created by hamza Ahmed on 31.01.22.
//

import Foundation
/**
 Model for Search data from API. I have added custom functions to customize the data based on the need.
 */
// MARK: - searchModel
struct Search: Codable {
    let photos: Photos
    let stat: String

    enum CodingKeys: String, CodingKey {
        case photos = "photos"
        case stat = "stat"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
        case photo = "photo"
    }
}

// MARK: - Photo
struct Photo: Codable, Hashable {
    let uuid = UUID()
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case ispublic = "ispublic"
        case isfriend = "isfriend"
        case isfamily = "isfamily"
    }
    
    func getImageUrl()->URL!{
        return URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
