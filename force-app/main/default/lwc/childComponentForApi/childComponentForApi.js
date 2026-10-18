import { LightningElement, api} from 'lwc';

export default class ChildComponentForApi extends LightningElement {

    @api itemName = 'Velocity Institute';
    @api handleCallFromParent(){
        this.itemName = 'Method Invoked From Parent Component';
    }

}