({
    toggleModal : function(component, event, helper) {
        var eventName = event.getDef().$descriptor$.name;
        var type = '';
        if (eventName == 'selectOptionChanged') {
   			type = event.getParam("selectedOption");
            component.set("v.title", type);
        } else if (eventName == 'editRecord') {
            type = event.getParam("type");
            component.set("v.title", type);
        }
        helper.toggleModal(component);
    },
    hideModal : function(component, event, helper) {
        helper.hideModal(component);
        component.getEvent("hideModal").fire();
    }
})