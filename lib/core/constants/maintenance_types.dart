enum MaintenanceType {
  oilChange,
  oilFilter,
  alignment,
  balancing,
  tireChange,
  sparkPlugs,
  timingBelt,
  injectionSystem,
  brakes,
  battery,
  generalRevision,
  other;

  String get label {
    switch (this) {
      case MaintenanceType.oilChange:
        return 'Troca de óleo';
      case MaintenanceType.oilFilter:
        return 'Troca de filtro';
      case MaintenanceType.alignment:
        return 'Alinhamento';
      case MaintenanceType.balancing:
        return 'Balanceamento';
      case MaintenanceType.tireChange:
        return 'Troca de pneus';
      case MaintenanceType.sparkPlugs:
        return 'Velas';
      case MaintenanceType.timingBelt:
        return 'Correia dentada';
      case MaintenanceType.injectionSystem:
        return 'Sistema de injeção';
      case MaintenanceType.brakes:
        return 'Freios';
      case MaintenanceType.battery:
        return 'Bateria';
      case MaintenanceType.generalRevision:
        return 'Revisão geral';
      case MaintenanceType.other:
        return 'Outro';
    }
  }

  /// Intervalo sugerido em km para prever a próxima manutenção.
  /// null = não é possível prever automaticamente (ex: "Outro").
  int? get suggestedIntervalKm {
    switch (this) {
      case MaintenanceType.oilChange:
        return 5000;
      case MaintenanceType.oilFilter:
        return 10000;
      case MaintenanceType.alignment:
        return 10000;
      case MaintenanceType.balancing:
        return 10000;
      case MaintenanceType.tireChange:
        return 40000;
      case MaintenanceType.sparkPlugs:
        return 30000;
      case MaintenanceType.timingBelt:
        return 60000;
      case MaintenanceType.injectionSystem:
        return 20000;
      case MaintenanceType.brakes:
        return 15000;
      case MaintenanceType.battery:
        return null;
      case MaintenanceType.generalRevision:
        return 10000;
      case MaintenanceType.other:
        return null;
    }
  }
}
