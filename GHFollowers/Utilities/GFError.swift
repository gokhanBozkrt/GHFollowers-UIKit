//
//  GFError.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 27.08.2023.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unaabletoFavourites = " There was an error happeded during favourites"
    case alreadyInFavourites = "Follower is in already favourites list."

}
