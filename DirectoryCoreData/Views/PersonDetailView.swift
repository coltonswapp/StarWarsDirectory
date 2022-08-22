//
//  PersonDetailView.swift
//  DirectoryCoreData
//
//  Created by Colton Swapp on 8/22/22.
//

import SwiftUI

struct PersonDetailView: View {
    
    var person: Person
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            PersonRemoteImage(urlString: person.profilePicture!)
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .cornerRadius(20)
            
            Text("Affiliate: \(person.affiliation ?? "")")
                .font(.title3)
            
            Text("Birthdate \(person.birthdate ?? "")")
                .font(.title3)
            
            Spacer()
            
            if person.forceSensitive {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.blue)
                    
                    Text("Force Senstive")
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                }
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
            }
        }.navigationTitle("\(person.firstName ?? "") \(person.lastName ?? "")")
    }
}
