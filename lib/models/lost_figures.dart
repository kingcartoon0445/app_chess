import 'package:app_chess/models/figure.dart';

class LostFigures {
  final List<Figure> _figures = [];

  List<Figure> get figures => _figures;

  push(Figure figure) {
    _figures.add(figure);
  }
}
