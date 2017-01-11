({
    onInit : function(component, event, helper) {
        helper.loadEditionData(component, component.get("v.sessionId"), '');
        var action = component.get("c.fetchPreOAuthData");
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var parsedResponse = JSON.parse(response.getReturnValue());
                if (parsedResponse.isSuccess) {
                    component.set("v.oAuthUrl", parsedResponse.oAuthUrl);
                    component.set("v.isTrial", parsedResponse.isTrial);
                    component.set("v.isSandbox", parsedResponse.isSandbox);
                }
                else {
                    component.getEvent('showError').setParams({
                        message: parsedResponse.errorMessage
                    }).fire();
                }
                $A.util.addClass(component.find("loading"), "hidden");
                $A.util.removeClass(component.find("pageContent"), "hidden");
            }
        })
        $A.enqueueAction(action);
    },
    startOAuthFlow : function(component, event, helper) {
        window.open(component.get("v.oAuthUrl"), "Salesforce Auth", "width=490, height=680");
    },
    handleOAuthSuccessful : function(component, event, helper) {
        helper.loadEditionData(component, event.getParam("sessionId"), event.getParam("location"));
    },
    save : function(component) {
        var isStandard = component.get('v.isStandard');
        var checkboxName = isStandard ? 'standardScheduledDdp' : 'businessScheduledDdp';
        
        var scheduledDdp = component.find(checkboxName).getElement().checked;
        var workflowDdp = component.find("workflowDdp").getElement().checked;
        var componentLibrary = component.find("componentLibrary").getElement().checked;
        var massDdp = component.find("massDdp").getElement().checked;
        
        var action = component.get("c.saveServices");
        action.setParams({
            "isStandard" : isStandard,
            "scheduledDdp" : scheduledDdp,
            "workflowDdp" : workflowDdp,
            "componentLibrary" : componentLibrary,
            "massDdp" : massDdp
        });
        
        action.setCallback(this, function(response) {
            var moveToNextStep = component.getEvent("moveToNextStep");
            if (response.getState() === "SUCCESS") {
                var parsedResponse = JSON.parse(response.getReturnValue());
                if (parsedResponse.isSuccess) {
                    //Settings component needs to know whether or not 'massDdp' has been selected
                    var isMass = component.find("massDdp").getElement().checked && !component.get("v.isStandard") ? true : false;
                    var massDdpSelected = component.getEvent("massDdpSelected");
                    massDdpSelected.setParams({isMass: isMass}).fire();
                    
                    var moveToNextStep = component.getEvent("moveToNextStep");
                    moveToNextStep.setParams({success: true}).fire();
                }
                else {
                    moveToNextStep.setParams({success: false}).fire();
                    component.getEvent('showError').setParams({
                        message: parsedResponse.errorMessage
                    }).fire();
                }
            } else {
                moveToNextStep.setParams({success: false}).fire();
                var error = response.getError();
                var message = 'There was a problem saving changes.';
                if (error && error[0] && error[0].message) {
					message = response.getError()[0].message;
                }
                component.getEvent('showError').setParams({
                    message: message
                }).fire();
            }
        });
        $A.enqueueAction(action);
    },
    toggleServiceLevelHelper : function(component, event, helper) {
        var desiredServiceLevel = event.currentTarget.getAttribute("name") == "enableStandardButton" ? "standard" : "business";
        var currentServiceLevel = component.get("v.isStandard") ? "standard" : "business";
        
        if (desiredServiceLevel != currentServiceLevel) {
        	helper.toggleServiceLevel(component, event);
        }
    },
    toggleService : function(component, event) {
        var attributeName = event.currentTarget.getAttribute("name").toLowerCase().indexOf('scheduledddp') > -1 ? 'v.scheduledDdp' : "v".concat(".", attributeName);
        var attributeValue = component.get(attributeName);
        component.set(attributeName, !attributeValue);
    }
})