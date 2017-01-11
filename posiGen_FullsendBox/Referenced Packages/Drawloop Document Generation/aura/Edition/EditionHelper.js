({
    toggleServiceLevel : function(component, event) {
        var isStandard = component.get("v.isStandard");
        if (isStandard) {
            component.set("v.isStandard", false);
            
        	component.find("standardScheduledDdp").getElement().checked = false;
        	component.find("standardScheduledDdp").getElement().disabled = true;
            
            $A.util.removeClass(component.find("enableStandardButton"), "slds-button--brand");
            $A.util.addClass(component.find("enableStandardButton"), "slds-button--neutral");
            $A.util.addClass(component.find("standardButtonSvg"), "hidden");
            component.find("standardButtonText").getElement().innerHTML = "Enable Standard";
            
            component.find("businessScheduledDdp").getElement().disabled = false;
            component.find("workflowDdp").getElement().disabled = false;
            component.find("componentLibrary").getElement().disabled = false;
            component.find("massDdp").getElement().disabled = false;
            
            $A.util.removeClass(component.find("enableFancyButton"), "slds-button--neutral");
            $A.util.addClass(component.find("enableFancyButton"), "slds-button--brand");
            $A.util.removeClass(component.find("fancyButtonSvg"), "hidden");
            component.find("fancyButtonText").getElement().innerHTML = "Business Enabled";
        }
        else {
            component.set("v.isStandard", true);
            
        	component.find("standardScheduledDdp").getElement().disabled = false;
            
            $A.util.removeClass(component.find("enableStandardButton"), "slds-button--neutral");
            $A.util.addClass(component.find("enableStandardButton"), "slds-button--brand");
            $A.util.removeClass(component.find("standardButtonSvg"), "hidden");
            component.find("standardButtonText").getElement().innerHTML = "Standard Enabled";
            
            component.find("businessScheduledDdp").getElement().checked = false;
            component.find("businessScheduledDdp").getElement().disabled = true;
            component.find("workflowDdp").getElement().checked = false;
            component.find("workflowDdp").getElement().disabled = true;
            component.find("componentLibrary").getElement().checked = false;
            component.find("componentLibrary").getElement().disabled = true;
            component.find("massDdp").getElement().checked = false;
            component.find("massDdp").getElement().disabled = true;
            
            $A.util.removeClass(component.find("enableFancyButton"), "slds-button--brand");
            $A.util.addClass(component.find("enableFancyButton"), "slds-button--neutral");
            $A.util.addClass(component.find("fancyButtonSvg"), "hidden");
            component.find("fancyButtonText").getElement().innerHTML = "Enable Business";
        }
    },
    
    parseQueryString : function(qstr) {
        var query = {};
        qstr = qstr[0] == '?' ? qstr.substr(1) : qstr
        var a = qstr.split('&');
        for (var i = 0; i < a.length; i++) {
            var b = a[i].split('=');
            query[decodeURIComponent(b[0])] = decodeURIComponent(b[1] || '');
        }
        return query;
    },
    loadEditionData : function(component, sessionId, location) {
        if (location) {
            var action = component.get("c.fetchServices");
            action.setParams({
                sessionId: sessionId,
                location : location
            });  
        } else {
            var action = component.get("c.initFetchServices");
            action.setParams({
                sessionId: sessionId
            });  
        }
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var parsedResponse = JSON.parse(response.getReturnValue());
                if (parsedResponse.Status == "success") {
                    if (parsedResponse.IsStandard != component.get("v.isStandard")) {
                        this.toggleServiceLevel(component);
                    }
                    if (parsedResponse.IsStandard) {
                        component.find("standardScheduledDdp").getElement().checked = parsedResponse.ScheduledDdp;
                        component.set("v.scheduledDdp", parsedResponse.ScheduledDdp);
                    }
                    else {
                        component.find("businessScheduledDdp").getElement().checked = parsedResponse.ScheduledDdp;
                        component.set("v.scheduledDdp", parsedResponse.ScheduledDdp);
                        component.find("workflowDdp").getElement().checked = parsedResponse.WorkflowApexDdp;
                        component.set("v.workflowDdp", parsedResponse.WorkflowApexDdp);
                        component.find("componentLibrary").getElement().checked = parsedResponse.ComponentLibrary;
                        component.set("v.componentLibrary", parsedResponse.ComponentLibrary);
                        component.find("massDdp").getElement().checked = parsedResponse.MassDdp;
                        component.set("v.massDdp", parsedResponse.MassDdp);
                    }
                }
                else if (parsedResponse.Status == "error") {
                    if (location) {
                    	component.getEvent('showError').setParams({
                        message: parsedResponse.errorMessage
                    	}).fire();   
                    }
                }
            }
        });
            
        $A.enqueueAction(action);
    }
})