//
//  home_widget.swift
//  home_widget
//
//  Created by Berkay  on 8.08.2024.
//

import WidgetKit
import SwiftUI
    
private let widgetGroupId = "group.home_widget_flutter"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            fajr: "-",
            sunrise: "-",
            dhuhr: "-",
            asr: "-",
            maghrib: "-",
            isha: "-",
            location: "-"
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let data = UserDefaults.init(suiteName: widgetGroupId)
        let fileName = data?.string(forKey: "filename") ?? "-"
        let entry = SimpleEntry(
            date: Date(),
            fajr: data?.string(forKey: "Fajr") ?? "-",
            sunrise: data?.string(forKey: "Sunrise") ?? "-",
            dhuhr: data?.string(forKey: "Dhuhr") ?? "-",
            asr: data?.string(forKey: "Asr") ?? "-",
            maghrib: data?.string(forKey: "Maghrib") ?? "-",
            isha: data?.string(forKey: "Isha") ?? "-",
            location: data?.string(forKey: "Location") ?? "-"
        )
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        getSnapshot(in: context) { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let fajr : String
    let sunrise : String
    let dhuhr : String
    let asr : String
    let maghrib : String
    let isha : String
    let location : String

}

struct home_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Namaz Vakitleri")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("\(entry.location)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("İmsak:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(entry.fajr)")
                }
                HStack {
                    Text("Sabah:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(entry.sunrise)")
                }
                HStack {
                    Text("Öğle:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(entry.dhuhr)")
                }
                HStack {
                    Text("İkindi:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(entry.asr)")
                }
                HStack {
                    Text("Akşam:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(entry.maghrib)")
                }
                HStack {
                    Text("Yatsı:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(entry.isha)")
                }
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.9))
        .cornerRadius(12)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    Color(hex: 0xFF26c687),
                    lineWidth: 4
                )
    )
    }
}

struct home_widget: Widget {
    let kind: String = "home_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
           home_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Namaz Vakti")
        .description("Namaz Vakitleri")
    }
}

/// Extension for hex color
extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}


