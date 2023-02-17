//
//  Model.swift
//  NetworkApp
//
//  Created by Yury on 15.02.23.
//

import Foundation

// MARK: - User
struct User: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let name: Name
    let email: String
    let dob, registered: Dob
    let picture: Picture
}

// MARK: - Dob
struct Dob: Decodable {
    let date: String
    let age: Int
}

// MARK: - Name
struct Name: Decodable {
    let title, first, last: String
    var fullName: String {
        return "\(title) \(first) \(last)"
    }
}

// MARK: - Picture
struct Picture: Decodable {
    let large, medium, thumbnail: String
}
