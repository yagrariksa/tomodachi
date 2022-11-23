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
                    if vm.person.picture == "" {
                        Text("No Image")
                    }else{
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
                
                List {
                    fieldSectionGeneral
                    fieldSectionLocation
                }
                Spacer()
                    .navigationTitle("Detail Friends")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .frame(width: geometry.size.width)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: editHandler, label: {
                        Text(editToolbarText)
                    })
                }
            }
        }
    }
    
    private var editToolbarText: String {
        isEdit ? "Save" : "\(Image(systemName: "pencil"))"
    }
    
    private func editHandler() {
        isEdit.toggle()
        if isEdit {
            person = vm.person
        }else{
            parentVM.replacePerson(person)
        }
    }
    
    private func customTextField(_ label: String,_ textDisplayed: String, _ editing: Binding<String>) -> some View {
        HStack {
            Text(label)
            Spacer()
            if isEdit {
                TextField("...", text: editing)
                    .fixedSize()
                    .frame(alignment: .trailing)
            }else {
                Text(textDisplayed )
            }
        }
    }
    
    private var fieldSectionGeneral: some View {
        Section(header: Text("General Info")) {
            customTextField("Title",vm.person.title,$person.title)
            customTextField("First Name",vm.person.firstName,$person.firstName)
            customTextField("Last Name",vm.person.lastName,$person.lastName)
            customTextField("Picture URL",vm.person.picture ,$person.picture)
            customTextField("Email",vm.person._email,$person._email)
            customTextField("Gender",vm.person._gender ,$person._gender)
            customTextField("Born",vm.person._dateOfBirth,$person._dateOfBirth)
        }
    }
    
    private var fieldSectionLocation: some View {
        Section(header: Text("Location")) {
            customTextField("street", vm.person._location.street, $person._location.street)
            customTextField("city", vm.person._location.city, $person._location.city )
            customTextField("state", vm.person._location.state, $person._location.state )
            customTextField("country", vm.person._location.country, $person._location.country )
            customTextField("timezone", vm.person._location.timezone, $person._location.timezone )
        }
    }
}

extension PersonDetailsView {
    public static func instance(_ person: Person,_ pvm: PersonsListViewModel) -> PersonDetailsView {
        return PersonDetailsView(vm: PersonDetailsViewModel.instance(person), parentVM: pvm)
    }
}


struct FriendDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(vm: PersonDetailsViewModel(id: "60d0fe4f5311236168a109d8"), parentVM: PersonsListViewModel())
    }
}
