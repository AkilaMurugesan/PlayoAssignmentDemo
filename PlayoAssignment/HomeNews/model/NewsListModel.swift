//
//  NewsListModel.swift
//  PlayoAssignment
//
//  Created by Akila Arun on 7/15/22.
//

import Foundation

public struct NewsListModel: Codable {
    public let status: String?
    public let totalResults: Int?
    public let articles: [Article]?
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}

// MARK: - Article
public struct Article: Codable {
    public let source: Source?
    public let author, title, articleDescription: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
public struct Source: Codable {
     let id: ID?
     let name: Name?
}

enum ID: String, Codable {
    case techcrunch = "techcrunch"
}

enum Name: String, Codable {
    case techCrunch = "TechCrunch"
}
