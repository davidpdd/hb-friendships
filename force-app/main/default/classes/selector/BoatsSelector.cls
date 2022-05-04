public with sharing class BoatsSelector {
  public static List<Boat__c> selectById(Set<Id> idSet) {
    return [SELECT Id, Name FROM Boat__c WHERE Id IN :idSet];
  }

  public static List<Boat__c> selectByType(String type) {
    return [SELECT Id, Name FROM Boat__c WHERE BoatType__r.Name = :type];
  }

  // ---------- Parent  Parent__r.Field
  // --------------------------------------------------- FROM SObject
  // --------- (Subquery) (SELECT Id FROM ChildRelationShipName)
  public static List<Boat__c> selectByIdWithMaintenances(Set<Id> idSet) {
    return [
      SELECT Id, (SELECT Id FROM Maintenances__r)
      FROM Boat__c
      WHERE Id IN :idSet
    ];
  }

  public static List<Boat__c> selectAvailable() {
    return [
      SELECT
        Name,
        Description__c,
        Geolocation__Latitude__s,
        Geolocation__Longitude__s,
        Picture__c,
        Contact__r.Name,
        BoatType__c,
        BoatType__r.Name,
        Length__c,
        Price__c
      FROM Boat__c
      WHERE Disponibilite__c = 'Disponible'
    ];
  }
}
