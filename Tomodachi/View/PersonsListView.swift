//
//  FriendListView.swift
//  Tomodachi
//
//  Created by Daffa Yagrariksa on 22/11/22.
//

import SwiftUI

struct PersonsListView: View {
    @StateObject private var vm: PersonsListViewModel = PersonsListViewModel()
    @Environment(\.editMode) var editMode
    
    @State var addPeopleIsPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.persons.count == 0 {
                    ProgressView()
                }
                List {
                    ForEach(vm.persons, id: \.id) { person in
                        NavigationLink(destination: PersonDetailsView.instance(person.id, vm)) {
                            HStack {
                                AsyncImage(url: person._picture) { image in
                                    image
                                        .resizable()
                                        .cornerRadius(.infinity)
                                }placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 45, height: 45)
                                Text("\(person._displayName)")
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    
                }
                NavigationLink(destination: PersonDetailsView(vm: PersonDetailsViewModel(person: Person.example), parentVM: vm, isEdit: true), isActive: $addPeopleIsPresented, label: {
                    
                })
                
            }
            .navigationTitle("Tomodachi")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("Add") {
                        addPeopleIsPresented.toggle()
                    }
                }
            }
           
        }
        
    }
    
    
    private func delete(at offsets: IndexSet) {
        vm.removeData(offsets)
    }
    
    private func showSheet() {
        addPeopleIsPresented.toggle()
    }
    
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsListView()
    }
}
