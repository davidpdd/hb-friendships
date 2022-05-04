trigger Bookings on Booking__c(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete
) {

  // Uniquement après insertion
  if(Trigger.isAfter && Trigger.isInsert){
    BookingsTriggerHandler.onAfterInsert(Trigger.new);
  }

}
