class Message {
  Message(
      {required this.role, required this.content, required this.generating});

  String role;
  String content;
  bool generating;
}
