//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Gokhan on 24.12.2023.
//

import Foundation

enum PersistenceType {
    case add, remove
}

enum PersistenceManager {
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    static private let defaults = UserDefaults.standard
    
    
    static func updateWith(favourite: Follower, actionType: PersistenceType,completed: @escaping (GFError?) -> Void) {
        retreiveFavourites { result in
            switch result {
            case .success(var favourites):
               
                switch actionType {
                case .add:
                    guard !favourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    favourites.append(favourite)
                    
                case .remove:
                    favourites.removeAll { $0.login == favourite.login }
                }
                
                completed(save(favourites: favourites))
                
            case .failure(let failure):
                completed(failure)
               
            }
        }
    }
    
    
    static func retreiveFavourites(completed: @escaping (Result<[Follower],GFError>) -> Void) {
        
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unaabletoFavourites))
        }
    }
    
    static func save(favourites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
           
            let encodedFavourites = try encoder.encode(favourites)
            
            defaults.setValue(encodedFavourites, forKey: Keys.favourites)
        
        } catch {
            return .unaabletoFavourites
        }
        return nil
    }
}
