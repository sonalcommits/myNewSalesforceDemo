import { LightningElement } from 'lwc';

export default class ConditionalRenderingDemo extends LightningElement {
    buttonLabel = 'Button 1';
    property1 = true;
    property2 = false;
    property3 = false;

    handleClick(){
        if(this.property1 === true){
            this.property1 = false;
            this.buttonLabel = 'Button 2';
            this.property2 = true;
        }
        else if(this.property2 === true){
            this.property2 = false;
            this.buttonLabel = 'Button 3';
            this.property3 = true;
        }
        else if(this.property3 === true){
            this.property3 = false;
            this.buttonLabel = 'Button 1';
            this.property1 = true;
        }
    }
}