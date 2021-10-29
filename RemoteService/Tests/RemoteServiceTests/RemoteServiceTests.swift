import XCTest
@testable import RemoteService

final class RemoteServiceTests: XCTestCase {

  private var remoteService: RemoteService!
  private var urlSessionMock: URLSessionMock!

  override func setUp() {
    urlSessionMock = URLSessionMock()
    remoteService = RemoteService(urlSession: urlSessionMock)
  }

  func testRequest() throws {
    let expectation = XCTestExpectation()
    remoteService.send(Gigou(wesh: "magl")) { _ in expectation.fulfill() }

    wait(for: [expectation], timeout: 1)

    let request = try XCTUnwrap(urlSessionMock.dataTasks.first?.request)
    XCTAssertEqual(request.url?.absoluteString, "https://httpbin.org/anything")
    XCTAssertEqual(request.httpMethod, "POST")
  }

  func testDataEncoding() throws {
    let expectation = XCTestExpectation()
    remoteService.send(Gigou(wesh: "magl")) { _ in expectation.fulfill() }

    wait(for: [expectation], timeout: 1)

    let data = try XCTUnwrap(urlSessionMock.dataTasks.first?.request?.httpBody)
    let decoder = JSONDecoder()
    let gigou = try decoder.decode(Gigou.self, from: data)

    XCTAssertEqual(gigou.wesh, "magl")
  }

  func testDecodingResponse() throws {
    let data = Data(Self.response.utf8)
    urlSessionMock.results.append((data, nil, nil))

    let expectation = XCTestExpectation()
    var result: RemoteService.ResponseResult?

    remoteService.send(Gigou(wesh: "magl")) {
      result = $0
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1)

    if case let .failure(error) = result {
      XCTFail(error.localizedDescription)
      return
    }

    guard case let .success(decodedResponse) = result else { return }

    XCTAssertEqual(decodedResponse.data, "weshgro")
  }

  private static var response: String {
    """
    {
      "args": {},
      "data": "weshgro",
      "files": {},
      "form": {},
      "headers": {
        "Content-Length": "796",
        "Content-Type": "text/plain; charset=utf-8",
        "Host": "httpbin.org",
        "User-Agent": "Paw/3.3.1 (Macintosh; OS X/12.0.1) GCDHTTPRequest",
        "X-Amzn-Trace-Id": "Root=1-6180fcfb-1709ef7a36ebf2dd6c0469fa"
      },
      "json": {
        "active": true,
        "formed": 2016,
        "homeTown": "Metro City",
        "members": [
          {
            "age": 29,
            "name": "Molecule Man",
            "powers": [
              "Radiation resistance",
              "Turning tiny",
              "Radiation blast"
            ],
            "secretIdentity": "Dan Jukes"
          },
          {
            "age": 39,
            "name": "Madame Uppercut",
            "powers": [
              "Million tonne punch",
              "Damage resistance",
              "Superhuman reflexes"
            ],
            "secretIdentity": "Jane Wilson"
          },
          {
            "age": 1000000,
            "name": "Eternal Flame",
            "powers": [
              "Immortality",
              "Heat Immunity",
              "Inferno",
              "Teleportation",
              "Interdimensional travel"
            ],
            "secretIdentity": "Unknown"
          }
        ],
        "squadName": "Super hero squad"
      },
      "method": "POST",
      "origin": "180.57.209.73",
      "url": "https://httpbin.org/anything"
    }
    """
  }

}

private struct Gigou: Codable {
  let wesh: String
}
