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
    @State private var remainingTime = 30
    
    var exhaustPackageEnabled: Bool {
        return exhaustPackage ? false: remainingFunds >= 500 ? false: remainingTime <= 0 ? true: true
        
    }
    var tiresPackageEnabled: Bool {
        return tiresPackage ? false: remainingFunds >= 500 ? false: remainingTime <= 0 ? true: true

    }
    var gearPackageEnabled: Bool {
        return gearPackage ? false: remainingFunds >= 500 ? false:remainingTime <= 0 ? true:  true

    }
    var ecuAndFuelPackageEnabled: Bool {
        return ecuFuelPackage ? false: remainingFunds >= 1000 ? false:remainingTime <= 0 ? true:  true

    }

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
            Text("\(remainingTime)")
                .onReceive(timer) {_ in
                    if self.remainingTime > 0{
                        self.remainingTime -= 1
                    }
                }
            Form{
                VStack(alignment: .leading, spacing: 30){
                    Text("\(starterCars.cars[selectedCar].displayStats())")
                    Button("Next Car", action:{
                        selectedCar += 1
                        resetDisplay()
                    })
                }
                Section{
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding ).disabled(exhaustPackageEnabled)
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding).disabled(tiresPackageEnabled)
                    Toggle("Gear Package (Cost: 500)", isOn: gearPackageBinding).disabled(gearPackageEnabled)
                    Toggle("ECU and Fuel Package (Cost: 1000)", isOn: ecuFuelBinding).disabled(ecuAndFuelPackageEnabled)
                }
            }
            Text("Remaining Funds: \(remainingFunds)").foregroundColor(.red).baselineOffset(30)
        }
    }
    
    func resetDisplay(){
        exhaustPackage = false
        tiresPackage = false
        gearPackage = false
        ecuFuelPackage = false
        remainingFunds = 1000
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
