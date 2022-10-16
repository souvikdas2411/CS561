import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

//-------------
//Added
enum BaseUrl {
    case mock
    case real
}
//-------------

class WeatherServiceImpl: WeatherService {
    
    //-------------
    //Added
    private let baseUrl: BaseUrl
    private let url: String
    
    public init(baseUrl: BaseUrl? = nil) {
        self.baseUrl = baseUrl ?? .real
        if self.baseUrl == .real {
            url = "https://api.openweathermap.org/data/2.5/weather?q=corvallis&units=imperial&appid=d280dbb26a76e8d890331a2c3977a78f"
        }
        else {
            url = "localhost:3000/data/2.5/weather?q=corvallis&units=imperial&appid=<YOUR API KEY>"
        }
    }
    //-------------
    
    func getTemperature() async throws -> Int {
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

public struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
