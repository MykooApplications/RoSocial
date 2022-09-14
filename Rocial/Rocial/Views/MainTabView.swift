//
//  MainTabVIew.swift
//  Rocial
//
//  Created by Roshan Mykoo on 9/14/22.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PostsList()
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }
            
            PostsList(viewModel: PostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        
    }
}

struct MainTabVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
