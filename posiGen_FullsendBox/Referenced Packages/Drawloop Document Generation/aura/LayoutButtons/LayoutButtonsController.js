({
	filterObjects : function(component, event, helper) {
        var params = event.getParams();
        component.set("v.searchText", params.searchText || '');
	},
    save : function(component) {
        component.find("layoutButtonTable").save();
    }
})