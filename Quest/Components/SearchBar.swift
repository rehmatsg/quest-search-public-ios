//
//  SearchBar.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 28/03/24.
//

import SwiftUI
import Awesome


struct QuestTextFieldStyle: TextFieldStyle {
    
    private var cornerRadius: CGFloat = 30
    
    private var backgroundColor: Color = Color.secondaryBackground
    
    var error: Binding<String?>? = nil
    
    var helper: String? = nil
    
    var lineWidth: CGFloat = 1
    
    init(error: Binding<String?>? = nil, helper: String? = nil) {
        self.error = error
        self.helper = helper
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            configuration
                .padding(.vertical, 18 - (lineWidth/2))
                .padding(.horizontal, 18 - (lineWidth/2))
                .overlay(
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .stroke(Color.border, lineWidth: lineWidth)
                )
                .padding(.all, lineWidth/2)
                .background(
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                        .foregroundStyle(backgroundColor.opacity(1))
                )
            
            if hasError || helper != nil {
                HStack(alignment: .center, spacing: 3) {
                    if hasError {
                        Image(systemName: "exclamationmark.circle")
                    }
                    Text(helper ?? error!.wrappedValue!)
                }
                    .font(.footnote)
                    .foregroundStyle(hasError ? .red : .black)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 6)
                    .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
            }
        }
    }
    
    var hasError: Bool {
        return (error != nil && error!.wrappedValue != nil)
    }
    
}

extension QuestTextFieldStyle {
    func cornerRadius(_ radius: CGFloat) -> Self {
        var style = self
        style.cornerRadius = radius
        return style
    }
    func backgroundColor(_ color: Color) -> Self {
        var style = self
        style.backgroundColor = color
        return style
    }
}

struct SearchBar: View {
    
    @Binding
    var value: String
    
    var label: String = "Search"
    
    @FocusState
    var isSearchBarFocused: Bool
    
    var onSubmit: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 3) {
            HStack {
                TextField(label, text: $value.animation())
                    .textFieldStyle(QuestTextFieldStyle())
                    .focused($isSearchBarFocused)
                    .keyboardType(.webSearch)
                    .onSubmit {
                        onSubmit()
                    }
                
                if !value.isEmpty {
                    IconButton(icon: "paperplane") {
                        onSubmit()
                    }
                        .dense()
                        .transition(.blurReplace)
                }
            }
            .padding(.bottom, isSearchBarFocused ? 12 : 0)
            
//            if (!isSearchBarFocused) {
//                HStack(alignment: .center) {
//                    Button {
//                        
//                    } label: {
//                        HStack(spacing: 3) {
//                            Awesome.Solid.bolt.image
//                                .foregroundColor(.systemYellow)
//                            Text("Instant")
//                                .fontDesign(.rounded)
//                        }
//                    }
//                    .font(.callout)
//                    .foregroundStyle(.secondary)
//                    
//                    Spacer()
//                    
//                    Menu {
//                        Button {
//                            
//                        } label: {
//                            Text("Web")
//                        }
//
//                    } label: {
//                        HStack(spacing: 3) {
//                            Image(systemName: "line.3.horizontal.decrease.circle")
//                            Text("Focus")
//                                .fontDesign(.rounded)
//                        }
//                    }
//                    .font(.callout)
//                    .foregroundStyle(.secondary)
//                }
//                .padding(.horizontal, 12)
//            }
        }
        .padding(.horizontal, 12)
    }
    
}

struct SearchBarPreview: View {
    
    @State var value: String = ""
    @FocusState private var isSearchBarFocused: Bool
    
    var body: some View {
        SearchBar(value: $value)
    }
    
}


#Preview {
    SearchBarPreview()
}
