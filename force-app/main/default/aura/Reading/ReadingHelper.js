({
	getLatest : function(cmp) {
		var action = cmp.get("c.init");
		action.setCallback(this, function(response) {
			var state = response.getState();
			if(cmp.isValid() && state === "SUCCESS") {
				console.log(JSON.stringify(response.getReturnValue()));
				cmp.set("v.data", response.getReturnValue());
			} else {
				console.log(JSON.stringify(response));
			}
		});
		$A.enqueueAction(action);
	},
	submit : function(cmp) {

		var action = cmp.get("c.saveReading");
		var bp = {
			'sobjectType':'BP_Reading__c',
			'Systolic__c': cmp.find("systolic").get("v.value"),
			'Diastolic__c': cmp.find("diastolic").get("v.value"),
			'Pulse__c': cmp.find("pulse").get("v.value"),
			'Notes__c': cmp.find("notes").get("v.value")
		}
		var w = {
			'sobjectType':'Weight__c',
			'Weight__c':cmp.find("weight").get("v.value")
		}

		action.setParams({
			"bp" : bp,
			"weight" : w
		});
		
		action.setCallback(this, function(response) {
			var state = response.getState();
			var toastEvt = $A.get("e.force:showToast");
			if (cmp.isValid() && state === "SUCCESS") {
				
				toastEvt.setParams({
					"title" : "Success",
					"message" : "You have saved your reading..."
				});
				cmp.find("systolic").set("v.value", null);
				cmp.find("diastolic").set("v.value", null);
				cmp.find("pulse").set("v.value", null);
				cmp.find("weight").set("v.value", null);
			} else {
				toastEvt.setParams({
					"title" : "Error",
					"message" : "There has been an error trying to save your reading: "+JSON.stringify(response)
				});
			}
			toastEvt.fire();
		});
		$A.enqueueAction(action);
	}
})