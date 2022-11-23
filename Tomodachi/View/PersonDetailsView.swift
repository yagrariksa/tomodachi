//
//  FriendDetailsView.swift
//  Tomodachi
//
//  Created by Daffa Yagrariksa on 22/11/22.
//

import SwiftUI

struct PersonDetailsView: View {
    @ObservedObject var vm: PersonViewModel
    
    var person: Person {
        vm.person
    }
    @State var isEdit: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 16) {
                Spacer()
                AsyncImage(url: person._picture) { image in
                    image
                        .resizable()
                        .cornerRadius(.infinity)
                } placeholder: {
                    if person.picture == "" {
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
                    
            }
            .frame(width: geometry.size.width)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: editHandler, label: {editToolbarText})
                }
            }
            .onAppear(perform: vm.loadPerson)
            .navigationTitle("Detail Friends")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var editToolbarText: Text {
        Text(isEdit ? "Save" : "\(Image(systemName: "pencil"))")
    }
    
    private func editHandler() {
        isEdit.toggle()
        if !isEdit {
            vm.replacePerson(person)
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
            customTextField("Title", person.title, $vm.person.title)
            customTextField("First Name", person.firstName, $vm.person.firstName)
            customTextField("Last Name", person.lastName, $vm.person.lastName)
            customTextField("Picture URL", person.picture , $vm.person.picture)
            customTextField("Email", person._email, $vm.person._email)
            customTextField("Gender", person._gender , $vm.person._gender)
            customTextField("Born", person._dateOfBirth, $vm.person._dateOfBirth)
        }
    }
    
    private var fieldSectionLocation: some View {
        Section(header: Text("Location")) {
            customTextField("street", person._location.street, $vm.person._location.street)
            customTextField("city", person._location.city, $vm.person._location.city )
            customTextField("state", person._location.state, $vm.person._location.state )
            customTextField("country", person._location.country, $vm.person._location.country )
            customTextField("timezone", person._location.timezone, $vm.person._location.timezone )
        }
    }
}

extension PersonDetailsView {
    public static func instance(_ pvm: PersonViewModel) -> PersonDetailsView {
        return PersonDetailsView(vm: pvm)
    }
}


struct FriendDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(vm: PersonViewModel())
    }
}
