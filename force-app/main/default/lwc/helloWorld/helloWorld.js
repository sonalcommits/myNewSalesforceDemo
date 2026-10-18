import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    connectedCallback(){
        var isData = true;
        if(isData == true)
        {
            const name = 'Velocity Insitute'; 
             window.alert('Name is => '+ name);
            
        }
   
}}