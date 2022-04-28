import {LightningElement, wire} from 'lwc'
import getBoatTypes from "@salesforce/apex/BoatDataService.getBoatTypes"
import getBoats from "@salesforce/apex/BoatDataService.getBoats"


export default class BoatSearch extends LightningElement {

  selectedBoatId = "";

  isLoading = false

  // gestion d'erreur
  errors
  // The boat type id for the boat search
  selectedBoatTypeId = ""
  // The list of boats from the search
  // variable front <-> js
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
  boatTypes({data, error}) {
    if (data) {
      this.searchOptions = data.map(item => ({label: item.Name, value: item.Id}))
      this.searchOptions.unshift({label: 'All Types', value: ''})
    } else if (error) {
      console.error(error)
    }
  }

  // TODO: créer une méthode pour récupérer la liste des bateaux au clic du bouton
  handleBoatSearch() {
    this.isLoading = true
    getBoats({boatTypeId: this.selectedBoatTypeId})
      .then(data => {
        this.boatList = data
      }).catch(error => console.error(error))
      .finally(() => {
          this.isLoading = false
        },
      )
  }

  handleSearchOptionChange(event) {
    this.selectedBoatTypeId = event.detail.value
  }

  handleClick(event){
    console.log('clicked');
    console.log(event.target.dataset.id);
    this.selectedBoatId = event.target.dataset.recordId;
  }
}