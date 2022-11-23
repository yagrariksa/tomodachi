//
//  FriendDetailsView.swift
//  Tomodachi
//
//  Created by Daffa Yagrariksa on 22/11/22.
//

import SwiftUI

struct PersonDetailsView: View {
    @StateObject var vm: PersonDetailsViewModel
    @ObservedObject var parentVM: PersonsListViewModel
    
    @State var person = Person.example
    @State var isEdit: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 16) {
                Spacer()
                AsyncImage(url: vm.person._picture) { image in
                    image
                        .resizable()
                        .cornerRadius(.infinity)
                } placeholder: {
                    if vm.person.id == "" {
                        Text("No Image")
                    }else{
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
                
                List {
                    Section(header: Text("General Info")) {
                        HStack {
                            Text("Title")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person.title)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person.title)
                            }
                        }
                        HStack {
                            Text("First Name")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person.firstName)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person.firstName)
                            }
                        }
                        HStack {
                            Text("Last Name")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person.lastName)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person.lastName)
                            }
                        }
                        HStack {
                            Text("Email")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person._email)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person.email ?? "")
                            }
                        }
                        HStack {
                            Text("Gender")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person._gender)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person.gender ?? "")
                            }
                        }
                        HStack {
                            Text("Born")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person._dateOfBirth)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person.dateOfBirth ?? "")
                            }
                        }
                    }
                    Section(header: Text("Location")) {
                        HStack {
                            Text("street")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person._location.street)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person._location.street )
                            }
                        }
                        HStack {
                            Text("city")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person._location.city)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person._location.city )
                            }
                        }
                        HStack {
                            Text("state")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person._location.state)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person._location.state )
                            }
                        }
                        HStack {
                            Text("country")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person._location.country)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person._location.country )
                            }
                        }
                        HStack {
                            Text("timezone")
                            Spacer()
                            if isEdit {
                                TextField("...", text: $person._location.timezone)
                                    .fixedSize()
                                    .frame(alignment: .trailing)
                            }else {
                                Text(vm.person._location.timezone )
                            }
                        }
                    }
                }
                Spacer()
                    .navigationTitle("Detail Friends")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .frame(width: geometry.size.width)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEdit.toggle()
                        if isEdit {
                            person = vm.person
                        }else{
                            if let idx = parentVM.persons.firstIndex(where: {$0 == person}) {
                                parentVM.persons.remove(at: idx)
                                parentVM.persons.insert(person, at: idx)
//                                parentVM.persons.inser
//                                parentVM.persons.first(where: {$0 == person}) = person
                            }else{
                                parentVM.persons.append(person)
                            }
                        }
                    }, label: {
                        if isEdit {
                            Text("Save")
                        }else{
                            Text("\(Image(systemName: "pencil"))")
                        }
                    })
                }
            }
        }
    }
}

extension PersonDetailsView {
    public static func instance(_ id: String,_ pvm: PersonsListViewModel) -> PersonDetailsView {
        return PersonDetailsView(vm: PersonDetailsViewModel.instance(id), parentVM: pvm)
    }
}


struct FriendDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(vm: PersonDetailsViewModel(id: "60d0fe4f5311236168a109d8"), parentVM: PersonsListViewModel())
    }
}
