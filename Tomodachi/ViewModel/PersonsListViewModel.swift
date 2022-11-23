//
//  FriendsListViewModel.swift
//  Tomodachi
//
//  Created by Daffa Yagrariksa on 22/11/22.
//

import Foundation
import Alamofire
import AlamofireImage


struct ListPersonDataStruct: Decodable {
    let page: Int
    let data: [Person]
}

class PersonsListViewModel: ObservableObject {
    
    private let parameters = [
        "limit": 50
    ]
    
    @Published var persons: [Person] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        AF.request(DUMMY_URL, parameters: parameters,headers: DUMMY_HEADERS).responseDecodable(of: ListPersonDataStruct.self) { response in
            guard let result = response.value else { return }
            self.persons = result.data
        }
    }
    
    func removeData(_ offsets: IndexSet) {
        self.persons.remove(atOffsets: offsets)
    }
}
