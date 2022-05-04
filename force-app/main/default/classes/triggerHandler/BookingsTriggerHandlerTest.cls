@IsTest
private class BookingsTriggerHandlerTest {
  @TestSetup
  private static void setupData() {
    // GIVEN : base case
    Contact con = new Contact();
    con.LastName = 'Contact';
    insert con;

    Boat__c bateau = new Boat__c(
      Name = 'TEST BOAT',
      Contact__c = con.Id,
      Disponibilite__c = 'Disponible'
    );
    insert bateau;
  }

  @IsTest
  static void givenEndDateInThePast() {
    // GIVEN
    // Un bateau
    Boat__c boat = [SELECT Id FROM Boat__c WHERE Name = 'TEST BOAT' LIMIT 1];

    // Un booking
    Booking__c booking = new Booking__c();
    booking.End_date__c = Date.today().addDays(-1);
    booking.Boat__c = boat.Id;

    List<Booking__c> bookings = new List<Booking__c>();
    bookings.add(booking);

    // WHEN : "insert" un booking
    Test.startTest();
    BookingsTriggerHandler.onAfterInsert(bookings);
    Test.stopTest();

    // THEN : le statut du bateau doit être mis à jour
    Boat__c boatAfter = [
      SELECT Id, Disponibilite__c
      FROM Boat__c
      WHERE Name = 'TEST BOAT'
      LIMIT 1
    ];
    System.assertEquals(
      'Disponible',
      boatAfter.Disponibilite__c,
      'Devrait etre dispo'
    );
  }
}
