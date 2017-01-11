({
	filterDdps : function(component, event, helper) {
        var params = event.getParams();
        component.set("v.searchText", params.searchText || '');
        component.set("v.businessUser", params.businessUser);
	},
    save : function(component, event, handler) {
        component.find('sampleDdpTable').save();
    }
})