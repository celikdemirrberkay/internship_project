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
        HStack {
            VStack() {
                PrayerTimesText()
                LocationHStack(entry: entry)
                FirstPrayerTimesHStack(entry: entry)
                Spacer()
                LastPrayerTimesHStack(entry: entry)
                Spacer()
            }
            Spacer()
        }
        .frame(width: .infinity,height: .infinity)
        .containerBackground(
            Color(hex: 0xFF26c687).gradient,
            for: .widget
        )
   }
}

/// First three prayer times (Fajr, Sunrise, Dhuhr)
struct FirstPrayerTimesHStack : View{
    var entry: Provider.Entry
    var body : some View {
        HStack{
            Text("İmsak: \(entry.fajr)")
                .fontWeight(.light)
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .minimumScaleFactor(0.6)
            Spacer()
            Text("Sabah: \(entry.sunrise)")
                .fontWeight(.light)
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .minimumScaleFactor(0.6)
            Spacer()
            Text("Öğle: \(entry.dhuhr)")
                .fontWeight(.light)
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .minimumScaleFactor(0.6)
        }
        
    }
}

/// Last three prayer times (Asr, Maghrib, Isha)
struct LastPrayerTimesHStack : View {
    var entry: Provider.Entry
    var body : some View {
        HStack{
            Text("İkindi: \(entry.asr)")
                .fontWeight(.light)
                .foregroundColor(.white)
                .minimumScaleFactor(0.6)
            Spacer()
            Text("Akşam: \(entry.maghrib)")
                .fontWeight(.light)
                .foregroundColor(.white)
                .minimumScaleFactor(0.6)
            Spacer()
            Text("Yatsı: \(entry.isha)")
                .fontWeight(.light)
                .foregroundColor(.white)
                .minimumScaleFactor(0.6)
        }
    }
}

/// Prayer Times "Namaz Vakitleri" Text
struct PrayerTimesText : View {
    var body: some View{
        Text("Namaz Vakitleri")
            .font(.title3)
            .foregroundColor(.white)
            .fontWeight(.bold)
    }
}

/// Location Text
struct LocationHStack : View {
    var entry: Provider.Entry
    var body: some View{
        HStack{
            Image(systemName: "mappin")
                .foregroundColor(.white)
            Text("\(entry.location)")
                .font(.title3)
                .foregroundColor(.white)
                .fontWeight(.light)
        }
        Spacer()
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
        .supportedFamilies([.systemMedium])
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


struct home_widget_Previews: PreviewProvider{
    static var previews: some View{
        home_widgetEntryView(entry: SimpleEntry(
            date: Date(), fajr: "15:00", sunrise: "15:00", dhuhr: "15:00", asr: "15:00", maghrib: "15:00", isha: "15:00", location: "İstanbul"
        )
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}


