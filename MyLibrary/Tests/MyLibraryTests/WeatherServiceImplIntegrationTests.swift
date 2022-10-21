//
//  File.swift
//
//
//  Created by Souvik Das on 10/14/22.
//

import XCTest
@testable import MyLibrary

class WeatherServiceImplIntegrationTests: XCTestCase {
    
    func testingTheRealDeal() async {
        
        let myLibrary = MyLibrary(weatherService: WeatherServiceImpl())
        
        //When
        let isLuckyNumber = await myLibrary.isLucky(0)
        
        //Then
        XCTAssertNotNil(isLuckyNumber)
        
    }
//    func testingMock() async {
//        
//        let myLibrary = MyLibrary(weatherService: WeatherServiceImpl(baseUrl: .mock))
//        
//        //When
//        let isLuckyNumber = await myLibrary.isLucky(0)
//        
//        //Then
//        XCTAssertNotNil(isLuckyNumber)
//        
//    }
    
    
    
}
