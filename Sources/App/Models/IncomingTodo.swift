import Vapor

extension Todo {
  struct Incoming: Content {
    var completed: Bool?
    var order: Int?
    var title: String?

    func makeTodo() -> Todo {
      return Todo(
        id: nil,
        title: title ?? "",
        completed: completed ?? false,
        order: order
      )
    }
  }

  func patched(with incoming: Incoming) -> Todo {
    var copy = self
    copy.patch(with: incoming)
    return copy
  }

  mutating func patch(with incoming: Incoming) {
    if let completed = incoming.completed {
      self.completed = completed
    }

    if let order = incoming.order {
      self.order = order
    }

    if let title = incoming.title {
      self.title = title
    }
  }
}
