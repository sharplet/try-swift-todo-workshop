import Vapor

extension Todo {
  struct Outgoing: Content {
    var id: Int?
    var title: String?
    var completed: Bool?
    var order: Int?
    var url: URL?
  }

  func makeOutgoing(with req: Request) -> Outgoing {
    return Outgoing(
      id: id,
      title: title,
      completed: completed,
      order: order,
      url: id.map { id in
        req.baseURL.appendingPathComponent(String(describing: id))
      }
    )
  }
}
