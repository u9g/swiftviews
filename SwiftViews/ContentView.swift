//
//  ContentView.swift
//  SwiftViews
//
//  Created by Jason Lernerman on 9/29/25.
//

import SwiftUI
import SwiftData

struct SwitchScreen: View {
    @State private var boolean: Bool = false
    
    var body: some View {
        List {
            Section {
                Toggle("As Switch", isOn: $boolean)
                    .toggleStyle(.switch)
                Toggle("As Button", isOn: $boolean)
                    .toggleStyle(.button)
            }
        }
    }
}

struct TextScreen: View {
    @State private var text: String = "Edit this text at the top!"
    @State private var textAlignment: TextAlignment = .center

    var alignment: Alignment {
        switch textAlignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        List {
            Section {
                TextField(text: $text) {
                    Text("Preview Text")
                }   .focused($isTextFieldFocused)
                    .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isTextFieldFocused = false // Dismiss keyboard
                        }
                    }
                }
                Picker("Align", selection: $textAlignment) {
                    Text("Leading").tag(TextAlignment.leading)
                    Text("Center").tag(TextAlignment.center)
                    Text("Trailing").tag(TextAlignment.trailing)
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.automatic)
            }
            
            Text(".largeTitle: " + text).font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".title: " + text).font(.title)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".title2: " + text).font(.title2)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".title3: " + text).font(.title3)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".headline: " + text).font(.headline)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".subheadline: " + text).font(.subheadline)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".body: " + text).font(.body)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".footnote: " + text).font(.footnote)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".caption: " + text).font(.caption)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".caption2: " + text).font(.caption2)
                .frame(maxWidth: .infinity, alignment: alignment)
            Text(".body: " + text).font(.body)
                .frame(maxWidth: .infinity, alignment: alignment)
        }
    }
}

struct TopBar: View {
    var body: some View {
        ZStack {
            // Background
            Color.blue
                .ignoresSafeArea(edges: .top)
                .frame(height: 50)

            // Content inside bar
            HStack {
                Text("**s**wifty**v**iews")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    

    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                TopBar() // sits above content
                List {
                    Section {
                        NavigationLink {
                            TextScreen()
                            
                        } label: {
                            Text("Text Sizes")
                        }
                        NavigationLink {
                            SwitchScreen()
                        } label: {
                            Text("Switches")
                        }
                    }
                    Section {
                        Text("For feature requests: ihaveanidea@u9g.dev")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
