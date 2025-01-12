//
//  MementoMoriWidgetView.swift
//  MementoMoriWidgetView
//
//  Created by lars on 12/08/2020.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct MementoMoriWidgetViewEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        DaysRemainingWidgetView()
    }
}

@main
struct MementoMoriWidgetView: Widget {
    let kind: String = "MementoMoriWidgetView"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MementoMoriWidgetViewEntryView(entry: entry)
        }
        .configurationDisplayName("Memento mori details")
        .description("Keep track of life and death.")
        .supportedFamilies([.systemSmall])
    }
}

struct MementoMoriWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        DaysRemainingWidgetView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
