//
//  TeachAssistWidget.swift
//  TeachAssistWidget
//
//  Created by York Wei on 2020-12-20.
//  Copyright © 2020 York Wei. All rights reserved.
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

struct TeachAssistWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack (alignment:.leading){
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9441892505, green: 0, blue: 0.4814293981, alpha: 1)), Color(#colorLiteral(red: 0.3960784314, green: 0.03137254902, blue: 0.862745098, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: 50)
                .mask(
                    //HStack(alignment: .center) {
                     //   Spacer()
                        Text("New Marks\nAvailable").font(.title3).fontWeight(.heavy)
                     //   Spacer()
                    //}
                )
            //Spacer()
//            Divider()
            Text("Evaluation Added For ICS4U1-01").font(.footnote).fontWeight(.regular).opacity(0.9)
            Spacer()
            Text("Updated: 1:13PM").font(.footnote).fontWeight(.regular).opacity(0.5)
            Spacer()
//            HStack{
//                Spacer()
//                Image("Logo")
//                    .resizable()
//                    .frame(width: 25, height: 25)
//            }
            
        }.padding(15)
    }
}

@main
struct TeachAssistWidget: Widget {
    let kind: String = "TeachAssistWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TeachAssistWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TeachAssistWidget_Previews: PreviewProvider {
    static var previews: some View {
        TeachAssistWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
