/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Jonathan Lyles
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads () {
        return  [SELECT Id, LastName, Company, Phone, Email FROM Lead];
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getAllContactsWithParamFirstName (String firstName) {
    //  The body of the method
    return [SELECT Id, Name FROM Contact WHERE FirstName = :firstName];
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName (List<String> lastNames) {
        List<Id> idList = new List<Id>();
        for(Contact con : [SELECT Id FROM CONTACT WHERE LastName IN :lastNames]){
            idList.add(con.Id);
        }
        return idList;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunityCountByAccount (Id accountId) {
    //  The body of the method
        return [SELECT Name, Amount, StageName, AccountId, CloseDate FROM Opportunity WHERE AccountId = :accountId AND StageName = 'Closed Won'];
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount() {
    //  The body of the method
        List<AggregateResult> results = [ SELECT COUNT(Id) total FROM Account];
    Return (Integer) results[0].get('total');
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTasksDueNextWeek () {
        Map<Id,Task> result = new Map<Id, Task>();
    //  The body of the method
    Date lessThanSevenDaysFromNow = Date.today().addDays(7);
    List<Task> getTasks = [SELECT Id FROM Task WHERE ActivityDate <= :lessThanSevenDaysFromNow];
    for(Task getTask : getTasks){
        result.put(getTask.Id,getTask);
    }
    System.debug(result);
    return result;
    
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain () {
    //  The body of the method
        return [SELECT Name, Email FROM Contact WHERE Email LIKE '%example.com'];  
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String param = '%' + keyword + '%';
        return [SELECT Name FROM Opportunity WHERE Name LIKE :param];  
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        return [SELECT Id, Origin FROM Case WHERE Origin NOT IN ('Web','Email','') ]; // Replace null with the variable you used to store the result
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle (String leadSource, String keyword) {
    //  The body of the method
        String keywordParam = '%' + keyword + '%';
        return [SELECT Phone, Email, LastName, Title, Company FROM Lead WHERE (Title LIKE :keywordParam OR LeadSource = :leadSource)];
         
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> contactLastNames = new List<String>();

        // Query the Contacts
        // Loop through each Contact and add the LastName to the list
        for (Contact con : [SELECT LastName, Id FROM Contact WHERE AccountId = :accountId]) {
            contactLastNames.add(con.LastName);
        }

        // Return the list of Contact LastNames
        return contactLastNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        List<AggregateResult> totalRevenue = [SELECT SUM(Amount) total FROM Opportunity WHERE StageName = 'Closed Won' OR Amount > 10000];
        // Return the total revenue
        // Replace null with the variable you used to store the result
        return  (Decimal) totalRevenue[0].get('total');
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        return [SELECT Name FROM Account ORDER BY Name LIMIT 10]; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        return [SELECT Id, CloseDate, Amount FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5]; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        return [SELECT Id, Name, BirthDate FROM Contact ORDER BY BirthDate DESC LIMIT 3]; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        return [SELECT Id, CreatedDate, Status, Subject FROM Case WHERE Status = 'Open' ORDER BY CreatedDate  LIMIT 10 OFFSET 5]; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseIds = new Set<Id>();

        // Query the Cases
        // Loop through each Case and add the Id to the set
        for (Case cas : [SELECT Id FROM Case WHERE AccountId = :accountId]) {
            caseIds.add(cas.Id);
        }

        return caseIds; // Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        // Loop through each Account and add the Id and Name to the map
        for(Account acc : [SELECT BillingCountry, Id, Name FROM Account WHERE BillingCountry != :country]){
            accountIdsToNames.put(acc.Id,acc.Name);
        }
        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact con = [SELECT Account.Name FROM Contact WHERE Id = :contactId LIMIT 1];
        return con.Account.Name;
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        return [SELECT Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId]; 
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        Account acc = [SELECT BillingState FROM Account WHERE Id = :accountId];
        // Store the Account's BillingState
        String accBillingState = acc.BillingState;

        // Query the Contacts
        return [SELECT Id FROM Contact WHERE MailingState = :accBillingState];
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List<Lead> passedLeads = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];

        // Create a set of email domains from the Leads
        Set<String> domains = new Set<String>();
         // Loop through each Lead
         System.debug('All passed Leads' + passedLeads);
        for(Lead passedLead : passedLeads){
            // Get the email from the Lead
            // Check if the email is not null
            if(passedLead.Email != null){
                Integer atPosition = passedLead.Email.indexOf('@') + 1;
                String emailDomain = 'www.' + passedLead.Email.substring(atPosition);
                // Add the email domain to the set
                domains.add(emailDomain);
            }  
        }
        // Query the Accounts
        return [SELECT Id, Website FROM Account WHERE Website IN :domains]; // Replace null with the variable you used to store the result
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> origOppLineItems = [SELECT Id, Quantity, UnitPrice, PricebookEntryId FROM OpportunityLineItem WHERE OpportunityId = :origOppid];
       
        // Create a list to hold the new line items
        List<OpportunityLineItem> clonedOppLineItems = new List<OpportunityLineItem>();

        // Generate a random number between 1 and 3
        Integer randomNumber = Math.round(1 + Math.random()*3);
        
        // Loop through each cloned Opportunity Id
        for(Id cloneOppId : cloneOppIds){
            
            // Loop through each original line item
            for(OpportunityLineItem origOppLineItem : origOppLineItems){

                // Clone the original line item and add the random number to the quantity
                OpportunityLineItem cloneLineItem = new OpportunityLineItem();
                cloneLineItem.Quantity = origOppLineItem.Quantity + randomNumber;
                cloneLineItem.UnitPrice = origOppLineItem.UnitPrice;
                cloneLineItem.OpportunityId = cloneOppId;
                cloneLineItem.PricebookEntryId = origOppLineItem.PricebookEntryId;
                //Add to the list
                clonedOppLineItems.add(cloneLineItem);
            }
        }
        // Insert the new line items
        insert clonedOppLineItems;
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
        return [SELECT Name, AccountId, OwnerId FROM Opportunity WHERE StageName = 'Closed Won']; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> oppList = SOQL.getOpportunityDetailsForClosedWon();

        // Create a set of Account Ids from the Opportunities
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp : oppList){
            accIds.add(opp.AccountId);
        }

        Map<Id,Id> accountToContactMap = new Map<Id,Id>();
        // Query the Contacts
        List<Contact> conList = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accIds];

        // Loop through each Contact and add the Account Id and Contact to the map
        for(Contact con : conList){
            accountToContactMap.put(con.AccountId,con.Id);
        }
        
        // Loop through each Opportunity
        for(Opportunity opp : oppList){
            // Update the Opportunity primary contact from accountToContactMap
            opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId);
        }

       

        // Update the Opportunities
        update oppList;
    }
}