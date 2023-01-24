//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Alexander Bater on 16/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet {
            if (selectedCar >=  starterCars.cars.count) {
                selectedCar = 0
            }
        }
    }
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var gearPackage = false
    @State private var ecuFuelPackage = false
    @State private var remainingFunds = 1000

    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: { self.exhaustPackage },
            set: { newValue in
                self.exhaustPackage = newValue
                if newValue == true{
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                }
                else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
            }
        )
        let tiresPackageBinding = Binding<Bool> (
            get: { self.tiresPackage },
            set: { newValues in
                self.tiresPackage = newValues
                if newValues == true{
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
                }
                else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500
                }
            }
        )
        
        let gearPackageBinding = Binding<Bool> (
            get: { self.gearPackage },
            set: { newValues in
                self.gearPackage = newValues
                if newValues == true{
                    starterCars.cars[selectedCar].acceleration += 5
                    remainingFunds -= 500
                }
                else {
                    starterCars.cars[selectedCar].acceleration -= 5
                    remainingFunds += 500
                }
            }
        )
        
        let ecuFuelBinding = Binding<Bool> (
            get: { self.ecuFuelPackage },
            set: { newValues in
                self.ecuFuelPackage = newValues
                if newValues == true{
                    starterCars.cars[selectedCar].acceleration -= 1.5
                    starterCars.cars[selectedCar].topSpeed += 3
                    remainingFunds -= 1000
                }
                else {
                    starterCars.cars[selectedCar].acceleration += 1.5
                    starterCars.cars[selectedCar].topSpeed -= 3
                    remainingFunds += 1000
                }
            }
        )
        VStack{
            Form{
                VStack(alignment: .leading, spacing: 30){
                    Text("\(starterCars.cars[selectedCar].displayStats())")
                    Button("Next Car", action:{
                        selectedCar += 1
                    })
                }
                Section{
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding )
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                    Toggle("Gear Package (Cost: 500)", isOn: gearPackageBinding)
                    Toggle("ECU and Fuel Package (Cost: 1000)", isOn: ecuFuelBinding)
                }
            }
            Text("Remaining Funds: \(remainingFunds)").foregroundColor(.red).baselineOffset(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
