import Foundation

extension Data {

  func jsonString() -> String {
    String(decoding: self, as: UTF8.self)
  }

  func jsonStringFormatted() -> String {
    do {
      let json = try JSONSerialization.jsonObject(with: self)
      let formattedData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
      let formattedString = String(data: formattedData, encoding: .utf8)
      return formattedString ?? jsonString()

    } catch {
      return jsonString()
    }
  }

}
