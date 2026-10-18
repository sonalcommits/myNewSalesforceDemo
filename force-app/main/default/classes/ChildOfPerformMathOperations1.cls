public class ChildOfPerformMathOperations1 extends PerformMathOperations1 {
    public void printNum()
    {
        System.debug('The value of num is => '+num1);
        PerformMathOperations1 performMathOperations1=new PerformMathOperations1();
        System.debug(performMathOperations1.num2);
    }

}