//
//  FollowerView.swift
//  GHFollowers
//
//  Created by Gokhan on 28.04.2024.
//

import SwiftUI

struct FollowerView: View {
    var follower: Follower
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image("avatar-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                   
            }
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    FollowerView(follower: Follower(login: "Tom Crusi", avatarUrl: ""))
}
