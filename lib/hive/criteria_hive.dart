import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/creteria_model.dart';

class CriteriaHive {
  addCriteria(
    String letter,
    String text,
  ) {
    final criteria = Criteria()
      ..criteriaLetter = letter.toUpperCase()
      ..criteriaText = text;

    final box = Boxes.getCriterias();

    box.add(criteria);
    }

  editCriteria(int index, String criteriaLetter, String criteriaText) async {
    final box = Boxes.getCriterias();

    final criteria = Criteria()
      ..criteriaLetter = criteriaLetter.toUpperCase()
      ..criteriaText = criteriaText;

    await box.putAt(index, criteria);
  }

  deleteCriteria(int index) async {
    final box = Boxes.getCriterias();

    box.deleteAt(index);
  }
  deleteAll(){
     final box = Boxes.getCriterias();

    box.clear();

  }
}
