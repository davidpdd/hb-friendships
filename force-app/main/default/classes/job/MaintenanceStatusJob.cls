public with sharing class MaintenanceStatusJob implements Database.Batchable<SObject> {
    

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator(
            'SELECT Id, EndDate__c FROM Maintenance__c WHERE Statut__c = \'En cours\' AND EndDate__c < TODAY' 
        );
    }

    /**
     * On veut changer le statut des maintenances dont la date de fin de maintenance est passee
     */
    public void execute(Database.BatchableContext bc, List<Maintenance__c> records){
        // process each batch of records>();
        for(Maintenance__c maintenance : records) {
            maintenance.Statut__c = 'Traité'; 
        }
        update records;
    }

    
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        // debug
        // mail erreur
        // retry
    }



}
