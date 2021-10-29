import Foundation

public protocol URLSessionProtocol: AnyObject {

  func dataTask(
    with request: URLRequest,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
  ) -> URLSessionDataTask

}

extension URLSession: URLSessionProtocol {}
