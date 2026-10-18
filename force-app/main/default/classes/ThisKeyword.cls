public class ThisKeyword {
    public Integer num1;
    
    public ThisKeyword()
    {
        this(22);// method chaining - calling one constructor from another constructor inside same class.(only this line added in methode chaining)
        System.debug('I am inside the first constructor ');
    }
	
    public ThisKeyword(Integer num1)
    {
        this.num1=num1; //shadowing/name flashing
        System.debug('This value '+ this);
        System.debug('Num1 parameter '+ num1);
    }
}