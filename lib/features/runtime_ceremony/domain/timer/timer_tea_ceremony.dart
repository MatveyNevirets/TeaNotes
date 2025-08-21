class TimerTeaCeremony {
  Stream<int> tick() {
    return Stream.periodic(Duration(seconds: 1), (x) => x + 1);
  }
}
