//
//  home_widgetLiveActivity.swift
//  home_widget
//
//  Created by Berkay  on 8.08.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct home_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct home_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: home_widgetAttributes.self) { context in
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

extension home_widgetAttributes {
    fileprivate static var preview: home_widgetAttributes {
        home_widgetAttributes(name: "World")
    }
}

extension home_widgetAttributes.ContentState {
    fileprivate static var smiley: home_widgetAttributes.ContentState {
        home_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: home_widgetAttributes.ContentState {
         home_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: home_widgetAttributes.preview) {
   home_widgetLiveActivity()
} contentStates: {
    home_widgetAttributes.ContentState.smiley
    home_widgetAttributes.ContentState.starEyes
}
