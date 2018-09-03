import Vapor

protocol WithOutgoing {
  associatedtype Outgoing

  func makeOutgoing(with req: Request) -> Outgoing
}

extension Array: WithOutgoing where Element: WithOutgoing {
  typealias Outgoing = [Element.Outgoing]

  func makeOutgoing(with req: Request) -> [Element.Outgoing] {
    return map { $0.makeOutgoing(with: req) }
  }
}

extension Future: WithOutgoing where T: WithOutgoing {
  typealias Outgoing = Future<T.Outgoing>

  func makeOutgoing(with req: Request) -> Future<T.Outgoing> {
    return map { $0.makeOutgoing(with: req) }
  }
}
