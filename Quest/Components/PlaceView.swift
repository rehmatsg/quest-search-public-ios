//
//  Place.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 24/03/24.
//

import SwiftUI
import MapKit
import UniformTypeIdentifiers

struct PlaceView: View {
    
    var place: Place
    
    @Environment(\.openURL) var openURL
    
    @State
    var showDetailedSheet: Bool = false
    
    @State
    var showCallSheet: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Group {
                if place.imageURL != nil {
                    AsyncImage(url: URL(string: place.imageURL!)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 15.0)
                            .foregroundColor(.secondary)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 15.0)
                        .foregroundColor(.secondary)
                }
            }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(place.name)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)

                Text(place.displayAddress)
                    .font(.callout)
                    .lineSpacing(-10)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.callout)
                        .foregroundColor(.yellow)
                    
                    Text("\(String(format: "%g", place.rating)) (\(place.reviewCount))")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                
                if place.isClosed {
                    Text("Closed")
                        .font(.callout)
                        .lineSpacing(-10)
                        .foregroundStyle(.red)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            showDetailedSheet.toggle()
        }
        .sheet(isPresented: $showDetailedSheet) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        DismissIndicator()
                            .padding(.bottom, 12)
                        Spacer()
                    }
                    
//                    if place.imageURL != nil {
//                        AsyncImage(url: URL(string: place.imageURL!)) { image in
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                        } placeholder: {
//                            RoundedRectangle(cornerRadius: 15.0)
//                                .foregroundColor(.secondary)
//                                .frame(height: (UIScreen.screenWidth * 2/3) - 24)
//                        }
//                        .frame(width: UIScreen.screenWidth - 24)
//                        .frame(maxHeight: (UIScreen.screenWidth * 2/3) - 24)
//                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
//                    }
                    
                    Map(
                        initialPosition: MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude),
                                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                            )
                        )
                    ) {
                        Marker(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)) {
                            Text(place.name)
                        }
                    }
                        .frame(width: UIScreen.screenWidth - 24)
                        .frame(height: (UIScreen.screenWidth * 2/3) - 24)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .onTapGesture(perform: openMap)
                    
                    HStack(spacing: 0) {
                        Text(place.name)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                            .padding(.trailing, 6)
                        
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .font(.callout)
                            .foregroundColor(.yellow)
                            .padding(.trailing, 2)
                        
                        Text("\(String(format: "%g", place.rating)) (\(place.reviewCount))")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 6)
                    
                    if place.isClosed {
                        Text("Closed")
                            .font(.callout)
                            .lineSpacing(-10)
                            .foregroundStyle(.red)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 6) {
                            ForEach(place.categories!, id: \.self) { category in
                                Text(category)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .foregroundStyle(.secondary)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.secondaryBackground)
                                    }
                            }
                        }
                    }
                    .padding(.top, 6)
                    .padding(.bottom, 6)
                    
                    Text(place.displayAddress)
                        .lineSpacing(-10)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 6) {
                        IconButton(icon: "phone.fill") {
                            if let url = URL(string: "tel:\(place.phone)") {
                                openURL(url)
                            }
                        }
                            .dense()
                            .backgroundStyle(.accentColor)
                            .foregroundStyle(.accentColor.accessibleFontColor)
                            .contextMenu {
                                Button {
                                    UIPasteboard.general.setValue(place.phone, forPasteboardType: UTType.plainText.identifier)
                                } label: {
                                    Label("Copy Phone", systemImage: "clipboard")
                                }

                                Button {
                                    if let url = URL(string: "tel:\(place.phone)") {
                                        openURL(url)
                                    }
                                } label: {
                                    Label("Call \(place.displayPhoneNumber)", systemImage: "phone")
                                }
                            }
                            .confirmationDialog(place.name, isPresented: $showCallSheet, titleVisibility: .visible) {
                                Button("Call \(place.displayPhoneNumber)") {
                                    if let url = URL(string: "tel:\(place.phone)") {
                                        openURL(url)
                                    }
                                }
                            }
                        
                        IconButton(icon: "safari.fill") {
                            if let url = URL(string: place.url) {
                                openURL(url)
                            }
                        }
                        .dense()
                        .backgroundStyle(.accentColor)
                        .foregroundStyle(.accentColor.accessibleFontColor)
                        
                        IconButton(icon: "car.fill", action: openMap)
                            .dense()
                            .backgroundStyle(.accentColor)
                            .foregroundStyle(.accentColor.accessibleFontColor)
                    }
                    .padding(.top, 6)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
            }
            .presentationCornerRadius(27)
        }
    }
    
    func openMap() {
        guard let url = URL(string: "maps://?saddr=&daddr=\(place.latitude),\(place.longitude)") else {
            return
        }
        openURL(url)
    }
}

#Preview {
    PlaceView(place: Place.sample()!)
        .padding(.horizontal, 20)
}
