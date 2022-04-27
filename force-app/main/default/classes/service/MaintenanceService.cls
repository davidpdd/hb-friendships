public with sharing class MaintenanceService {

    
    // methode pour creer une maintenance
    public static Maintenance__c newMaintenance(Maintenance__c maintenance){
        maintenance.StartDate__c = Date.today();
        insert maintenance;
        return maintenance;
    }

    // methode pour terminer une maintenance
    public static Boolean endMaintenance(Id maintenanceId, String status){
        try {
            update new Maintenance__c(
                Id = maintenanceId,
                Statut__c = status,
                EndDate__c = Date.today()
            );
            return true;
        } catch (Exception e){
            return false;
        }

    }


}
