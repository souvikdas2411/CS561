import Foundation
import CryptoKit

public class MyLibrary {
        
    private let weatherService: WeatherService
    
    public init(weatherService: WeatherService? = nil) {
        self.weatherService = weatherService ?? WeatherServiceImpl()
    }

    public func isLucky(_ number: Int) async -> Bool? {
        if number == 3 || number == 5 || number == 8 {
            return true
        }
        do {
            let temperature = try await weatherService.getTemperature()
            return temperature.contains("8")
        } catch {
            return nil
        }
    }
}

private extension Int {
    /// Sample usage:
    ///   `558.contains(558, "8")` would return `true` because 588 contains 8.
    ///   `557.contains(557, "8")` would return `false` because 577 does not contain 8.
    func contains(_ character: Character) -> Bool {
        return String(self).contains(character)
    }
}
