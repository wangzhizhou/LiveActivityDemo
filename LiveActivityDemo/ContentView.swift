//
//  ContentView.swift
//  LiveActivityDemo
//
//  Created by joker on 2023/11/9.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Button("start") {
                startLiveActivity()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

import ActivityKit

extension ContentView {
    
    func startLiveActivity() {
        
        do {
            _ = try Activity.request(
                attributes: WidgetsExtensionAttributes.preview,
                content: .init(
                    state: WidgetsExtensionAttributes.ContentState.smiley,
                    staleDate: nil
                ),
                pushType: nil
            )
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

#Preview {
    ContentView()
}
