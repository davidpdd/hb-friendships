@IsTest
private class AccountProcessorTest {
  @IsTest
  static void testCountContacts() {
    // GIVEN
    Account acc = new Account();
    acc.Name = 'ACC TEST';
    insert acc;
    Contact con = new Contact();
    con.AccountId = acc.Id;
    con.LastName = 'ACC NAME';
    insert con;

    List<Id> recordIds = new List<Id>();
    recordIds.add(acc.Id);

    // WHEN
    Test.startTest();
    AccountProcessor.countContacts(recordIds);
    Test.stopTest();

    // THEN
    Account accountAfter = [
      SELECT Id, Number_Of_Contacts__C
      FROM Account
      WHERE Id = :acc.Id
      LIMIT 1
    ];
    System.assertEquals(
      1,
      accountAfter.Number_Of_Contacts__c,
      'Should have copied the number of contacts on the account'
    );
  }
}
