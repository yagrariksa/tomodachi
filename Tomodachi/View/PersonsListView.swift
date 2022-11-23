//
//  FriendListView.swift
//  Tomodachi
//
//  Created by Daffa Yagrariksa on 22/11/22.
//

import SwiftUI

struct PersonsListView: View {
    @StateObject private var vm: PersonViewModel = PersonViewModel()
    
    @State var edit: Bool = false
    
    @State var addPeopleIsPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.persons.count == 0 {
                    ProgressView()
                }
                List {
                    ForEach(vm.persons, id: \.id) { person in
                        row(person)
                    }
                    .onDelete(perform: delete)
                }
                NavigationLink(destination: PersonDetailsView(
                    vm: vm, isEdit: edit
                ), isActive: $addPeopleIsPresented, label: {
                    
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
                        showDetails(true, Person.example)
                    }
                }
            }
           
        }
        
    }
    
    private func row(_ person: Person) -> some View {
        Button(action: {
            showDetails(false, person)
        }) {
            HStack {
                AsyncImage(url: person._picture) { image in
                    image
                        .resizable()
                        .cornerRadius(.infinity)
                }placeholder: {
                    if person.picture == "" {
                        Text("\(Image(systemName: "xmark.circle"))")
                    }else{
                        ProgressView()
                    }                                }
                .frame(width: 45, height: 45)
                Text("\(person._displayName)")
            }
        }
        .buttonStyle(.plain)
    }
    
    
    private func delete(at offsets: IndexSet) {
        vm.removeData(offsets)
    }
    
    private func showDetails(_ edit: Bool, _ person: Person) {
        addPeopleIsPresented.toggle()
        self.vm.person = person
        self.edit = edit
    }
    
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsListView()
    }
}
