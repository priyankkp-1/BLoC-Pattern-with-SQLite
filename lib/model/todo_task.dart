class Todo {
  int id;
  String description;
  bool isDone = false;

  Todo({this.id, this.description, this.isDone = false});

  factory Todo.fromDatabaseJson(Map<String, dynamic> data) => Todo(
        id: data["id"],
        description: data["description"],
        isDone: data["isDone"] == 0 ? false : true,
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "description": this.description,
        "isDone": this.isDone == false ? 0 : 1,
      };
}
