public with sharing class Maintenances {
  private List<Maintenance__c> maintenances;

  public Maintenances(List<Maintenance__c> maintenances) {
    this.maintenances = maintenances;
  }

  public void validateConflict() {
    // retrieve boat ids
    Set<Id> boatIds = new Set<Id>();
    List<Maintenance__c> maintenancesInProgress = new List<Maintenance__c>();
    for (Maintenance__c maintenance : maintenances) {
      if (maintenance.Statut__c == 'En cours' && maintenance.Boat__c != null) {
        boatIds.add(maintenance.Boat__c);
        maintenancesInProgress.add(maintenance);
      }
    }

    // retrieve boats with maintenances "en cours".
    // Idéalement, faire appel a un selector
    // Le limit 1 nous permet d'économiser des ressources car on cherche uniquement à vérifier
    // s'il y a au moins une maintenance en cours.
    Map<Id, Boat__c> boatsWithMaintenances = new Map<Id, Boat__c>(
      [
        SELECT
          Id,
          (SELECT Id FROM Maintenances__r WHERE Statut__c = 'En cours' LIMIT 1)
        FROM Boat__c
        WHERE Id IN :boatIds
      ]
    );

    // add error if there is a maintenance already
    for (Maintenance__c maintenance : maintenancesInProgress) {
      // on récupère le bateau avec les maintenances en cours (enfants)
      // si on trouve une maintenance, c'est qu'il y a deja une maintenance en cours, donc on
      // peut ajouter notre erreur
      Boat__c boatAssocie = boatsWithMaintenances.get(maintenance.Boat__c);
      List<Maintenance__c> maintenancesDuBateauAssocie = boatAssocie.Maintenances__r;
      if (
        !maintenancesDuBateauAssocie.isEmpty()
      ) {
        maintenance.addError('Une maintenance est déjà en cours sur ce bateau');
      }
    }
  }

  public void setName() {
    // creation du set pour collecter les ids
    Set<Id> boatIds = new Set<Id>();

    for (Maintenance__c maintenance : maintenances) {
      // Collect the ids
      boatIds.add(maintenance.Boat__c);
    }

    // Récupérer en une fois tous les bateaux dont on a besoin
    List<Boat__c> boatsWithName = [
      SELECT Id, Name
      FROM Boat__c
      WHERE Id IN :boatIds
    ];

    // Transformer la liste en map ou créer une map directement
    //    Map<Id, Boat__c> boatsById = new Map<Id, Boat__c>(
    //      [SELECT Id, Name FROM Boat__c WHERE Id IN :boatIds]
    //    );
    Map<Id, Boat__c> boatsById = new Map<Id, Boat__c>(boatsWithName);

    // Reboucler sur les maintenances pour créer le nom
    for (Maintenance__c maintenance : maintenances) {
      // Récupérer l'id du boat
      Id boatId = maintenance.Boat__c;
      // Récupérer le boat
      Boat__c boatFromMaintenance = boatsById.get(boatId);
      // Create the name
      String boatName =
        String.valueOf(Date.today()) +
        '-' +
        boatFromMaintenance?.Name;
      // Set the name
      maintenance.Name = boatName;
    }
  }
}
