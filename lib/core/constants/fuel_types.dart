enum FuelType {
  gasoline,
  ethanol,
  diesel,
  gnv,
  flex;

  String get label {
    switch (this) {
      case FuelType.gasoline:
        return 'Gasolina';
      case FuelType.ethanol:
        return 'Etanol';
      case FuelType.diesel:
        return 'Diesel';
      case FuelType.gnv:
        return 'GNV';
      case FuelType.flex:
        return 'Flex';
    }
  }
}
