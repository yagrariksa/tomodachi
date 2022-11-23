//
//  Person+CoreDataClass.swift
//  
//
//  Created by Daffa Yagrariksa on 23/11/22.
//
//

import Foundation

public class Person: Decodable, Hashable {
    public static func == (lhs: Person, rhs: Person) -> Bool {
        if lhs.id == rhs.id {
            return true
        }else{
            return false
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    
    public var id: String
    public var firstName: String
    public var lastName: String
    public var title: String
    public var picture: String
    public var email: String?
    var _email: String {
        get {
            return email ?? ""
        }
        set {
            email = newValue.isEmpty ? nil : newValue
        }
    }
    public var gender: String?
    var _gender: String {
        get {
            return gender ?? ""
        }
        set {
            gender = newValue.isEmpty ? nil : newValue
        }
    }
    public var dateOfBirth: String?
    var _dateOfBirth: String {
        get {
            return dateOfBirth ?? ""
        }
        set {
            dateOfBirth = newValue.isEmpty ? nil : newValue
        }
    }
    public var phone: String?
    var _phone: String {
        get {
            return phone ?? ""
        }
        set {
            phone = newValue.isEmpty ? nil : newValue
        }
    }
    public var registerDate: String?
    var _registerDate: String {
        get {
            return registerDate ?? ""
        }
        set {
            registerDate = newValue.isEmpty ? nil : newValue
        }
    }
    public var updatedDate: String?
    var _updatedDate: String {
        get {
            return updatedDate ?? ""
        }
        set {
            updatedDate = newValue.isEmpty ? nil : newValue
        }
    }
    public var location: Location?
    var _location: Location {
        get {
            return location ?? Location()
        }
        set {
            location = newValue
        }
    }
    
    init(id: String, firstName: String, lastName: String, title: String, picture: String, email: String? = nil, gender: String? = nil, dateOfBirth: String? = nil, phone: String? = nil, registerDate: String? = nil, updatedDate: String? = nil, location: Location? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.title = title
        self.picture = picture
        self.email = email
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.registerDate = registerDate
        self.updatedDate = updatedDate
        self.location = location
    }
}

extension Person {
    var _picture: URL? {
        URL(string: self.picture)
    }
    
    var _simpleName: String {
        [firstName, lastName].joined(separator: " ")
    }
    
    var _displayName: String {
        [title, _simpleName].joined(separator: " ")
    }
    
    var _dataFull: Bool {
        if [_email, _gender, _dateOfBirth, _phone, _registerDate, _updatedDate].contains(where: {$0 == ""}) {
            return false
        }else{
            return true
        }
    }
}

extension Person {
    public static var example: Person = Person(id: UUID().uuidString, firstName: "", lastName: "", title: "", picture: "")
}
