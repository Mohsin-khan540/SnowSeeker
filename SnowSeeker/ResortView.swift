//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Mohsin khan on 08/12/2025.
//

import SwiftUI

struct ResortView: View {
    let resort : Resort
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites
    
    @State private var selectedFacility : Facility?
    @State private var showFacility = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading , spacing: 0){
                ZStack(alignment: .bottomTrailing){
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    Text(resort.imageCredit)
                        .padding(10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                HStack{
                    if horizontalSizeClass == .compact &&  dynamicTypeSize > .large{
                        VStack(spacing: 10){ ResortDetailsView(resort: resort)}
                        VStack(spacing : 10){ SkiDetailsView(resort: resort)}
                    }else{
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                Group{
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    HStack{
                        ForEach(resort.facilityTypes){facility in
                            Button{
                                selectedFacility = facility
                                showFacility = true
                            }label :{
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                Button(favorites.contains(resort) ? "Remove from favorite" : "Add to favorite"){
                    if favorites.contains(resort){
                        favorites.remove(resort)
                    }else{
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("\(resort.name) , \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(selectedFacility?.name ?? "more information" , isPresented : $showFacility , presenting : selectedFacility){_ in
            }message : {facility in
                Text(facility.description)
            }
        }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
