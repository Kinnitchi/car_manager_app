// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMaintenanceModelCollection on Isar {
  IsarCollection<MaintenanceModel> get maintenanceModels => this.collection();
}

const MaintenanceModelSchema = CollectionSchema(
  name: r'MaintenanceModel',
  id: -3341778564219202041,
  properties: {
    r'cost': PropertySchema(id: 0, name: r'cost', type: IsarType.double),
    r'date': PropertySchema(id: 1, name: r'date', type: IsarType.dateTime),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'mileage': PropertySchema(id: 3, name: r'mileage', type: IsarType.double),
    r'nextMaintenanceMileage': PropertySchema(
      id: 4,
      name: r'nextMaintenanceMileage',
      type: IsarType.long,
    ),
    r'notes': PropertySchema(id: 5, name: r'notes', type: IsarType.string),
    r'typeName': PropertySchema(
      id: 6,
      name: r'typeName',
      type: IsarType.string,
    ),
    r'vehicleId': PropertySchema(
      id: 7,
      name: r'vehicleId',
      type: IsarType.long,
    ),
    r'workshop': PropertySchema(
      id: 8,
      name: r'workshop',
      type: IsarType.string,
    ),
  },

  estimateSize: _maintenanceModelEstimateSize,
  serialize: _maintenanceModelSerialize,
  deserialize: _maintenanceModelDeserialize,
  deserializeProp: _maintenanceModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'vehicleId': IndexSchema(
      id: 2011968157433523416,
      name: r'vehicleId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'vehicleId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _maintenanceModelGetId,
  getLinks: _maintenanceModelGetLinks,
  attach: _maintenanceModelAttach,
  version: '3.3.2',
);

int _maintenanceModelEstimateSize(
  MaintenanceModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.typeName.length * 3;
  {
    final value = object.workshop;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _maintenanceModelSerialize(
  MaintenanceModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cost);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.description);
  writer.writeDouble(offsets[3], object.mileage);
  writer.writeLong(offsets[4], object.nextMaintenanceMileage);
  writer.writeString(offsets[5], object.notes);
  writer.writeString(offsets[6], object.typeName);
  writer.writeLong(offsets[7], object.vehicleId);
  writer.writeString(offsets[8], object.workshop);
}

MaintenanceModel _maintenanceModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MaintenanceModel();
  object.cost = reader.readDouble(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.id = id;
  object.mileage = reader.readDouble(offsets[3]);
  object.nextMaintenanceMileage = reader.readLongOrNull(offsets[4]);
  object.notes = reader.readStringOrNull(offsets[5]);
  object.typeName = reader.readString(offsets[6]);
  object.vehicleId = reader.readLong(offsets[7]);
  object.workshop = reader.readStringOrNull(offsets[8]);
  return object;
}

P _maintenanceModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _maintenanceModelGetId(MaintenanceModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _maintenanceModelGetLinks(MaintenanceModel object) {
  return [];
}

void _maintenanceModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  MaintenanceModel object,
) {
  object.id = id;
}

extension MaintenanceModelQueryWhereSort
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QWhere> {
  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhere> anyVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'vehicleId'),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension MaintenanceModelQueryWhere
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QWhereClause> {
  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  vehicleIdEqualTo(int vehicleId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'vehicleId', value: [vehicleId]),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  vehicleIdNotEqualTo(int vehicleId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'vehicleId',
                lower: [],
                upper: [vehicleId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'vehicleId',
                lower: [vehicleId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'vehicleId',
                lower: [vehicleId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'vehicleId',
                lower: [],
                upper: [vehicleId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  vehicleIdGreaterThan(int vehicleId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'vehicleId',
          lower: [vehicleId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  vehicleIdLessThan(int vehicleId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'vehicleId',
          lower: [],
          upper: [vehicleId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  vehicleIdBetween(
    int lowerVehicleId,
    int upperVehicleId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'vehicleId',
          lower: [lowerVehicleId],
          includeLower: includeLower,
          upper: [upperVehicleId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  dateEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'date', value: [date]),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  dateNotEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  dateGreaterThan(DateTime date, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [date],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  dateLessThan(DateTime date, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [],
          upper: [date],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterWhereClause>
  dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [lowerDate],
          includeLower: includeLower,
          upper: [upperDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MaintenanceModelQueryFilter
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QFilterCondition> {
  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  costEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cost',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  costGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cost',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  costLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cost',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  costBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cost',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  dateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  dateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'date',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  mileageEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mileage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  mileageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mileage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  mileageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mileage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  mileageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mileage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  nextMaintenanceMileageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'nextMaintenanceMileage'),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  nextMaintenanceMileageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'nextMaintenanceMileage'),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  nextMaintenanceMileageEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nextMaintenanceMileage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  nextMaintenanceMileageGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nextMaintenanceMileage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  nextMaintenanceMileageLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nextMaintenanceMileage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  nextMaintenanceMileageBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nextMaintenanceMileage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'typeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'typeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'typeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'typeName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'typeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'typeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'typeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'typeName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'typeName', value: ''),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  typeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'typeName', value: ''),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  vehicleIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'vehicleId', value: value),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  vehicleIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'vehicleId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  vehicleIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'vehicleId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  vehicleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'vehicleId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'workshop'),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'workshop'),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'workshop',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'workshop',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'workshop',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'workshop',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'workshop',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'workshop',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'workshop',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'workshop',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'workshop', value: ''),
      );
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterFilterCondition>
  workshopIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'workshop', value: ''),
      );
    });
  }
}

extension MaintenanceModelQueryObject
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QFilterCondition> {}

extension MaintenanceModelQueryLinks
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QFilterCondition> {}

extension MaintenanceModelQuerySortBy
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QSortBy> {
  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy> sortByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByNextMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMaintenanceMileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByNextMaintenanceMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMaintenanceMileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeName', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeName', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByWorkshop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workshop', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  sortByWorkshopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workshop', Sort.desc);
    });
  }
}

