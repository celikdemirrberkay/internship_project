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
        VStack {
            Text("Namaz Vakitleri")
            Text("\(entry.location)")
            Text("İmsak : \(entry.fajr)")
            Text("Sabah : \(entry.sunrise)")
            Text("Öğle : \(entry.dhuhr)")
            Text("İkindi : \(entry.asr)")
            Text("Akşam : \(entry.maghrib)")
            Text("Yatsı : \(entry.isha)")
        }
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


