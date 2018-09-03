import Vapor

protocol WithOutgoing {
  associatedtype Outgoing

  func makeOutgoing(with req: Request) -> Outgoing
}

extension Future where T: WithOutgoing {
  func makeOutgoing(with req: Request) -> Future<T.Outgoing> {
    return map { $0.makeOutgoing(with: req) }
  }
}
