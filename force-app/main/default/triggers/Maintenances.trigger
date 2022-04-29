trigger Maintenances on Maintenance__c(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete,
  after undelete
) {
  // Before
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      // Niveau 0 (a ne pas faire) : le code dans le trigger
      // Set statut to "en cours" si en cours ou planifiée si dans le futur
      for (Maintenance__c maintenance : Trigger.new) {
        // set statut
        if (maintenance.StartDate__c > Date.today()) {
          maintenance.Statut__c = 'Planifiée';
        } else {
          maintenance.Statut__c = 'En cours';
        }
      }

      // Niveau 1 : déléguer à un trigger handler
      MaintenancesTriggerHandler.onBeforeInsert(Trigger.new);
    }
  }

}
