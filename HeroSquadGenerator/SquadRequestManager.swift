import OSLog
import HeroSquad
import RemoteService

/// An object that sends a randomly generated Squad to a remote service, then saves it into storage together with the
/// server response.
final class SquadRequestManager {

  private let remoteService: RemoteServiceProtocol
  private let storage: Storage

  private let queue = DispatchQueue.global(qos: .userInitiated)

  init(remoteService: RemoteServiceProtocol, storage: Storage) {
    self.remoteService = remoteService
    self.storage = storage
  }

  func createNewSquad(_ completionHandler: (() -> Void)? = nil) {
    queue.async { [weak remoteService, weak storage] in
      guard let squad = Squad.random() else { return }

      remoteService?.send(squad) { [weak storage] result in
        switch result {
        case let .success(response):
          storage?.saveRequest(squad, responseDataString: response.data)
          completionHandler?()

        case let .failure(error):
          Logger.networking.error("Error sending squad: \(error.localizedDescription)")
        }
      }
    }
  }

}
