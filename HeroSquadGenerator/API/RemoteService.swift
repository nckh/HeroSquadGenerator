import Foundation
import Dispatch

final class RemoteService {

  private let urlSession: URLSessionProtocol
  private let queue = DispatchQueue.global(qos: .userInitiated)

  init(urlSession: URLSessionProtocol = URLSession.shared) {
    self.urlSession = urlSession
  }

  public enum Error: Swift.Error {
    case unknown
  }

}

extension RemoteService: RemoteServiceProtocol {

  func send<T: Encodable>(
    _ value: T,
    completionHandler: @escaping (Result<RemoteServiceResponse, Swift.Error>
    ) -> Void) {
    queue.async { [weak urlSession] in
      let encoder = JSONEncoder()
      var request = Self.makeRequest()

      do {
        let data = try encoder.encode(value)
        request.httpBody = data
      } catch {
        completionHandler(.failure(error))
      }

      let task = urlSession?.dataTask(with: request) { data, _, error in
        guard error == nil else {
          completionHandler(.failure(error!))
          return
        }

        guard let data = data else {
          completionHandler(.failure(Self.Error.unknown))
          return
        }

        do {
          let decoder = JSONDecoder()
          let response = try decoder.decode(RemoteServiceResponse.self, from: data)
          completionHandler(.success(response))

        } catch {
          completionHandler(.failure(error))
        }
      }

      task?.resume()
    }
  }

  private static let url = URL(string: "https://httpbin.org/anything")!

  private static func makeRequest() -> URLRequest {
    var request = URLRequest(url: Self.url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = [
      "Content-Type": "application/json"
    ]

    return request
  }

}
