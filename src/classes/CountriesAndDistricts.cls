/*
    *Created By   :  Tapendra Singh Kalvi
    *Purpose      :  This Method will Display Country, states and districts starting with same alphabet and Logest Districts
    Created Date  :  4/7/2022  
*/

public with sharing class CountriesAndDistricts {

public static void CountriesAndDistricts(string startingCharacter,integer longestsize){
Map<Integer , Map<string , Map<string,List<string>>>> CountryCode ;
//Assigning map of States according to country

list<string> districtrajasthan = new list<string>{'jaipur','udaipur','naugor'};
list<string> districtnicaragua = new list<string>{'new ','old'};
list<string> districtDhaka = new list<string>{'luffy ','Zoro'};
list<string> districtpunjab = new list<string>{'Mahismati ','Chandigarh'};


map<string,list<string>> mapindia = new map<string,list<string>>{'rajasthan'=>districtrajasthan};

map<string,list<string>> mapnicaragua = new map<string,list<string>>{'newnicaragua'=>districtnicaragua };

map<string,list<string>> mapbangladesh = new map<string,list<string>>{'Dhaka'=>districtDhaka };

map<string,list<string>> mapcanada = new map<string,list<string>>{'punjab'=>districtpunjab};


map<string,map<string,list<string>>>mapasia=new map<string,map<string,list<string>>>{'india'=>mapindia, 'bangladesh'=>mapbangladesh};

map<string,map<string,list<string>>>mapnorthamerica=new map<string,map<string,list<string>>>{'nicaragua'=>mapnicaragua, 'canada'=>mapcanada};

CountryCode = new Map<Integer , Map<string , Map<string,List<string>>>>{101=>mapasia,102=>mapnorthamerica };

//This Method will Display Country, states and districts starting with same alphabet

set<integer> setkeys = CountryCode.keyset();

//To get Continent Code
for(integer keycountry:CountryCode.keyset())
{
    //To get Continent Map
    map<string , map<string,list<string>>> mapcontinent = CountryCode.get(keycountry);
        //Iterating Country name keys from Map
        for(string keycountryname : mapcontinent.keyset())
        {
            if(keycountryname.startswithIgnoreCase(startingCharacter)){
            map<string, list<string>> mapcountry = mapcontinent.get(keycountryname);
                //Iterating State Name Keys from Map
                for(string keyState : mapcountry.keyset()){
                    //checking State Nmae Starts from
                    if(keyState.startswithIgnoreCase(startingCharacter)){
                    //To get District list
                    list<string> ListDistricts = mapcountry.get(keyState);

                    //Iterating Districts Name from Lists
                    for(string districtName : ListDistricts){
                        //checking Districts Nmae Starts from
                        if(districtName.startswithIgnoreCase(startingCharacter)){
                        system.debug('Country  : ' + keycountryname +', State : '+ keyState +', Districts : ' + districtName);
                           }
                   }
            }
        }
    }
}

//This method will display the longest districts names.

list<string> alldistricts = new list<string>();
for (integer keyCountryCode : CountryCode.keyset()){
map<string,map<string,list<string>>> mapcontinent1 = CountryCode.get(keyCountryCode);

for(string CountryName:mapcontinent1.keyset()){
    map<string, list<string>> mapcountry = mapcontinent1.get(CountryName);
        for(string keyState:mapcountry.keyset()){
            list<string>ListDistricts = mapcountry.get(keyState);
            alldistricts.addALL(ListDistricts);
}
}
}
system.debug('district with greater lenght than ' + longestsize);
for( string district : alldistricts)
    {
    if(district.length()>longestsize){
        system.debug(district);
    }
}
}
}








//  public void findwith(string startingCharacter) {
//     set<integer> setkeys = CountryCode.keyset();

//     integer flag = 0;

//     for(integer keycountry:CountryCode.keyset())
//     {
//   map<string , map<string,list<string>>> mapcontinent = CountryCode.get(keycountry);

//   for(string keycountryname : mapcontinent.keyset())
//   {
//     if(keycountryname.startswithIgnoreCase(startingCharacter)){
//     map<string, list<string>> mapcountry = mapcontinent.get(keycountryname);

//     for(string keyState : mapcountry.keyset()){

//         if(keyState.startswithIgnoreCase(startingCharacter)){

//             list<string> ListDistricts = mapcountry.get(keyState);

//             for(string districtName : ListDistricts){

//                 if(districtName.startswithIgnoreCase(startingCharacter)){
//                     system.debug('Country  : ' + keycountryname +', State : '+ keyState +', Districts : ' + districtName);

//                 }
//             }
//         }
//     }
//     }
//   }
// }

//                }



}       

