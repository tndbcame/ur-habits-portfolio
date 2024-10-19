// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHabitRecordCollection on Isar {
  IsarCollection<HabitRecord> get habitRecords => this.collection();
}

const HabitRecordSchema = CollectionSchema(
  name: r'HabitRecord',
  id: -8253752743009167416,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'durVal': PropertySchema(
      id: 1,
      name: r'durVal',
      type: IsarType.long,
    ),
    r'strVal': PropertySchema(
      id: 2,
      name: r'strVal',
      type: IsarType.string,
    )
  },
  estimateSize: _habitRecordEstimateSize,
  serialize: _habitRecordSerialize,
  deserialize: _habitRecordDeserialize,
  deserializeProp: _habitRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _habitRecordGetId,
  getLinks: _habitRecordGetLinks,
  attach: _habitRecordAttach,
  version: '3.1.0+1',
);

int _habitRecordEstimateSize(
  HabitRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.strVal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _habitRecordSerialize(
  HabitRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.durVal);
  writer.writeString(offsets[2], object.strVal);
}

HabitRecord _habitRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HabitRecord();
  object.date = reader.readDateTimeOrNull(offsets[0]);
  object.durVal = reader.readLongOrNull(offsets[1]);
  object.id = id;
  object.strVal = reader.readStringOrNull(offsets[2]);
  return object;
}

P _habitRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _habitRecordGetId(HabitRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _habitRecordGetLinks(HabitRecord object) {
  return [];
}

void _habitRecordAttach(
    IsarCollection<dynamic> col, Id id, HabitRecord object) {
  object.id = id;
}

extension HabitRecordQueryWhereSort
    on QueryBuilder<HabitRecord, HabitRecord, QWhere> {
  QueryBuilder<HabitRecord, HabitRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HabitRecordQueryWhere
    on QueryBuilder<HabitRecord, HabitRecord, QWhereClause> {
  QueryBuilder<HabitRecord, HabitRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<HabitRecord, HabitRecord, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterWhereClause> idBetween(
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

extension HabitRecordQueryFilter
    on QueryBuilder<HabitRecord, HabitRecord, QFilterCondition> {
  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> durValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'durVal',
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition>
      durValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'durVal',
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> durValEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition>
      durValGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> durValLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> durValBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> strValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'strVal',
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition>
      strValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'strVal',
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> strValEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition>
      strValGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'strVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> strValLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'strVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> strValBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'strVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition>
      strValStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'strVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> strValEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'strVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> strValContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'strVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition> strValMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'strVal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition>
      strValIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strVal',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterFilterCondition>
      strValIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'strVal',
        value: '',
      ));
    });
  }
}

extension HabitRecordQueryObject
    on QueryBuilder<HabitRecord, HabitRecord, QFilterCondition> {}

extension HabitRecordQueryLinks
    on QueryBuilder<HabitRecord, HabitRecord, QFilterCondition> {}

extension HabitRecordQuerySortBy
    on QueryBuilder<HabitRecord, HabitRecord, QSortBy> {
  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> sortByDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durVal', Sort.asc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> sortByDurValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durVal', Sort.desc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> sortByStrVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strVal', Sort.asc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> sortByStrValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strVal', Sort.desc);
    });
  }
}

extension HabitRecordQuerySortThenBy
    on QueryBuilder<HabitRecord, HabitRecord, QSortThenBy> {
  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> thenByDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durVal', Sort.asc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> thenByDurValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durVal', Sort.desc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> thenByStrVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strVal', Sort.asc);
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QAfterSortBy> thenByStrValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strVal', Sort.desc);
    });
  }
}

extension HabitRecordQueryWhereDistinct
    on QueryBuilder<HabitRecord, HabitRecord, QDistinct> {
  QueryBuilder<HabitRecord, HabitRecord, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QDistinct> distinctByDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durVal');
    });
  }

  QueryBuilder<HabitRecord, HabitRecord, QDistinct> distinctByStrVal(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strVal', caseSensitive: caseSensitive);
    });
  }
}

extension HabitRecordQueryProperty
    on QueryBuilder<HabitRecord, HabitRecord, QQueryProperty> {
  QueryBuilder<HabitRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HabitRecord, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<HabitRecord, int?, QQueryOperations> durValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durVal');
    });
  }

  QueryBuilder<HabitRecord, String?, QQueryOperations> strValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strVal');
    });
  }
}
