import {LightningElement, wire} from 'lwc'
import getAvailableBoats from "@salesforce/apex/BoatSearchController.getAvailableBoats"

export default class BoatSearchByName extends LightningElement {

  availableBoats = []

  @wire(getAvailableBoats)
  wiredBoats({data, error}){
    if(data){
      this.availableBoats = data;
      console.log(` ${JSON.stringify(this.availableBoats, null, 2)}`) // TODO: delete
    } else {
      console.error(error);
    }
  }

}