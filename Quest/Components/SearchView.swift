//
//  SearchView.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 28/03/24.
//

import SwiftUI
import Awesome
import MapKit

struct SearchView: View {
    
    @State var search: Search
    
    @State private var showAllSources = false
    @State private var showAllPlaces = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text(search.query)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            
            if let sources = search.sources, sources.count > 0 {
                ScrollView(.horizontal, showsIndicators: false) {
                    // Horizontal stack to lay out items horizontally
                    LazyHStack(spacing: 6) {
                        // Loop through the data array to create views for each item
                        ForEach(sources.prefix(5), id: \.url) { source in
                            // Example item view
                            SourceView(source: source)
                        }
                        
                        if (!sources.isEmpty && sources.count > 5) {
                            Button {
                                showAllSources.toggle()
                            } label: {
                                Image(systemName: "ellipsis")
                            }
                            .foregroundStyle(.primary)
                            .frame(width: 25, height: 25)
                            .background(Color.secondaryBackground)
                            .clipShape(Circle())
                        }

                    }
                    .padding(.horizontal, 10)
                    .transition(.opacity)
                }
                .padding(.bottom, 12)
                .sheet(isPresented: $showAllSources) {
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 18) {
                            HStack {
                                DismissIndicator()
                            }
                            .padding(.bottom, 6)
                            
                            ForEach(sources, id: \.url) { source in
                                DetailedSourceView(source: source)
                            }
                            .padding(.horizontal, 12)
                        }
                        .padding(.vertical, 12)
                    }
                    .presentationCornerRadius(27)
                }
            } else if (search.isLoading && search.summary == nil) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 6) {
                        ForEach(1...5, id: \.self) { index in
                            SourceView(source: Source.sample()!)
                                .redacted(reason: .placeholder)
                        }
                    }
                    .padding(.horizontal, 10)
                    .transition(.opacity)
                }
                .padding(.bottom, 12)
            }
            
            if search.knowledge == nil, let images = search.images, images.count > 0 {
                ScrollView(.horizontal, showsIndicators: false) {
                    // Horizontal stack to lay out items horizontally
                    LazyHStack(spacing: 6) {
                        // Loop through the data array to create views for each item
                        ForEach(images.prefix(10), id: \.url) { source in
                            // Example item view
                            ImageView(source: source)
                        }
                    }
                    .padding(.horizontal, 12)
                }
                .padding(.bottom, 12)
                .transition(.opacity)
            } else if (search.isLoading && search.summary == nil && search.knowledge == nil) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 6) {
                        ForEach(1...5, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.secondaryBackground)
                                .frame(width: 250, height: 200)
                                .redacted(reason: .placeholder)
                        }
                    }
                    .padding(.horizontal, 10)
                    .transition(.opacity)
                }
                .onAppear {
                    print("Images Skeleton Loaded")
                }
                .padding(.bottom, 12)
            }
            
            if let featured_source = search.featured_source {
                FeaturedSourceView(source: featured_source)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                    .transition(.opacity)
            }
            
            if let knowledge = search.knowledge {
                KnowledgePanel(knowledge: knowledge)
                    .padding(.bottom, 12)
                    .transition(.opacity)
            }
            
            if let location = search.location {
                SearchLocationView(location: location)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
            }
            
            if let places = search.places, places.count > 0 {
                Group {
                    Map() {
                        ForEach(places, id: \.url) { place in
                            Marker(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)) {
                                Text(place.name)
                            }
                        }
                    }
                        .frame(width: UIScreen.screenWidth - 24)
                        .frame(height: (UIScreen.screenWidth * 3/5) - 24)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .padding(.horizontal, 12)
                    
                    ForEach(places.prefix(5), id: \.url) { place in
                        PlaceView(place: place)
                            .padding(.horizontal, 12)
                            .transition(.opacity)
                    }
                    
                    if (!places.isEmpty && places.count > 5) {
                        Button {
                            showAllPlaces.toggle()
                        } label: {
                            Text("View All")
                        }
                        .padding(.horizontal, 12)
                        .sheet(isPresented: $showAllPlaces) {
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(spacing: 12) {
                                    HStack {
                                        DismissIndicator()
                                    }
                                    .padding(.bottom, 6)
                                    
                                    ForEach(places, id: \.url) { place in
                                        PlaceView(place: place)
                                    }
                                    .padding(.horizontal, 12)
                                }
                                .padding(.vertical, 12)
                            }
                            .presentationCornerRadius(27)
                        }
                    }
                }
                .padding(.bottom, 12)
            }
            
            if search.summary != nil && !(search.summary?.isEmpty ?? true) {
                HStack {
                    Image(systemName: "text.word.spacing")
                        .font(.callout)
                    
                    Text("Answer")
                        .font(.title3)
                }
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.bottom, 9)
                
                Summary(summary: search.summary!)
                    .padding(.horizontal, 12)
            } else if (search.isLoading) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .padding(.horizontal, 12)
                    .redacted(reason: .placeholder)
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SearchViewPreview: View {
    
    @State
    var search: Search = Search.samplePlaceSearch()
    
    var  body: some View {
        VStack {
            SearchView(search: search)
//            IconButton(icon: "arrow.right") {
//                insertNextData()
//            }
//            .dense()
        }
    }
    
    func insertNextData() {
        if search.sources == nil {
            search.insertSampleSources()
            return
        }
        
        if search.images == nil {
            search.insertSampleImages()
            return
        }
        
        if search.knowledge == nil {
            search.insertSampleKnowledgePanel()
            return
        }
        
        if search.summary == nil {
            search.insertSampleSummary()
            return
        }
        
        if search.followUps == nil {
            search.insertSampleFollowUps()
            return
        }
    }
    
}

#Preview {
    ScrollView {
        SearchViewPreview()
    }
}
