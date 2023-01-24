//
//  CarCustomiserTests.swift
//  CarCustomiserTests
//
//  Created by Alexander Bater on 16/01/2023.
//

import XCTest
@testable import CarCustomiser

final class CarCustomiserTests: XCTestCase {

    func testNewCarGivesMeACarWithAllAttributesSet() {
//        arrange
        let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
//        assert
        XCTAssertEqual(car.make, "Mazda")
        XCTAssertEqual(car.model, "MX-5")
        XCTAssertEqual(car.topSpeed, 125)
        XCTAssertEqual(car.acceleration, 7.7)
        XCTAssertEqual(car.handling, 5)
    }
    
    func testDisplayStats(){
        let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        let display_real = car.displayStats()
        let display_hope = """
                            Make: Mazda
                            Model: MX-5
                            Top Speed: 125 mph
                            Acceleration (0-60): 7.7s
                            Handling: 5
                            """
        
        XCTAssertEqual(display_real, display_hope)
    }

}
