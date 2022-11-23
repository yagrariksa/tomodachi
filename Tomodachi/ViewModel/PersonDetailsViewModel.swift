//
//  FriendDetailsViewModel.swift
//  Tomodachi
//
//  Created by Daffa Yagrariksa on 22/11/22.
//

import Foundation
import Alamofire

class PersonDetailsViewModel: ObservableObject {
    @Published var person: Person = Person(id: UUID().uuidString, firstName: "", lastName: "", title: "", picture: "")
    
    var id: String
    
    init(id: String) {
        self.id = id
        self.loadData()
    }
    
    init(person: Person) {
        self.id = person.id
        self.person = person
        if person.email == nil {
            self.loadData()
        }   
    }
    
    func loadData() {
        AF.request(DUMMY_URL + "/\(self.id)", headers: DUMMY_HEADERS).responseDecodable(of: Person.self) { response in
            if case .success(let result) = response.result {
                self.person = result
            }
        }
    }
    
    public static func instance(_ person: Person) -> PersonDetailsViewModel {
        return PersonDetailsViewModel(person: person)
    }
}
