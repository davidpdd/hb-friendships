import { LightningElement, api } from "lwc";

const TILE_WRAPPER_SELECTED_CLASS = "tile-wrapper selected";
const TILE_WRAPPER_UNSELECTED_CLASS = "tile-wrapper";

export default class BoatTile extends LightningElement {
  @api
  boat;
  @api
  selectedBoatId;

  // Getter to handle no contact name
  get contactName(){
    return this.boat && this.boat.Contact__r && this.boat.Contact__r.Name || 'no name'
  }

  // Getter to handle no boat type
  get boatType(){
    return this.boat && this.boat.BoatType__r && this.boat.BoatType__r.Name || 'no type'
  }

  // Getter for dynamically setting the background image for the picture
  get backgroundStyle() {
    return `background-image:url(${this.boat.Picture__c})`;
  }

  // Getter for dynamically setting the tile class based on whether the
  // current boat is selected
  get tileClass() {
    return this.boat.Id === this.selectedBoatId
      ? TILE_WRAPPER_SELECTED_CLASS
      : TILE_WRAPPER_UNSELECTED_CLASS;
  }

  // Fires event with the Id of the boat that has been selected.
  selectBoat() {
    const boatSelect = new CustomEvent("boatselect", {
      detail: { boatId: this.boat.Id }
    });
    this.dispatchEvent(boatSelect);
  }
}
