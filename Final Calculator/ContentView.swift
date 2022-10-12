//
//  ContentView.swift
//  Final Calculator
//
//  Created by Alex Anderson on 9/27/22.
//

import SwiftUI
struct ContentView: View {
    @State private var currentGradeTextField = ""
    @State private var finalWeightTextField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0.0
    var body: some View {
        VStack {
            CustomText(text: "Final Grade Calculator")
                .padding()
            CustomText(text: "You Need A")
            CustomText(text: String(format: "%.2f", requiredGrade))
            CustomTextField(placeholder: " Current Grade ", variable: $currentGradeTextField)
            CustomTextField(placeholder: "Weight of Final", variable: $finalWeightTextField)
                .padding()
            Picker("Desired Semester Grade", selection:$desiredGrade){
                Text("A").tag(90.0)
                Text("B").tag(80.0)
                Text("C").tag(70.0)
                Text("D").tag(60.0)
            }
                    .pickerStyle(SegmentedPickerStyle()).padding()
           Spacer()
        }
        .onChange(of: desiredGrade, perform: { newValue in

                    calculateGrade()
                })
            .background (requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
        
    }
    func calculateGrade () {
        // if there is a number there
        if let currentGrade = Double (currentGradeTextField) {
            // if there is a number there
            if let finalWeight = Double(finalWeightTextField) {
                //check that final weight is valid
                if finalWeight < 100 && finalWeight > 0 {
                    // turn weight into a percentage
                    let finalPercentage = finalWeight / 100.0
                    // do the math (and make sure the result is not less than zero)
                        requiredGrade = max(0.0, (desiredGrade - (currentGrade * (1.0 - finalPercentage))) / finalPercentage)
                        }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
        
    }
    struct CustomTextField: View {
        let placeholder : String
        let variable : Binding<String>
        var body: some View {
            TextField(placeholder, text:variable)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .frame(width: 200, height: 30, alignment: .center)
                .font(.body)
                .padding()
        }
    }
    struct CustomText: View {
        let text : String
        var body: some View {
            Text(text)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}
