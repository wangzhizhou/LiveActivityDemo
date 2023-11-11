//
//  ContentView.swift
//  LiveActivityDemo
//
//  Created by joker on 2023/11/9.
//

import SwiftUI

import ActivityKit

struct ContentView: View {
    
    @State private var activity: Activity<WidgetsExtensionAttributes>?
    
    var body: some View {
        VStack {
            
            Button("start") {
                activity = startLiveActivity()
            }
            
            
            Button("update") {
                updateLiveActivity(activity: activity)
            }
            
            Button("end") {
                endLiveActitvity(activity: activity)
            }
        }
        .buttonStyle(.bordered)
        .padding()
    }
}

extension ContentView {
    
    func startLiveActivity() -> Activity<WidgetsExtensionAttributes>? {
        
        var activity: Activity<WidgetsExtensionAttributes>? = nil
        do {
            if #available(iOS 16.2, *) {
                activity = try Activity.request(
                    attributes: WidgetsExtensionAttributes.preview,
                    content: .init(
                        state: WidgetsExtensionAttributes.ContentState.smiley,
                        staleDate: nil
                    ),
                    pushType: .token
                )
            } else {
                // Fallback on earlier versions
                activity = try Activity.request(
                    attributes: WidgetsExtensionAttributes.preview,
                    contentState: WidgetsExtensionAttributes.ContentState.smiley,
                    pushType: .token
                )
            }
        } catch {
            print(error.localizedDescription)
        }
        
        if let activity = activity {
            Task {
                for await tokenData in activity.pushTokenUpdates {
                    let token = tokenData.reduce("") { $0 + String(format: "%02x", $1) }
                    print("live activity \(activity.id) token:\n \(token)")
                    // live activity token can be report to bussiness server
                }
            }
        }
        
        return activity
    }
    
    func updateLiveActivity(activity: Activity<WidgetsExtensionAttributes>?) {
        
        Task {
            if #available(iOS 16.2, *) {
                await activity?.update(
                    ActivityContent(
                        state: WidgetsExtensionAttributes.ContentState.init(emoji: "🚀🚀🚀"),
                        staleDate: .none
                    ),
                    alertConfiguration: .init(
                        title: "Live Activity",
                        body: "update event",
                        sound: .default
                    )
                )
            } else {
                // Fallback on earlier versions
                await activity?.update(
                    using: WidgetsExtensionAttributes.ContentState.init(emoji: "🚀🚀🚀"),
                    alertConfiguration:.init(
                        title: "Live Activity",
                        body: "update event",
                        sound: .default
                    )
                )
            }
        }
    }
    
    func endLiveActitvity(activity: Activity<WidgetsExtensionAttributes>?) {
        
        Task {
            if #available(iOS 16.2, *) {
                await activity?.end(
                    ActivityContent(
                        state: WidgetsExtensionAttributes.ContentState.init(emoji: "❌❌❌"),
                        staleDate: .none
                    ),
                    dismissalPolicy: .after(.init(timeIntervalSinceNow: 60))
//                    dismissalPolicy: .immediate)
                )
            } else {
                // Fallback on earlier versions
                await activity?.end(
                    using:WidgetsExtensionAttributes.ContentState.init(emoji: "❌❌❌"),
                    dismissalPolicy: .immediate
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
