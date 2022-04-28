public with sharing class FriendShipsController {


    @AuraEnabled
    public static List<Boat__c> getAllBoats(){
        // TODO: move query to BoatsSelector
        // return BoatsSelector.selectBoats();
      return [SELECT Id, Name,  (SELECT Id, Name FROM Maintenances__r) FROM Boat__c];
    }
}
