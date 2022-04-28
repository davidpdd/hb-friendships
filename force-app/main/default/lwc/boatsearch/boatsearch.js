import {LightningElement, wire} from 'lwc'
import getBoatTypes from "@salesforce/apex/BoatDataService.getBoatTypes"
import getBoats from "@salesforce/apex/BoatDataService.getBoats"

export default class BoatSearch extends LightningElement {

  // The boat type id for the boat search
  selectedBoatTypeId = ""
  // The list of boats from the search
  boatList = []
  // The options for the picklist
  searchOptions = [
    {
      label: 'Tous les types',
      value: '',
    },
  ]

  // TODO : récupérer la liste des types de bateaux pour alimenter la picklist
  @wire(getBoatTypes)
  boatTypes({error, data}) {
    if (data) {
      this.searchOptions = data.map(type => ({label: type.Name, value: type.Id}))
      this.searchOptions.unshift({label: 'All Types', value: ''})
    } else if (error) {
      console.error(error)
    }
  }

  // TODO: créer une méthode pour récupérer la liste des bateaux au clic du bouton
  handleBoatSearch(event) {
    getBoats({boatTypeId: this.selectedBoatTypeId})
      .then(data => {
        this.boatList = data
      }).catch(error => console.error(error))
      .finally(() => console.log(this.boatList))
  }

  handleSearchOptionChange(event) {
    this.selectedBoatTypeId = event.detail.value
  }

}