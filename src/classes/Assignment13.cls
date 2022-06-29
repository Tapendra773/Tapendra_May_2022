public with sharing class Assignment13 {
public Assignment13() {
//Conditinal If- Else Example 1
    integer num=10;
    if(num>0)
    {
        System.debug('Number is positive');
    }
    else if(num<0)
    {
        System.debug('Number is negative');
    }
    else
    {
        System.debug('Number is Zero');
    }
}
//Conditinal If- Else Example 2
public static void IfElse(){

    integer place=1;
    String medal_color;
    if(place ==1)
    {
    medal_color='gold';
    }   
    else if (place==2)
    {
    medal_color='silver';   
    }
    else if(place==3)
    {
    medal_color='bronze';
    }
    else
    {
    medal_color='null';
    }
    System.debug('You have scored '+medal_color + 'Medal. Congratulations');
}
//Example of while Loop
public static void whileLoop(){
    integer i=1;
    while(i<=10)
    {
    System.debug('value of i= '+i);
    i++;
    }
}
//Example of Tradional For Loop
public static void tradionalforLoop(){
for(integer i=1;i<=5;i++)
{
    System.debug('value of i= '+i);
}
}
//Example of Tradional For Loop
public static void tradionalforLoop2(){
integer salary=150000;
Decimal bonus,salary_after_bonus;
for(bonus=10;bonus<=25;bonus+=5)
{
    salary_after_bonus=salary+(salary*(bonus/100));
    System.debug('Salary after '+bonus+ '% bonus '+salary_after_bonus);
}
}
//Example of List or set iteration For Loop
public static void ForLoop(){
List<String> stuNames=new List<String>{'John', 'Sam', 'Barak'};
    for(String stuName:stuNames)
{
    System.debug('name= '+stuName);
}
}
//Example 2 of List or set iteration For Loop 
public static void ForLoop2(){
List<Integer> empIds=new List<Integer>{1200,96000,85274,74523,87523};
    for(Integer empId:empIds)
{
    System.debug('empId= '+empId);
}
}
}
