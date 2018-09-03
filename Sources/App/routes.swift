import Vapor

struct DumbObject: Content {
  var name: String
  var birthdate: Date
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
  // Basic "Hello, world!" example
  router.get("hello") { _ in
    "Hello, world!"
  }

  router.get("json") { req -> DumbObject in
    DumbObject(name: "Best Name", birthdate: Date())
  }

  // Example of configuring a controller
  let todoController = TodoController()
  router.get("todos", use: todoController.index)
  router.post("todos", use: todoController.create)
  router.delete("todos", use: todoController.clear)
  router.delete("todos", Todo.parameter, use: todoController.delete)
}
