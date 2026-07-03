// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFuelModelCollection on Isar {
  IsarCollection<FuelModel> get fuelModels => this.collection();
}

const FuelModelSchema = CollectionSchema(
  name: r'FuelModel',
  id: 422056018655903649,
  properties: {
    r'date': PropertySchema(id: 0, name: r'date', type: IsarType.dateTime),
    r'fuelTypeName': PropertySchema(
      id: 1,
      name: r'fuelTypeName',
      type: IsarType.string,
    ),
    r'fullTank': PropertySchema(id: 2, name: r'fullTank', type: IsarType.bool),
    r'liters': PropertySchema(id: 3, name: r'liters', type: IsarType.double),
    r'mileage': PropertySchema(id: 4, name: r'mileage', type: IsarType.double),
    r'pricePerLiter': PropertySchema(
      id: 5,
      name: r'pricePerLiter',
      type: IsarType.double,
    ),
    r'totalValue': PropertySchema(
      id: 6,
      name: r'totalValue',
      type: IsarType.double,
    ),
    r'vehicleId': PropertySchema(
      id: 7,
      name: r'vehicleId',
      type: IsarType.long,
    ),
  },

  estimateSize: _fuelModelEstimateSize,
  serialize: _fuelModelSerialize,
  deserialize: _fuelModelDeserialize,
  deserializeProp: _fuelModelDeserializeProp,
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

  getId: _fuelModelGetId,
  getLinks: _fuelModelGetLinks,
  attach: _fuelModelAttach,
  version: '3.3.2',
);

int _fuelModelEstimateSize(
  FuelModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fuelTypeName.length * 3;
  return bytesCount;
}

void _fuelModelSerialize(
  FuelModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeString(offsets[1], object.fuelTypeName);
  writer.writeBool(offsets[2], object.fullTank);
  writer.writeDouble(offsets[3], object.liters);
  writer.writeDouble(offsets[4], object.mileage);
  writer.writeDouble(offsets[5], object.pricePerLiter);
  writer.writeDouble(offsets[6], object.totalValue);
  writer.writeLong(offsets[7], object.vehicleId);
}

FuelModel _fuelModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FuelModel();
  object.date = reader.readDateTime(offsets[0]);
  object.fuelTypeName = reader.readString(offsets[1]);
  object.fullTank = reader.readBool(offsets[2]);
  object.id = id;
  object.liters = reader.readDouble(offsets[3]);
  object.mileage = reader.readDouble(offsets[4]);
  object.pricePerLiter = reader.readDouble(offsets[5]);
  object.totalValue = reader.readDouble(offsets[6]);
  object.vehicleId = reader.readLong(offsets[7]);
  return object;
}

