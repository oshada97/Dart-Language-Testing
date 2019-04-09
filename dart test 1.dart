//oshe ravanz experiecnced with google dart code
import 'dart:math' show Random;

main() async {
  print('Compute p using the Monte Carlo method.');
  await for (var estimate in computePi().take(500)) {
    print('p ? $estimate');
  }
}

/// Generates a stream of increasingly accurate estimates of p.
Stream<double> computePi({int batch = 100000}) async* {
  var total = 0;
  var count = 0;
  while (true) {
    var points = generateRandom().take(batch);
    var inside = points.where((p) => p.isInsideUnitCircle);
    total += batch;
    count += inside.length;
    var ratio = count / total;
    // Area of a circle is A = p�r�, therefore p = A/r�.
    // So, when given random points with x ? <0,1>,
    // y ? <0,1>, the ratio of those inside a unit circle
    // should approach p / 4. Therefore, the value of p
    // should be:
    yield ratio * 4;
  }
}

Iterable<Point> generateRandom([int seed]) sync* {
  final random = Random(seed);
  while (true) {
    yield Point(random.nextDouble(), random.nextDouble());
  }
}

class Point {
  final double x, y;
  const Point(this.x, this.y);
  bool get isInsideUnitCircle => x * x + y * y <= 1;
}