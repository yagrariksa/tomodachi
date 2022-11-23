//
//  AddFriendView.swift
//  Tomodachi
//
//  Created by Daffa Yagrariksa on 22/11/22.
//

import SwiftUI

struct AddFriendView: View {
    @Environment(\.presentationMode) private var pm
    @ObservedObject var vm: PersonsListViewModel
    
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView(vm: PersonsListViewModel())
    }
}
