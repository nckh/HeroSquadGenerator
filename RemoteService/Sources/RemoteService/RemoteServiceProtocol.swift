public protocol RemoteServiceProtocol: AnyObject {

  func send<T: Encodable>(_ squad: T, completionHandler: @escaping (Result<RemoteServiceResponse, Swift.Error>) -> Void)

}
