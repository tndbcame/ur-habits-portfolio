// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInitCollection on Isar {
  IsarCollection<Init> get inits => this.collection();
}

const InitSchema = CollectionSchema(
  name: r'Init',
  id: -6033933521881261679,
  properties: {
    r'initFlg': PropertySchema(
      id: 0,
      name: r'initFlg',
      type: IsarType.bool,
    )
  },
  estimateSize: _initEstimateSize,
  serialize: _initSerialize,
  deserialize: _initDeserialize,
  deserializeProp: _initDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _initGetId,
  getLinks: _initGetLinks,
  attach: _initAttach,
  version: '3.1.0+1',
);

int _initEstimateSize(
  Init object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _initSerialize(
  Init object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.initFlg);
}

Init _initDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Init();
  object.id = id;
  object.initFlg = reader.readBoolOrNull(offsets[0]);
  return object;
}

P _initDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _initGetId(Init object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _initGetLinks(Init object) {
  return [];
}

void _initAttach(IsarCollection<dynamic> col, Id id, Init object) {
  object.id = id;
}

extension InitQueryWhereSort on QueryBuilder<Init, Init, QWhere> {
  QueryBuilder<Init, Init, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InitQueryWhere on QueryBuilder<Init, Init, QWhereClause> {
  QueryBuilder<Init, Init, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Init, Init, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Init, Init, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Init, Init, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Init, Init, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InitQueryFilter on QueryBuilder<Init, Init, QFilterCondition> {
  QueryBuilder<Init, Init, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Init, Init, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Init, Init, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Init, Init, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Init, Init, QAfterFilterCondition> initFlgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'initFlg',
      ));
    });
  }

  QueryBuilder<Init, Init, QAfterFilterCondition> initFlgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'initFlg',
      ));
    });
  }

  QueryBuilder<Init, Init, QAfterFilterCondition> initFlgEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initFlg',
        value: value,
      ));
    });
  }
}

extension InitQueryObject on QueryBuilder<Init, Init, QFilterCondition> {}

extension InitQueryLinks on QueryBuilder<Init, Init, QFilterCondition> {}

extension InitQuerySortBy on QueryBuilder<Init, Init, QSortBy> {
  QueryBuilder<Init, Init, QAfterSortBy> sortByInitFlg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initFlg', Sort.asc);
    });
  }

  QueryBuilder<Init, Init, QAfterSortBy> sortByInitFlgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initFlg', Sort.desc);
    });
  }
}

extension InitQuerySortThenBy on QueryBuilder<Init, Init, QSortThenBy> {
  QueryBuilder<Init, Init, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Init, Init, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Init, Init, QAfterSortBy> thenByInitFlg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initFlg', Sort.asc);
    });
  }

  QueryBuilder<Init, Init, QAfterSortBy> thenByInitFlgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initFlg', Sort.desc);
    });
  }
}

extension InitQueryWhereDistinct on QueryBuilder<Init, Init, QDistinct> {
  QueryBuilder<Init, Init, QDistinct> distinctByInitFlg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'initFlg');
    });
  }
}

extension InitQueryProperty on QueryBuilder<Init, Init, QQueryProperty> {
  QueryBuilder<Init, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Init, bool?, QQueryOperations> initFlgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'initFlg');
    });
  }
}
