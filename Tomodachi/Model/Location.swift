//
//  Location+CoreDataClass.swift
//  
//
//  Created by Daffa Yagrariksa on 23/11/22.
//
//

import Foundation

public class Location: Decodable, Hashable {
    public static func == (lhs: Location, rhs: Location) -> Bool {
        if lhs._id == rhs._id  {
            return true
        }else{
            return false
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(_id)
    }
    
    var _id: String {
        [city, country, state, street, timezone].joined()
    }

    public var city: String 
    public var country: String 
    public var state: String 
    public var street: String 
    public var timezone: String 
    
    init(city: String = "", country: String = "", state: String = "", street: String = "", timezone: String = "") {
        self.city = city
        self.country = country
        self.state = state
        self.street = street
        self.timezone = timezone
    }
}
