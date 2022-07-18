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
        List<String> ListOfCountryAndDistrict = new list<String>();
        for(District__c d : [Select Name, State__r.Name, State__r.Country__r.Name from District__c
                            where (Name like : StartingKeyword AND state__r.Name like :StartingKeyword And state__r.country__r.Name like : StartingKeyword)]){
                                ListOfCountryAndDistrict.add(d.Name);
                                ListOfCountryAndDistrict.add(d.state__r.Name);
                                ListOfCountryAndDistrict.add(d.state__r.country__r.Name);
                            }
        system.debug('Country.State and District starts with a particular Keyword '+ ListOfCountryAndDistrict);
        }
        catch(Exception e)
        {
            system.debug('No country starts with '+ StartingKeyword);
        }

        //find the Length of Districts which is greator or equal to a specific number
        list<string> ListofDistrict = new list<string>();
        for(District__c d :[select Name From District__c]){
            if(d.Name.length()>=5){
                ListofDistrict.add(d.Name);
            }
        }
        system.debug('Districts----->' + ListofDistrict);

        //Filling Map Dynamically
       list<state__c> listState =[SELECT Name,(SELECT name FROM Districts__r) FROM State__c];
        map<string,list<string>> StateAndDistrict =new map<string,list<string>>();
        for( state__c st:listState){
              list<string> ls =new list<string>();
            for(district__c dc :st.Districts__r){
                ls.add(dc.name);
            } 
            StateAndDistrict.put(st.name,ls);
          
        }
        list<country__c> listCountry =[SELECT Name, (SELECT Name FROM States__r) FROM country__c];
        for(country__c lc:listCountry){
           List<String> ls =New list<string>();
            map<string,list<string>> mp =new map<string,list<string>>();
            for(state__c st: lc.States__r ){
                mp.put(st.name,StateAndDistrict.get(st.name));
            }
             
             mapCountryStateDistricts.put(lc.name,mp);
        }
            system.debug(mapCountryStateDistricts);
        
    }

    Public List<Country> countryList{get; set;}
    public class States{
        Public List<Districts> districts{get; set;}
        public Integer Total_Districts{get; set;}
        Public string stateName{get; set;}
    }
    public class Districts {
        Public String districtName{get; set;}
    }
    public class Country{
        public List<States> states{get; set;}
        public Integer Total_Districts{get; set;}
        public Integer Total_States{get; set;}
        public String countryName{get; set;}
    }
    
    //Method For Json Generator
    public  void CountryJSONGenerator(String CountryName){

        Country NewCountry = New country();
        NewCountry.CountryName = CountryName;
        NewCountry.States = New list<states>();
        List<AggregateResult> ListAggregateState = [Select Count(Name)Total_States from State__c
                                                    where Country__r.Name =: CountryName
                                                     Group By Country__r.Name];
        NewCountry.Total_States = (Integer)ListAggregateState[0].get('Total_States');
        List<AggregateResult> listAggregateDistrict = [Select COUNT(Name)Total_Districts from District__c
                                                            where State__r.Country__r.Name =: CountryName
                                                            Group By State__r.Country__r.Name];
        NewCountry.Total_Districts = (Integer)listAggregateDistrict[0].get('Total_Districts');

        for(String s : mapCountryStateDistricts.get(CountryName).keyset()){
            if(s == 'California'){
                states NewState = New States();
                NewState.stateName = s;
                NewState.Districts = New List<districts>();
                list<AggregateResult> listAggDistrictWithState = [Select Count(Name)Total_Districts from District__c
                                                                    where State__r.Country__r.Name =: CountryName
                                                                    Group By State__r.name];
                NewState.Total_Districts = (Integer)listAggDistrictWithState[0].get('Total_Districts');

                for(string Dist : mapCountryStateDistricts.get(countryName).get(s)){
                    districts newDistrict = new Districts();
                    newDistrict.districtName = Dist;

                    NewState.districts.add(newDistrict);
                }

                NewCountry.states.add(NewState);
            }
        }
        string jsonString = JSON.serialize(NewCountry);
        system.debug(jsonString);
    }
    public void rollupDistrictAndStates(){

        //map to hold Districts 
        map<string, state__c> mapofStateDistrictstoUpdate = new Map<string, state__c>();
        map<Id, country__c> mapofCountryDistrictstoUpdate = new Map<Id, country__c>();
        
        //Get Aggregate result on Districts
        for(AggregateResult Ar : [Select Count(Id) numberofDistrict, state__c From District__c Group By state__c])
        {
            mapofStateDistrictstoUpdate.put(string.valueOf(Ar.get('state__c')), new State__c(
                Id = string.valueOf(Ar.get('state__c')),Total_Districts__c = Integer.valueof(Ar.get('numberofDistrict'))));
        }
        if(!mapofStateDistrictstoUpdate.isEmpty())
           update mapofStateDistrictstoUpdate.values();
        
        //Get Aggregate result on State
        for(AggregateResult Ar : [Select Count(Id) numberOfStates, Country__c, Sum(Total_Districts__c) numberofDistrict
                                  From State__c Group By Country__c])
        {
            mapofCountryDistrictstoUpdate.put(string.valueOf(Ar.get('Country__c')), new Country__c(
            Id = String.valueOf(Ar.get('Country__c')),Total_Districts__c = integer.valueOf(Ar.get('numberofDistrict')),
             Total_States__c = Integer.valueOf(Ar.get('numberOfStates'))));
        }
        if(!mapofCountryDistrictstoUpdate.isEmpty())
         update mapofCountryDistrictstoUpdate.values();
    }
}