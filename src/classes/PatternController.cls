/*
=>Description   :  Different types of star pattern
=>Created By    :  Tapendra Singh Kalvi
Created Date    :  21/6/2022
*/
public with sharing class PatternController {
/*
    ____*
    ___**
    __***
    _****
    *****
*/
public static void LeftAngleStarPattern(){
    integer n = 5;
for(integer i=1;i<=n;i++)
{
    string s='  ';
    for(integer j=n;j>=1;j--)
    {
        if(j<=i )
        {
            s = s + '*';
        }
        else
        {
                s = s + '_';
        }
    }
    
    system.debug(s);  
}
}
/*
*****
****
***
**
*
*/
public static void DownwardTriangleStarPattern(){
integer n = 5;
for(integer i=n;i>=1;i--)
{
    string s='  ';
    for(integer j=1;j<=i;j++)
    {
        s = s + '*';
    }
    
    system.debug(s);  
}
} 
/*
* * * * *
 * * * *
  * * *
   * *
    *
*/
public static void ReversedPyramidStarPattern(){
integer n = 5;
for(integer i=n;i>=1;i--)
{
    string s='  ';
    for(integer space = 0; space < n-i; space++)
        s = s + '_';
    for(integer j = i; j <= 2*i-1; j++)
        s = s + '*';
    
    for(integer j=0;j<i-1;j++)
    {
        s = s + '*';
    }
    system.debug(s);
}   
}  
/*
* 
* * 
* * * 
* * * * 
* * * * * 
* * * * 
* * * 
* * 
*
*/
public static void RightPascalsTriangle(){
integer n = 5;
for(integer i=1;i<=n;i++)
{
    string s='  ';
    for(integer j=1;j<=i;j++)
    {
        s = s + '*';
    }
    system.debug(s);  
}
for(integer i=n;i>=1;i--)
{
    string s='  ';
    for(integer j=1;j<=i;j++)
    {
        s = s + '*';
    }
    system.debug(s);   
}  
}  
/*
* * * * * 
 * * * * 
  * * * 
   * * 
    * 
    * 
   * * 
  * * * 
 * * * * 
* * * * *
*/
public static void SandglassStarPattern(){
    integer n = 5;
    for(integer i=n;i>=1;i--)
    {
        string s='  ';
        for(integer j=1; j<=n-i; j++)
        {
            s = s + '_';
        }
        for(integer j=1; j<=2*i-1;j++)
        {
            s = s + 'X';
        }
        system.debug(s);
    }
    for(integer i=1; i<=n; i++)
    {
        string s='  ';
        for(integer j=1; j<=n-i; j++)
        {
            s = s + '_';
        }
        for(integer j=1; j<=2*i-1;j++)
        {
            s = s + 'X';
        }
        system.debug(s);
    }
}
/*
    *
   **
  ***
 ****
*****
 ****
  ***
   **
    *
*/
public static void LeftTrianglePascals(){
integer k=6;
for(integer i=1;i<=9;i++)
{
if(i<=5){k--;} else{k++;}
string s='  ';
for(integer j=1;j<=5;j++)
{
    if(j>=k)
    {
        s = s + 'x';
    }
    else
    {
            s = s + '_';
    }
}
system.debug(s); 
}
}
/*
 * 
* *
***
* *
* *
* *
*/
public static void AlphabetAPattern(){
integer k=2,t=2;
boolean m = true;
for(integer i=1;i<=6;i++)
    {
        string s='  ';
        if(i==2){k--; t++;}
        for(integer j=1;j<=3;j++)
        {
            if((i==2||i>=4) && j==2){m=false;}else{m=true;}
            if(j>=k && j<=t && m )
            {
                s = s + 'x';  
            }
            else
            {
                    s = s + '_';
            }
        }
        system.debug(s);    
    }
}
/*
    * 
   * * 
  * * * 
 * * * * 
* * * * *
*/
public static void PyramidPattern(){
for(integer i=0;i<=4;i++)
{
    string s = '  ';
    for(integer j=0;j<=8;j++)
    {
        if(j>=4-i && j<=4+i )
        {
            s = s + 'x';
        }
        else
        {
                s = s + '_';
        }
    }
    system.debug(s);
}
}
/*
    *
   * *
  *   *
 *     *
*********
*/
public static void TriangleStarpattern(){
boolean b=true;
for(integer i=1;i<=5;i++)
{
    string s='  ';
    for(integer j=1;j<=9;j++)
    {
        if(i>=2 && i<=4){if(j>=7-i && j<=3+i){b=false;}else{b=true;}}else{b=true;}
        
        if(j>=6-i && j<=4+i && b )
        {
            s = s + 'x';   
        }
        else
        {
                s = s + '_';       
        }
    }
    system.debug(s);
    }
}
/*
*********
 *     *
  *   *
   * *
    *
*/
public static void Downtriangle(){
boolean b=true;
for(integer i=1;i<=5;i++)
{
    string s='  ';
    for(integer j=1;j<=9;j++)
    {
        if(i>=2 && i<=4){if(j>=1+i && j<=9-i){b=false;}else{b=true;}}else{b=true;}
        
        if(j>=i && j<=10-i && b)
        {
            s = s + 'x';
        }
        else
        {
                s = s + '_';       
        }
    }
    system.debug(s);
    }
}
}