@IsTest
public with sharing class MaintenancesTriggerHandlerTest {
  @TestSetup
  private static void setupData() {
    // GIVEN : base case
    Contact con = new Contact();
    con.LastName = 'Contact';
    insert con;

    Boat__c bateau = new Boat__c(Name = 'TEST BOAT', Contact__c = con.Id);
    insert bateau;
  }

  /**
   * @description Method si on a pas de decoupage de code
   */
  @IsTest
  static void givenNewMaintenanceValidateStartDate() {
    // GIVEN
    Maintenance__c maintenance = new Maintenance__c();
    maintenance.StartDate__c = Date.today().addDays(-1);

    // WHEN
    Boolean exceptionCaught = false;
    try {
      insert maintenance;
    } catch (Exception e) {
      exceptionCaught = true;
    }

    // THEN
    System.assert(exceptionCaught, 'Should have caught an exception');
  }

  @IsTest
  static void givenEndDateBeforeStartDateThrowException() {
    // GIVEN
    Maintenance__c maintenance = new Maintenance__c();
    maintenance.StartDate__c = Date.today();
    maintenance.EndDate__c = Date.today().addDays(-1);

    // WHEN
    Boolean exceptionCaught = false;
    try {
      insert maintenance;
    } catch (Exception e) {
      exceptionCaught = true;
    }

    // THEN
    System.assert(exceptionCaught, 'Should have thrown an exception');
  }

  @IsTest
  static void givenMaintenanceWithBoatSetName() {
    // GIVEN : base case
    Maintenance__c maintenance = new Maintenance__c(
        Boat__c = [SELECT Id FROM Boat__c LIMIT 1].Id
    );

    // WHEN : action que je veux tester
    Test.startTest();
    insert maintenance;
    Test.stopTest();

    maintenance = [
      SELECT Id, Name
      FROM Maintenance__c
      WHERE Id = :maintenance.Id
      LIMIT 1
    ];

    // THEN : etat après l'action que je veux verifier
    String expectedName = String.valueOf(Date.today()) + '-TEST BOAT';
    System.assertEquals(
      expectedName,
      maintenance.Name,
      'The name should have been set properly'
    );
  }

  @IsTest
  static void givenMaintenanceWithBoatSetNameWithoutDML() {
    // GIVEN : base case
    Maintenance__c maintenance = new Maintenance__c(
      Boat__c = [SELECT Id FROM Boat__c WHERE Name = 'TEST BOAT' LIMIT 1]
      .Id
    );
    Maintenances domain = new Maintenances(
      new List<Maintenance__c>{ maintenance }
    );

    // WHEN : action que je veux tester
    domain.setName();

    // THEN : name should be set
    String expectedName = String.valueOf(Date.today()) + '-TEST BOAT';
    System.assertEquals(
      expectedName,
      maintenance.Name,
      'The name should have been set properly'
    );
  }
}
