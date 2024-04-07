//
//  ThreadHistory.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 07/04/24.
//

import SwiftUI

struct ThreadHistory: View {
    
    @EnvironmentObject var thread_manager: ThreadManager
    
    var body: some View {
        NavigationView {
            Group {
                if thread_manager.threads.isEmpty {
                    VStack {
                        Spacer()
                        Text("Nothing to see here yet")
                        Spacer()
                    }
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(thread_manager.threads.reversed(), id: \.id) { thread in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(thread.searches.first!.query)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .lineLimit(2)
                                        
                                        HStack(spacing: 9) {
                                            HStack(spacing: 3) {
                                                Image(systemName: "square.stack.3d.up")
                                                Text("\(thread.searches.count)")
                                            }
                                            
                                            HStack(spacing: 3) {
                                                Image(systemName: "clock")
                                                Text("\(thread.created_at.timeAgo())")
                                            }
                                        }
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal, 12)
                                
                                Divider()
                                    .padding(.horizontal, 15)
                            }
                        }
                        .frame(width: UIScreen.screenWidth)
                    }
                }
            }
            .navigationTitle("Library")
        }
    }
}

#Preview {
    ThreadHistory()
}
