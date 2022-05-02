public with sharing class AccountProcessor {
  @Future
  public static void countContacts(List<Id> recordIds) {
    List<Account> accounts = [
      SELECT Id, (SELECT Id FROM Contacts)
      FROM Account
      WHERE Id IN :recordIds
    ];

    for (Account account : accounts) {
      account.Number_of_Contacts__c = account.Contacts.size();
    }
    update accounts;
  }
}
