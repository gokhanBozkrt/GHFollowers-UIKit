//
//  Follower.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 8.07.2023.
//

import Foundation

struct Follower: Codable,Hashable {
    var login: String
    var avatarUrl: String
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(login)
//    }
}
