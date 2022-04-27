// Liste des bateaux qui ont un certain type
String type = '';
List<Boat__c> filteredByType = [SELECT Id FROM Boat__c WHERE  BoatType__r.Name = :type];

// Liste de tous les bateaux avec les maintenances associees
List<Boat__c> boatsWithMaintenances = [SELECT Id, (SELECT Id FROM Maintenances__r) FROM Boat__c];


// Recuperer tous les bateaux de type "Jet Ski"
List<Boat__c> jetSkis = [SELECT Id FROM Boat__c WHERE Boat__r.Name = 'Jet SKi'];


// Map<String, Integer> nombre de bateaux par type
Map<String, List<Boat__c> boatTypeToBoats = new Map<String, List<Boat__c>();

// version 1 : recuperer tous les bateaux, on itere et on remplie une map
System.debug('✅ : ' + JSON.serializePretty(mappedBoatPerType));

// TODO : check map instantiation from aggregate resul

for(Boat__c boat : [SELECT Id,Name, BoatType__r.Name FROM Boat__c]){
  String type = boat.BoatType__r.Name;
  // soit ma map a deja le type
  if(boatTypeToBoats.containsKey(type)){
      boatTypeToBoats.get(type).add(boat);
  // soit ma map n'a pas encore le type
  } else {
      boatTypeToBoats.put(type, new List<Boat__c>{boat})
  }
}

// version 2 : on passe par une aggregation
List<AggregateResult> result = [SELECT Count(Id) total, BoatType__r.Name FROM Boat__c GROUP BY BoatType__r.Name];
Map<String, Integer> mappedBoatPerType = new Map<String, Integer> ();
for(AggregateResult ar : result){
    mappedBoatPerType.put(ar.get('Name'), ar.get('total;);
}
System.debug(result);



// Tous les bateaux avec le nom du contact parent, 
// le nom du compte parent, et les maintenances associees mais uniquement celles traitees
List<Boat__c> boatsWithData = [
    SELECT Id, Contact.Name, Contact.Account.Name, (
        SELECT Id FROM Maintenances__r WHERE Statut__c = 'Traité'
    ) FROM Boat__c
];
