({
    render : function(component, helper) {
    	var ret = this.superRender();
        helper.getObjectGroups(component);
        helper.getAvailableCustomObjects(component);
        return ret;
    },
    rerender : function(component, helper) {
        helper.updateObjectGroups(component);
    }
})