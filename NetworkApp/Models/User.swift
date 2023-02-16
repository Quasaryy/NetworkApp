//
//  Model.swift
//  NetworkApp
//
//  Created by Yury on 15.02.23.
//

import Foundation

// MARK: - Welcome
struct User: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let gender: String
    let name: Name
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

// MARK: - Dob
struct Dob: Decodable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Decodable {
    let name: String
}

// MARK: - Coordinates
struct Coordinates: Decodable {
    let latitude, longitude: String
}

// MARK: - Street
struct Street: Decodable {
    let number: Int
    let name: String
}

// MARK: - Login
struct Login: Decodable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct Name: Decodable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Decodable {
    let large, medium, thumbnail: String
}
