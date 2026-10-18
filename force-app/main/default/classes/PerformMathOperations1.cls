global virtual class PerformMathOperations1  {
    protected Integer num1=60;//class/Instance variable
    public Integer num2=20;
    global void performAdditionOfInteger()
    {
        Integer result=num1+num2;
        System.debug('The result of Addition is => '+result);  
    }
     public void performSubtractionOfInteger()
    {
        Integer result=num1-num2;
        System.debug('The result of Addition is => '+result);  
    }
     public void performMultiplicationOfInteger()
    {
        Integer result=num1*num2;
        System.debug('The result of Addition is => '+result);  
    }
     public void performDivisionOfInteger()
    {
        Decimal result=num1/num2;
        System.debug('The result of Addition is => '+result);  
    }
	
    public void performArithmaticOpps()      
    {
        performAdditionOfInteger();
        performSubtractionOfInteger();
        performMultiplicationOfInteger();
        performDivisionOfInteger();
    }
}