// Needs to correspond with backend
// ignore_for_file: constant_identifier_names

enum OrderBy { DESC, ASC }

extension OrderByX on OrderBy {
  String get name {
    switch (this) {
      case OrderBy.DESC:
        return 'DESC';
      case OrderBy.ASC:
        return 'ASC';
    }
  }
}