extension MaintenanceModelQuerySortThenBy
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QSortThenBy> {
  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy> thenByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByNextMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMaintenanceMileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByNextMaintenanceMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMaintenanceMileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeName', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeName', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByWorkshop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workshop', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QAfterSortBy>
  thenByWorkshopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workshop', Sort.desc);
    });
  }
}

extension MaintenanceModelQueryWhereDistinct
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct> {
  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct> distinctByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cost');
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct>
  distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct>
  distinctByMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mileage');
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct>
  distinctByNextMaintenanceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextMaintenanceMileage');
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct> distinctByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct>
  distinctByTypeName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct>
  distinctByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleId');
    });
  }

  QueryBuilder<MaintenanceModel, MaintenanceModel, QDistinct>
  distinctByWorkshop({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workshop', caseSensitive: caseSensitive);
    });
  }
}

extension MaintenanceModelQueryProperty
    on QueryBuilder<MaintenanceModel, MaintenanceModel, QQueryProperty> {
  QueryBuilder<MaintenanceModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MaintenanceModel, double, QQueryOperations> costProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cost');
    });
  }

  QueryBuilder<MaintenanceModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<MaintenanceModel, String, QQueryOperations>
  descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<MaintenanceModel, double, QQueryOperations> mileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mileage');
    });
  }

  QueryBuilder<MaintenanceModel, int?, QQueryOperations>
  nextMaintenanceMileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextMaintenanceMileage');
    });
  }

  QueryBuilder<MaintenanceModel, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<MaintenanceModel, String, QQueryOperations> typeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeName');
    });
  }

  QueryBuilder<MaintenanceModel, int, QQueryOperations> vehicleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleId');
    });
  }

  QueryBuilder<MaintenanceModel, String?, QQueryOperations> workshopProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workshop');
    });
  }
}
