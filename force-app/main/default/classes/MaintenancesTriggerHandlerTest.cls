@IsTest
public with sharing class MaintenancesTriggerHandlerTest {
  @IsTest
  private void testInsert() {
    Test.startTest();
    insert new Maintenance__c();
    Test.stopTest();
  }
}
