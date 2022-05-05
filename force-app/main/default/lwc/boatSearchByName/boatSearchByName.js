import { LightningElement, wire } from "lwc";
import getAvailableBoats from "@salesforce/apex/BoatSearchController.getAvailableBoats";

export default class BoatSearchByName extends LightningElement {
  availableBoats = [];
  filteredBoats = [];

  @wire(getAvailableBoats)
  wiredBoats({ data, error }) {
    if (data) {
      this.availableBoats = data;
      this.filteredBoats = this.availableBoats;
      console.table(data);
      console.log(` ${JSON.stringify(this.availableBoats, null, 2)}`); // TODO: delete
    } else {
      console.error(error);
    }
  }

  handleSearch(event) {
    const name = event.detail.value;
    if (name === "") {
      this.filteredBoats = this.availableBoats;
    } else {
      this.filteredBoats = this.availableBoats.filter((boat) =>
        boat.Name.toLowerCase().includes(name.toLowerCase())
      );
    }
  }
}
