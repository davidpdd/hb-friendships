public with sharing class BoatSearchController {

  @AuraEnabled(Cacheable= true)
  public static List<Boat__c> getAvailableBoats(){
    return BoatsSelector.selectAvailable();
  }

}