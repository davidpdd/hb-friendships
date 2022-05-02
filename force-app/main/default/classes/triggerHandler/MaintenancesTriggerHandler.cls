public with sharing class MaintenancesTriggerHandler {
  public static void onBeforeInsert(List<Maintenance__c> newList) {
    // Niveau 2 : le code dans le trigger handler
    for (Maintenance__c maintenance : newList) {
      // validate start date in the past
      if (maintenance.StartDate__c < Date.today()) {
        maintenance.addError('La date de début ne doit pas être dans le passé');
      }
    }

    // Niveau 3 : la méthode privée dans le handler
    validateEndDate(newList);

    // Niveau 4 : la délégation à un domaine dédié via une méthode statique

    // Niveau 5 : on instancie un nouveau domaine avec la liste d'enregistrements
    Maintenances maintenances = new Maintenances(newList);
    maintenances.validateConflict();

    // called in trigger handler and dependent on trigger execution
    maintenances.setName();
  }

  private static void validateEndDate(List<Maintenance__c> maintenances) {
    for (Maintenance__c maintenance : maintenances) {
      // validate start date
      if (maintenance.StartDate__c > maintenance.EndDate__c) {
        maintenance.addError(
          'La date de début ne doit pas être après la date de fin'
        );
      }
    }
  }
}
