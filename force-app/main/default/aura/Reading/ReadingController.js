
({
	doInit : function(component, event, helper) {
		helper.getLatest(component);
	},
	handleClick : function(component, event, helper) {
		helper.submit(component);
		helper.getLatest(component);
	}
})