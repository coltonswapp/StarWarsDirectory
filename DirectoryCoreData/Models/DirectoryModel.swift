//
//  DirectoryModel.swift
//  DirectoryCoreData
//
//  Created by Colton Swapp on 8/22/22.
//

import Foundation

struct Directory: Decodable {
    var individuals: [PersonJSON]
}

struct PersonJSON: Decodable {
    
    var id: Int
    var firstName: String
    var lastName: String
    var birthdate: String
    var profilePicture: String
    var forceSensitive: Bool
    var affiliation: String
    
    func getAffiliation() -> String {
        switch affiliation {
        case "RESISTANCE":
            return "Resistance"
        case "SITH":
            return "Sith"
        case "FIRST_ORDER":
            return "First Order"
        case "JEDI":
            return "Jedi"
        default:
            return "No affiliation"
        }
    }
    
}
