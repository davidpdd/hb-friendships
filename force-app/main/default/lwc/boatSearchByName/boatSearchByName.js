import { LightningElement, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import getAvailableBoats from "@salesforce/apex/BoatSearchController.getAvailableBoats";

export default class BoatSearchByName extends NavigationMixin(
  LightningElement
) {
  availableBoats = [];
  filteredBoats = [];
  isLoading = true;

  /**
   * Declenchee automatiquement au chargement de la page
   * @param data
   * @param error
   */
  @wire(getAvailableBoats)
  wiredBoats({ data, error }) {
    if (data) {
      this.availableBoats = data;
      this.resetList();
    } else {
      console.error(error);
    }
    this.isLoading = false;
  }

  /**
   * Methode pour gerer la modification d'une valeur dans l'input
   * @param event
   */
  handleSearch(event) {
    const name = event.detail.value;
    if (name === "") {
      this.resetList();
    } else {
      this.filterList(name);
    }
  }

  /**
   * On remet la liste à zero en copiant tous les bateaux stockes initialement dans la liste de
   * bateaux filtres
   */
  resetList = () => {
    this.filteredBoats = this.availableBoats;
  };

  /**
   * On prend notre liste reference (tous les bateaux) et on va garder dans notre liste filtree
   * uniquement ceux dont le nom match sans jamais modifier la liste initiale
   * @param name
   */
  filterList = (name) => {
    this.filteredBoats = this.availableBoats.filter((boat) =>
      boat.Name.toLowerCase().includes(name.toLowerCase())
    );
  };

  /**
   * Handler qui nous permet de gerer le message qu'on a recu de l'un de nos enfants
   * @param event
   */
  handleNavigationToBoat(event) {
    // Evenement que l'enfant nous a envoye
    console.log(`Event received ${JSON.stringify(event, null, 2)}`);
    const boatId = event.detail.boatId;
    // Navigation vers ce qu'on veut voir
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: boatId,
        objectApiName: "Boat__c",
        actionName: "view"
      }
    });
  }
}
