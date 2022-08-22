//
//  DirectoryHome.swift
//  DirectoryCoreData
//
//  Created by Colton Swapp on 8/21/22.
//

import SwiftUI

struct DirectoryHome: View {
    
    @ObservedObject var viewModel = DirectoryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        HStack {
                            PersonRemoteImage(urlString: person.profilePicture!)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 90)
                                .clipShape(Circle())
                                .padding(.vertical)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(person.firstName ?? "") \(person.lastName ?? "")")
                                    .bold()
                                    .font(.title3)
                                Divider()
                                    .frame(width: 150)
                                
                                Text("\(person.affiliation ?? "No affiliation")")
                                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchAllPeople()
            }
            .navigationTitle("Directory")
            
        }
    }
}


