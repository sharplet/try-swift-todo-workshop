import Vapor

private let trailingSlash = CharacterSet(charactersIn: "/")

extension Request {
  var baseURL: URL {
    let host = http.headers["Host"].first!.trimmingCharacters(in: trailingSlash)
    let scheme = http.remotePeer.scheme ?? "http"
    return URL(string: "\(scheme)://\(host)")!.appendingPathComponent("todos")
  }
}