P _fuelModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fuelModelGetId(FuelModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fuelModelGetLinks(FuelModel object) {
  return [];
}

void _fuelModelAttach(IsarCollection<dynamic> col, Id id, FuelModel object) {
  object.id = id;
}

extension FuelModelQueryWhereSort
    on QueryBuilder<FuelModel, FuelModel, QWhere> {
  QueryBuilder<FuelModel, FuelModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterWhere> anyVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'vehicleId'),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension FuelModelQueryWhere
    on QueryBuilder<FuelModel, FuelModel, QWhereClause> {
  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> vehicleIdEqualTo(
    int vehicleId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'vehicleId', value: [vehicleId]),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> vehicleIdNotEqualTo(
    int vehicleId,
  ) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> vehicleIdGreaterThan(
    int vehicleId, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> vehicleIdLessThan(
    int vehicleId, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> vehicleIdBetween(
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> dateEqualTo(
    DateTime date,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'date', value: [date]),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> dateNotEqualTo(
    DateTime date,
  ) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterWhereClause> dateBetween(
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

extension FuelModelQueryFilter
    on QueryBuilder<FuelModel, FuelModel, QFilterCondition> {
  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> dateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> fuelTypeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fuelTypeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  fuelTypeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fuelTypeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  fuelTypeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fuelTypeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> fuelTypeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fuelTypeName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  fuelTypeNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fuelTypeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  fuelTypeNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fuelTypeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  fuelTypeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fuelTypeName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> fuelTypeNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fuelTypeName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  fuelTypeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fuelTypeName', value: ''),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  fuelTypeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fuelTypeName', value: ''),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> fullTankEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fullTank', value: value),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> litersEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'liters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> litersGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'liters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> litersLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'liters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> litersBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'liters',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> mileageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> mileageGreaterThan(
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> mileageLessThan(
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> mileageBetween(
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  pricePerLiterEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pricePerLiter',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  pricePerLiterGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pricePerLiter',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  pricePerLiterLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pricePerLiter',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  pricePerLiterBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pricePerLiter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> totalValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'totalValue',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
  totalValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalValue',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> totalValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalValue',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> totalValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> vehicleIdEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'vehicleId', value: value),
      );
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition>
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> vehicleIdLessThan(
    int value, {
    bool include = false,
  }) {
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

  QueryBuilder<FuelModel, FuelModel, QAfterFilterCondition> vehicleIdBetween(
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
}

extension FuelModelQueryObject
    on QueryBuilder<FuelModel, FuelModel, QFilterCondition> {}

extension FuelModelQueryLinks
    on QueryBuilder<FuelModel, FuelModel, QFilterCondition> {}

extension FuelModelQuerySortBy on QueryBuilder<FuelModel, FuelModel, QSortBy> {
  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByFuelTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelTypeName', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByFuelTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelTypeName', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByFullTank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullTank', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByFullTankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullTank', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'liters', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByLitersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'liters', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileage', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileage', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByPricePerLiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerLiter', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByPricePerLiterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerLiter', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByTotalValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalValue', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByTotalValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalValue', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> sortByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }
}

extension FuelModelQuerySortThenBy
    on QueryBuilder<FuelModel, FuelModel, QSortThenBy> {
  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByFuelTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelTypeName', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByFuelTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelTypeName', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByFullTank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullTank', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByFullTankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullTank', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'liters', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByLitersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'liters', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileage', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileage', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByPricePerLiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerLiter', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByPricePerLiterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerLiter', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByTotalValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalValue', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByTotalValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalValue', Sort.desc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QAfterSortBy> thenByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }
}

extension FuelModelQueryWhereDistinct
    on QueryBuilder<FuelModel, FuelModel, QDistinct> {
  QueryBuilder<FuelModel, FuelModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<FuelModel, FuelModel, QDistinct> distinctByFuelTypeName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fuelTypeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FuelModel, FuelModel, QDistinct> distinctByFullTank() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullTank');
    });
  }

  QueryBuilder<FuelModel, FuelModel, QDistinct> distinctByLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'liters');
    });
  }

  QueryBuilder<FuelModel, FuelModel, QDistinct> distinctByMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mileage');
    });
  }

  QueryBuilder<FuelModel, FuelModel, QDistinct> distinctByPricePerLiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pricePerLiter');
    });
  }

  QueryBuilder<FuelModel, FuelModel, QDistinct> distinctByTotalValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalValue');
    });
  }

  QueryBuilder<FuelModel, FuelModel, QDistinct> distinctByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleId');
    });
  }
}

extension FuelModelQueryProperty
    on QueryBuilder<FuelModel, FuelModel, QQueryProperty> {
  QueryBuilder<FuelModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FuelModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<FuelModel, String, QQueryOperations> fuelTypeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fuelTypeName');
    });
  }

  QueryBuilder<FuelModel, bool, QQueryOperations> fullTankProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullTank');
    });
  }

  QueryBuilder<FuelModel, double, QQueryOperations> litersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'liters');
    });
  }

  QueryBuilder<FuelModel, double, QQueryOperations> mileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mileage');
    });
  }

  QueryBuilder<FuelModel, double, QQueryOperations> pricePerLiterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pricePerLiter');
    });
  }

  QueryBuilder<FuelModel, double, QQueryOperations> totalValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalValue');
    });
  }

  QueryBuilder<FuelModel, int, QQueryOperations> vehicleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleId');
    });
  }
}
