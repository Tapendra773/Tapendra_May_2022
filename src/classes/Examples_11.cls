public with sharing class Examples_11 {
public Examples_11() {
    
Date myDate = Date.newInstance(1960, 2, 17);
Date newDate = mydate.addDays(2);


// Cast the object to an integer.
Object obj = 10;
Integer i = (Integer)obj;
System.assertEquals(10, i);
System.debug(i);

//datetime
Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
Datetime newDateTime = myDateTime.addDays(2);
Datetime expected = Datetime.newInstance(1960, 2, 19);
System.assertEquals(expected, newDateTime);
System.debug(expected);

//string class
String s = 'Hello Maximillian';
String s2 = s.abbreviate(8);
System.assertEquals('Hello...', s2);
System.assertEquals(8, s2.length());
system.debug(s2);

//Collections
public static void main(){
    string s1='hello string';
    string s2='bye string';
    list<string> ls=new list<string>{s1};
        ls.add(s2);
        ls.add(s1);
    set<string> ss=new set<string>();
    ss.addAll(ls);
    ss.add(s1);
    system.debug(ss);
    system.debug(ls);
    map<string,string> nmap=new map<string,string>{s1 => 'hello',s2 =>'bye'};
        nmap.put('s3','wapis hello');
    system.debug(nmap);
    map<string,List<String>> strMap = new Map <string,List<String>>();
    strMap.put(s1,ls);
    system.debug(strmap);
    map<string,map<string,string>> M1=new map<string,map<string,string>>();
    M1.put(s1,nmap);
    system.debug(M1);
    Map<String,Map<String,List<String>>> ML=new map<String,Map<String,List<String>>>();
    ML.put('hi',new map<string,List<String>>{s1=>ls});
    system.debug(ML);
    map<string,map<string,map<string,string>>> m2=new map<string,map<string,map<string,string>>>();
    m2.put(s1,M1);
    system.debug(m2);
    Map<String,List<String>> mlget= ml.get('hi');
    system.debug('mlget>>>>>>>>>>>>>>>>>>'+mlget);
    system.debug(mlget.get('hello string'));
    
}
}
}
}
