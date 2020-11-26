//
//  ContentView.swift
//  BetterRest
//
//  Created by Marcin Marynowski on 30/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)

                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep").font(.headline)

                    Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake").font(.headline)

                    Picker("Cup", selection: $coffeAmount) {
                        ForEach(0 ..< 20) {
                            Text(coffeAmount == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                }

                Section(header: Text("Recommended bed time")) {
                    Text("\(calculatedBedTime)")
                        .font(.title)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    var calculatedBedTime: String {
        let model = SleepCalculator()

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        var message: String
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))

            let sleepTime = wakeUp - prediction.actualSleep

            let formatter = DateFormatter()
            formatter.timeStyle = .short

            message = formatter.string(from: sleepTime)
        } catch {
            message = "Error calculating bedtime"
        }

        return message
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
