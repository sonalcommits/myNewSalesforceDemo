import { LightningElement } from 'lwc';

export default class ChildComponentForDemo extends LightningElement {
    handleSubstract()
{
    const substractCustomeEvent = new CustomEvent('substract')//CustomEvent -  out of box class of LWC
    this.dispatchEvent(substractCustomeEvent);
}

handleAdd()
{
    this.dispatchEvent(new CustomEvent('add'));
}

handleMultiply(event)
{
console.log('AS value '+ event.target.value);
const valueForMultiply = event.target.value;
console.log('AS value '+valueForMultiply);
 this.dispatchEvent(new CustomEvent('multiply', {detail : valueForMultiply}));  //detail is key and it remains always same
}
}