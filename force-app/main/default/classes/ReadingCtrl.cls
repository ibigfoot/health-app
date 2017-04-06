public with sharing class ReadingCtrl {
	
	@AuraEnabled
	public static ReadingWrapper init() {
		
		try {
			ReadingWrapper w = new ReadingWrapper();
			w.bp = [select id, systolic__c, diastolic__c, pulse__c, createddate from bp_reading__c order by createddate desc limit 1];
			w.weight = [select id, weight__c, createddate from Weight__c order by createddate desc limit 1];
			return w;
		} catch (QueryException qe) {
			System.debug(LoggingLevel.INFO, 'Found no records');	
		}
		return null;
	}
	
	@AuraEnabled
	public static void saveReading(BP_Reading__c bp, Weight__c weight) {
		try {
			System.debug(LoggingLevel.INFO, 'We have a return of something BP ['+bp+'] Weight ['+weight+']');
			insert bp;
			insert weight;	
		} catch (Exception e) {
			System.debug(LoggingLevel.ERROR, 'What happened? - '+e.getMessage());
		}
	}
	
	public class ReadingWrapper {
		@AuraEnabled
		public BP_Reading__c bp {get; set;}
		@AuraEnabled
		public Weight__c weight {get; set;}
		
		public ReadingWrapper() {}
		
		public ReadingWrapper(BP_Reading__c bp, Weight__c weight ) {
			this.bp = bp;
			this.weight = weight;
		}	
	}
}
