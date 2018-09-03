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
}
