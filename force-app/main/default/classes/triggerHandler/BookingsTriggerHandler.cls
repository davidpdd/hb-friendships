public with sharing class BookingsTriggerHandler {
  public static void onAfterInsert(List<Booking__c> bookings) {
    // Mettre à jour le statut de dispo du bateau
    updateBoatStatus(bookings);
  }

  private static void updateBoatStatus(List<Booking__c> bookings) {
    // Creer mon panier ou caddie à bateaux
    List<Boat__c> boatsToUpdate = new List<Boat__c>();

    // regarder nos bookings
    for (Booking__c booking : bookings) {
      // Id du boat
      Id boatId = booking.Boat__c;

      // Uniquement si le booking est rattaché à un bateau
      if (boatId != null) {
        // verifier date de debut
        Date debut = booking.Start_date__c;

        // verifier date de fin
        Date fin = booking.End_date__c;

        // disponible par défaut
        Boolean disponible = true;

        // Approche 1
        if (debut <= Date.today().addDays(3) && fin > Date.today()) {
          disponible = false;
        }

        // Approche 2
        // si booking est deja termine -> disponible
        if (fin < Date.today()) {
          // Disponible
        } else if (debut >= Date.today().addDays(3)) {
          // si booking est dans le futur "lointain" +3 jours -> disponible
          // Disponible
        } else {
          // Indisponible
          disponible = false;
        }

        if (!disponible) {
          // mettre a jour le statut du bateau
          Boat__c boatToUpdate = new Boat__c();
          boatToUpdate.Id = boatId;
          boatToUpdate.Disponibilite__c = 'Indisponible';
          //          boatToUpdate.put('Disponibilite__c', 'Indisponible');
          boatsToUpdate.add(boatToUpdate);
        }
      }
    }

    // met à jour les bateaux à mettre à jour
    update boatsToUpdate;
  }
}
