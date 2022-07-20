/*
    *Created By   :  Tapendra Singh Kalvi
    *Purpose      :  This Class will Display Country, states and districts starting with same alphabet and Logest Districts
                     and create Json Data for a pariticular country 
    Created Date  :  14/7/2022  
*/
public with sharing class CountriesAndDistrictsLevel2 {

    Map<string, Map<String, list<string>>> mapCountryStateDistricts = new Map<string, Map<String, list<string>>>();

    public CountriesAndDistrictsLevel2(string StartingKeyword){
        try{
        List<String> listOfCountryAndDistrict = new list<String>();
         //Query on district Object to find Same starting name character
        for(District__c d : [Select Name, state__r.Name, state__r.country__r.Name From district__c
                            Where (Name like : StartingKeyword AND state__r.Name like :StartingKeyword AND state__r.country__r.Name like : StartingKeyword)]){
                                listOfCountryAndDistrict.add(d.Name);
                                listOfCountryAndDistrict.add(d.state__r.Name);
                                listOfCountryAndDistrict.add(d.state__r.country__r.Name);
                            }
        system.debug('Country.State and District starts with a particular Keyword '+ listOfCountryAndDistrict);
        }
        catch(Exception e)
        {
            system.debug('No country starts with '+ StartingKeyword);
        }

        //find the Length of Districts which is greator or equal to a specific number
        list<string> listofDistrict = new list<string>();
        for(District__c d :[Select Name From District__c]){
            if(d.Name.length()>=5){
                listofDistrict.add(d.Name);
            }
        }
        system.debug('Districts----->' + listofDistrict);

        //Filling Map Dynamically
       list<state__c> listState =[SELECT Name,(SELECT name FROM Districts__r) FROM State__c];//parent to child query
        map<string,list<string>> stateAndDistrict =new map<string,list<string>>();
        for( state__c st:listState){
              list<string> ls =new list<string>();
            for(district__c dc :st.Districts__r){
                ls.add(dc.name);
            } 
            stateAndDistrict.put(st.name,ls);
          
        }
        list<country__c> listCountry =[SELECT Name, (SELECT Name FROM States__r) FROM country__c];
        for(country__c lc:listCountry){
           List<String> ls =New list<string>();
            map<string,list<string>> mp =new map<string,list<string>>();
            for(state__c st: lc.States__r ){
                mp.put(st.name,stateAndDistrict.get(st.name));
            }
             
             mapCountryStateDistricts.put(lc.name,mp);
        }
            system.debug(mapCountryStateDistricts);
        
    }

    Public List<Country> countryList{get; set;}
    public class States{
        Public List<Districts> districts{get; set;}
        public Integer total_Districts{get; set;}
        Public string stateName{get; set;}
    }
    public class Districts {
        Public String districtName{get; set;}
    }
    public class Country{
        public List<States> states{get; set;}
        public Integer total_Districts{get; set;}
        public Integer total_States{get; set;}
        public String countryName{get; set;}
    }
    
    //Method For Json Generator
    public  void CountryJSONGenerator(String CountryName){

        Country newCountry = New country();
        newCountry.CountryName = CountryName;
        newCountry.States = New list<states>();
        List<AggregateResult> listAggregateState = [Select Count(Name)total_States From State__c
                                                    Where Country__r.Name =: CountryName
                                                     Group By Country__r.Name];
        newCountry.total_States = (Integer)listAggregateState[0].get('total_States');
        List<AggregateResult> listAggregateDistrict = [Select COUNT(Name)total_Districts From District__c
                                                            Where State__r.Country__r.Name =: CountryName
                                                            Group By State__r.Country__r.Name];
        newCountry.total_Districts = (Integer)listAggregateDistrict[0].get('total_Districts');

        list<AggregateResult> listAggDistrictWithState = [Select Count(Name)total_Districts From District__c
                                                                    Where State__r.Country__r.Name =: CountryName
                                                                    Group By State__r.name];
        list<state__c> st= [Select Name  From State__c Where Country__r.Name =: CountryName ];                                                            
        for(String s : mapCountryStateDistricts.get(CountryName).keyset()){
            if(s == st[0].Name){
                states newState = New States();
                newState.stateName = s;
                newState.Districts = New List<districts>();
                
                newState.total_Districts = (Integer)listAggDistrictWithState[0].get('total_Districts');

                for(string Dist : mapCountryStateDistricts.get(countryName).get(s)){
                    districts newDistrict = new Districts();
                    newDistrict.districtName = Dist;

                    newState.districts.add(newDistrict);
                }

                NewCountry.states.add(newState);
            }
        }
        string jsonString = JSON.serialize(newCountry);
        system.debug(jsonString);
    }
    public void rollupDistrictAndStates(){

        //map to hold Districts 
        map<string, state__c> mapofStateDistrictstoUpdate = new Map<string, state__c>();
        map<Id, country__c> mapofCountryDistrictstoUpdate = new Map<Id, country__c>();
        
        //Get Aggregate result on Districts
        for(AggregateResult ar : [Select Count(Id) numberofDistrict, state__c From District__c Group By state__c])
        {
            mapofStateDistrictstoUpdate.put(string.valueOf(ar.get('state__c')), new State__c(
                Id = string.valueOf(ar.get('state__c')),Total_Districts__c = Integer.valueof(ar.get('numberofDistrict'))));
        }
        if(!mapofStateDistrictstoUpdate.isEmpty())
           update mapofStateDistrictstoUpdate.values();
        
        //Get Aggregate result on State
        for(AggregateResult ar : [Select Count(Id) numberOfStates, Country__c, Sum(Total_Districts__c) numberofDistrict
                                  From State__c Group By Country__c])
        {
            mapofCountryDistrictstoUpdate.put(string.valueOf(ar.get('Country__c')), new Country__c(
            Id = String.valueOf(ar.get('Country__c')),Total_Districts__c = integer.valueOf(ar.get('numberofDistrict')),
             Total_States__c = Integer.valueOf(Ar.get('numberOfStates'))));
        }
        if(!mapofCountryDistrictstoUpdate.isEmpty())
         update mapofCountryDistrictstoUpdate.values();
    }
}