({
    render : function(component, helper) {
    	var ret = this.superRender();
        helper.getDdpGroups(component);
        return ret;
    },
    rerender : function(component, helper) {
        helper.updateDdpGroups(component);            
        setTimeout(function() {
            window.resize();
        }, 100);
    }
})