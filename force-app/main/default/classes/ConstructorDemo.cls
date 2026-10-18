public class ConstructorDemo {
    public Integer num1;
    //No argument construtor
    public ConstructorDemo(){
        System.debug('I am inside the first constructor');
    }
	
    //Parameterised construtor
	public ConstructorDemo(String name)
    {
        System.debug('I am inside the second constructor');
    }
    
    public ConstructorDemo(Integer num)//constructor overloading
    {
        System.debug('I am inside the third constructor');
    }
    
     public ConstructorDemo(Integer num,String name)
    {
        System.debug('I am inside the fourth constructor');
    }
    
     public ConstructorDemo(String name, Integer num)
    {
        System.debug('I am inside the fifth constructor');
    }
}