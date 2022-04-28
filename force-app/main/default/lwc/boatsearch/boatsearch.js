import {LightningElement, wire} from 'lwc'
import getBoatTypes from "@salesforce/apex/BoatDataService.getBoatTypes"
// import getBoats from ...

export default class BoatSearch extends LightningElement {

  // The boat type id for the boat search
  selectedBoatTypeId = ""
  // The list of boats from the search
  boatList = []
  // The options for the picklist
  searchOptions = [
    {
      label: 'Tous les types',
      value: ''
    }
  ]

  // TODO : récupérer la liste des types de bateaux pour alimenter la picklist
  @wire(getBoatTypes)
  boatTypes({error, data}) {
    // handle data
    // TODO: transform the data received to fill the list of search options

    // handle error
  }

  // TODO: créer une méthode pour récupérer la liste des bateaux au clic du bouton
  handleBoatSearch() {
    // TODO : call apex method
  }

}