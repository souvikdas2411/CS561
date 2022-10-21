import Foundation
import CryptoKit

public class MyLibrary {
    
    private let alphabet: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    private let numbers: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    private var hashDict:[String:String]
    
    private let weatherService: WeatherService
    
    public init(weatherService: WeatherService? = nil) {
        self.weatherService = weatherService ?? WeatherServiceImpl()
        self.hashDict = [:]
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
    
    private func encryptUsingSha1(from input: String) -> String {
        let inputData = Data(input.utf8)
        let output = Insecure.SHA1.hash(data: inputData)
        return output.description
    }
    
    public func generateHash() async -> Bool{
//        if UserDefaults.standard.object(forKey: "hashDict") == nil {
//            for a in alphabet {
//                hashDict[encryptUsingSha1(from: a)] = a
//                hashDict[encryptUsingSha1(from: a.uppercased())] = a.uppercased()
//            }
//            UserDefaults.standard.set(hashDict, forKey: "hashDict")
//        }
        
        // Not  using
        /// -------------> if UserDefaults.standard.object(forKey: "hashDict") == nil <-------------
        // because if the cached file gets damaged somehow the user should be able to generate a new hashDict
        
        for a in alphabet {
                hashDict[encryptUsingSha1(from: a)] = a
                hashDict[encryptUsingSha1(from: a.uppercased())] = a.uppercased()
        }
        for n in numbers {
                hashDict[encryptUsingSha1(from: n)] = n
        }
        UserDefaults.standard.set(hashDict, forKey: "hashDict")
        
        if UserDefaults.standard.object(forKey: "hashDict") != nil {
            return true
        }
        else {
            return false
        }
    }
    
    public func crackStation(digest: String) -> String? {
        if UserDefaults.standard.object(forKey: "hashDict") != nil {
            let hashDict = UserDefaults.standard.object(forKey: "hashDict") as? [String:String]
            return hashDict?["SHA1 digest: \(digest)"]
        }
        return nil
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
