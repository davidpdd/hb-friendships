@isTest
public with sharing class MaintenanceStatusJobTest {
    
    @isTest public static void testBatch(){
        //given
        Maintenance__c maint = new Maintenance__c();
        maint.StartDate__c = Date.newInstance(2022, 05, 02);
        maint.EndDate__c = Date.newInstance(2022, 05, 30);
        maint.Statut__c  = 'En cours';
        insert maint;

        //when
        Test.startTest();
        MaintenanceStatusJob myBatchObject = new MaintenanceStatusJob();
        Id batchId = Database.executeBatch(myBatchObject, 1000);
        Test.stopTest();
        
        //then
        Maintenance__c maintenance = [SELECT Id, Statut__c FROM Maintenance__c WHERE Id = :maint.Id LIMIT 1];
        
        System.assertEquals('En cours', maintenance.Statut__c, 'Le statut est en cours');
    


    }

    @isTest public static void badEndDate(){
        //given
        Maintenance__c maint = new Maintenance__c();
        maint.StartDate__c = Date.newInstance(2022, 04, 20);
        maint.EndDate__c = Date.newInstance(2022, 05, 01);
        maint.Statut__c  = 'En cours';
        MaintenancesTriggerHandler.BYPASS = true;
        insert maint;

        //when
        Test.startTest();
        MaintenanceStatusJob myBatchObject = new MaintenanceStatusJob();
        Id batchId = Database.executeBatch(myBatchObject, 1000);
        Test.stopTest();
        
        //then
        Maintenance__c maintenance = [SELECT Id, Statut__c FROM Maintenance__c WHERE Id = :maint.Id LIMIT 1];
        
        System.assertEquals('Traité', maintenance.Statut__c, 'Le statut est traitée');
    


    }
}