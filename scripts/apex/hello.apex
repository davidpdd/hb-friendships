List<String> names = new List<String>{'joe', 'joe', 'jane'};
System.debug(names);

Set<String> namesSet = new Set<String>(names);
System.debug(namesSet);

Map<Id, String> map = new Map<Id, String>();

map.values(); // renvoie les valeurs en list
map.keySet(); // renvoie un set des cles


List<Boat__c> boats = BoatsSelector.selectById(new Map<Id, Boat__c>([SELECT Id FROM Boat__c]).keySet());
System.debug(JSON.serializePretty(boats));
