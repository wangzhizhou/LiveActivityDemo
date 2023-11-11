//
//  WidgetsExtensionLiveActivity.swift
//  WidgetsExtension
//
//  Created by joker on 2023/11/9.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetsExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetsExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

#Preview("Notification", as: .content, using: WidgetsExtensionAttributes.preview) {
   WidgetsExtensionLiveActivity()
} contentStates: {
    WidgetsExtensionAttributes.ContentState.smiley
    WidgetsExtensionAttributes.ContentState.starEyes
}
