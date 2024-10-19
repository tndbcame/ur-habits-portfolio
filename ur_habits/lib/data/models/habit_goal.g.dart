// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_goal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHabitGoalCollection on Isar {
  IsarCollection<HabitGoal> get habitGoals => this.collection();
}

const HabitGoalSchema = CollectionSchema(
  name: r'HabitGoal',
  id: 2438477636000436966,
  properties: {
    r'currentDurVal': PropertySchema(
      id: 0,
      name: r'currentDurVal',
      type: IsarType.long,
    ),
    r'currentStrVal': PropertySchema(
      id: 1,
      name: r'currentStrVal',
      type: IsarType.string,
    ),
    r'deadline': PropertySchema(
      id: 2,
      name: r'deadline',
      type: IsarType.dateTime,
    ),
    r'incDecTyep': PropertySchema(
      id: 3,
      name: r'incDecTyep',
      type: IsarType.long,
    ),
    r'inputedDate': PropertySchema(
      id: 4,
      name: r'inputedDate',
      type: IsarType.dateTime,
    ),
    r'memo': PropertySchema(
      id: 5,
      name: r'memo',
      type: IsarType.string,
    ),
    r'targetDurVal': PropertySchema(
      id: 6,
      name: r'targetDurVal',
      type: IsarType.long,
    ),
    r'targetStrVal': PropertySchema(
      id: 7,
      name: r'targetStrVal',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 8,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _habitGoalEstimateSize,
  serialize: _habitGoalSerialize,
  deserialize: _habitGoalDeserialize,
  deserializeProp: _habitGoalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _habitGoalGetId,
  getLinks: _habitGoalGetLinks,
  attach: _habitGoalAttach,
  version: '3.1.0+1',
);

int _habitGoalEstimateSize(
  HabitGoal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.currentStrVal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.memo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.targetStrVal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _habitGoalSerialize(
  HabitGoal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.currentDurVal);
  writer.writeString(offsets[1], object.currentStrVal);
  writer.writeDateTime(offsets[2], object.deadline);
  writer.writeLong(offsets[3], object.incDecTyep);
  writer.writeDateTime(offsets[4], object.inputedDate);
  writer.writeString(offsets[5], object.memo);
  writer.writeLong(offsets[6], object.targetDurVal);
  writer.writeString(offsets[7], object.targetStrVal);
  writer.writeString(offsets[8], object.title);
}

HabitGoal _habitGoalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HabitGoal();
  object.currentDurVal = reader.readLongOrNull(offsets[0]);
  object.currentStrVal = reader.readStringOrNull(offsets[1]);
  object.deadline = reader.readDateTimeOrNull(offsets[2]);
  object.id = id;
  object.incDecTyep = reader.readLongOrNull(offsets[3]);
  object.inputedDate = reader.readDateTimeOrNull(offsets[4]);
  object.memo = reader.readStringOrNull(offsets[5]);
  object.targetDurVal = reader.readLongOrNull(offsets[6]);
  object.targetStrVal = reader.readStringOrNull(offsets[7]);
  object.title = reader.readStringOrNull(offsets[8]);
  return object;
}

P _habitGoalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _habitGoalGetId(HabitGoal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _habitGoalGetLinks(HabitGoal object) {
  return [];
}

void _habitGoalAttach(IsarCollection<dynamic> col, Id id, HabitGoal object) {
  object.id = id;
}

extension HabitGoalQueryWhereSort
    on QueryBuilder<HabitGoal, HabitGoal, QWhere> {
  QueryBuilder<HabitGoal, HabitGoal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HabitGoalQueryWhere
    on QueryBuilder<HabitGoal, HabitGoal, QWhereClause> {
  QueryBuilder<HabitGoal, HabitGoal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<HabitGoal, HabitGoal, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterWhereClause> idBetween(
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

extension HabitGoalQueryFilter
    on QueryBuilder<HabitGoal, HabitGoal, QFilterCondition> {
  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentDurValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentDurVal',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentDurValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentDurVal',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentDurValEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentDurVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentDurValGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentDurVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentDurValLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentDurVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentDurValBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentDurVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentStrVal',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentStrVal',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStrVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currentStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currentStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currentStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currentStrVal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStrVal',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      currentStrValIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currentStrVal',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> deadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      deadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> deadlineEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> deadlineGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> deadlineLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> deadlineBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deadline',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> incDecTyepIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'incDecTyep',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      incDecTyepIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'incDecTyep',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> incDecTyepEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'incDecTyep',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      incDecTyepGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'incDecTyep',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> incDecTyepLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'incDecTyep',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> incDecTyepBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'incDecTyep',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      inputedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inputedDate',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      inputedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inputedDate',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> inputedDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      inputedDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> inputedDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> inputedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memo',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> memoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetDurValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetDurVal',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetDurValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetDurVal',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> targetDurValEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetDurVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetDurValGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetDurVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetDurValLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetDurVal',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> targetDurValBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetDurVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetStrVal',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetStrVal',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> targetStrValEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> targetStrValBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetStrVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'targetStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'targetStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'targetStrVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> targetStrValMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'targetStrVal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetStrVal',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition>
      targetStrValIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'targetStrVal',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension HabitGoalQueryObject
    on QueryBuilder<HabitGoal, HabitGoal, QFilterCondition> {}

extension HabitGoalQueryLinks
    on QueryBuilder<HabitGoal, HabitGoal, QFilterCondition> {}

extension HabitGoalQuerySortBy on QueryBuilder<HabitGoal, HabitGoal, QSortBy> {
  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByCurrentDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDurVal', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByCurrentDurValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDurVal', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByCurrentStrVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStrVal', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByCurrentStrValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStrVal', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByIncDecTyep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incDecTyep', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByIncDecTyepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incDecTyep', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByInputedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputedDate', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByInputedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputedDate', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByTargetDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDurVal', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByTargetDurValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDurVal', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByTargetStrVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetStrVal', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByTargetStrValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetStrVal', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension HabitGoalQuerySortThenBy
    on QueryBuilder<HabitGoal, HabitGoal, QSortThenBy> {
  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByCurrentDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDurVal', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByCurrentDurValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDurVal', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByCurrentStrVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStrVal', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByCurrentStrValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStrVal', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByIncDecTyep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incDecTyep', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByIncDecTyepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incDecTyep', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByInputedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputedDate', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByInputedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputedDate', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByTargetDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDurVal', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByTargetDurValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDurVal', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByTargetStrVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetStrVal', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByTargetStrValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetStrVal', Sort.desc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension HabitGoalQueryWhereDistinct
    on QueryBuilder<HabitGoal, HabitGoal, QDistinct> {
  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByCurrentDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentDurVal');
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByCurrentStrVal(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStrVal',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deadline');
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByIncDecTyep() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'incDecTyep');
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByInputedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inputedDate');
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByTargetDurVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetDurVal');
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByTargetStrVal(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetStrVal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HabitGoal, HabitGoal, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension HabitGoalQueryProperty
    on QueryBuilder<HabitGoal, HabitGoal, QQueryProperty> {
  QueryBuilder<HabitGoal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HabitGoal, int?, QQueryOperations> currentDurValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentDurVal');
    });
  }

  QueryBuilder<HabitGoal, String?, QQueryOperations> currentStrValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStrVal');
    });
  }

  QueryBuilder<HabitGoal, DateTime?, QQueryOperations> deadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deadline');
    });
  }

  QueryBuilder<HabitGoal, int?, QQueryOperations> incDecTyepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'incDecTyep');
    });
  }

  QueryBuilder<HabitGoal, DateTime?, QQueryOperations> inputedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inputedDate');
    });
  }

  QueryBuilder<HabitGoal, String?, QQueryOperations> memoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memo');
    });
  }

  QueryBuilder<HabitGoal, int?, QQueryOperations> targetDurValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetDurVal');
    });
  }

  QueryBuilder<HabitGoal, String?, QQueryOperations> targetStrValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetStrVal');
    });
  }

  QueryBuilder<HabitGoal, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
