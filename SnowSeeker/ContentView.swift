//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Mohsin khan on 06/12/2025.
//

import SwiftUI

struct ContentView: View {
    let resorts : [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @State private var favorites = Favorites()
    
    enum sortOrder {
        case defaultOrder , alphabetical , country
        
    }
    
    @State private var sortOption : sortOrder = .defaultOrder
    
    
//    var sortedResorts : [Resort]{
//        switch sortOption{
//        case .defaultOrder:
//            return resorts
//        case .alphabetical:
//            return resorts.sorted(by: { $0.name < $1.name})
//        case .country:
//            return resorts.sorted(by: { $0.country < $1.country})
//        }
//    }
//    
//
//    var filterResorts : [Resort]{
//        if searchText.isEmpty{
//            resorts
//        }else{
//            resorts.filter{
//                $0.name.localizedStandardContains(searchText)
//            }
//        }
//    }
    
    
    
//    here we combine above two computed properties into one
    
    var filteredAndSortedResorts: [Resort] {
        let filtered = searchText.isEmpty ? resorts : resorts.filter { $0.name.localizedStandardContains(searchText) }
        switch sortOption {
        case .defaultOrder: return filtered
        case .alphabetical: return filtered.sorted(by: { $0.name < $1.name })
        case .country: return filtered.sorted(by: { $0.country < $1.country })
        }
    }

    
    var body: some View {
        NavigationSplitView{
            List(filteredAndSortedResorts){resort in
                NavigationLink(value: resort){
                    HStack{
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40 , height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black , lineWidth: 1)
                            )
                        VStack(alignment: .leading){
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs)")
                                .foregroundStyle(.secondary)
                        }
                        if favorites.contains(resort){
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Menu("Sort"){
                        Button("default"){sortOption = .defaultOrder}
                        Button("Alphabatical"){sortOption = .alphabetical}
                        Button("Country"){sortOption = .country}
                    }
                }
            }
            .navigationDestination(for: Resort.self){ resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Looking for resorts")
        }detail: {
            Welcomeview()
        }
        .environment(favorites)
        
    }
}
#Preview{
    ContentView()
}
