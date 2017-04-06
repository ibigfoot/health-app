/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestReadingCtrl {

    @isTest
    static void testInit() {

		Test.startTest();
        ReadingCtrl.ReadingWrapper rw = ReadingCtrl.init();
        Test.stopTest();
        
        System.assert(rw.bp != null);
        System.assert(rw.bp.systolic__c != null);
        System.assert(rw.bp.diastolic__c != null);
        System.assert(rw.bp.pulse__c != null);
        System.assert(rw.weight.weight__c != null);
    }
    
    static void testSave() {
    	
		BP_Reading__c bp = new BP_Reading__c(systolic__c = 110, diastolic__c = 65, pulse__c = 55);		
		Weight__c weight = new Weight__c(weight__c = 110);

		Test.startTest();
		ReadingCtrl.saveReading(bp, weight);
		Test.stopTest();
		
		ReadingCtrl.ReadingWrapper rw = ReadingCtrl.init();
        
        System.assert(rw.bp != null);
        System.assert(rw.bp.systolic__c == 110);
        System.assert(rw.bp.diastolic__c == 65);
        System.assert(rw.bp.pulse__c == 55);
        System.assert(rw.weight.weight__c == 110);
		
    }
    @testSetup
    static void createTestData() {
    		List<BP_Reading__c> readings = new List<BP_Reading__c>();
    		List<Weight__c> weights = new List<Weight__c>();
    		for(Integer i=0 ; i<20 ; i++) {
    			readings.add(new BP_Reading__c(systolic__c = 120+i, diastolic__c = 70+i, pulse__c = 60+i));		
    			weights.add(new Weight__c(weight__c = 100-i));
    		}
    		insert readings;
    		insert weights;
    		
    }
}