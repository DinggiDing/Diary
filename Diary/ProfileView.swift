//
//  ProfileView.swift
//  Diary
//
//  Created by 성재 on 2/27/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)
                .frame(width: 34, height: 30)
                .onTapGesture {
                    print("ProfilView")
                }
                
        }).padding(.top, 5)
        
    }
}

#Preview {
    ProfileView()
}
