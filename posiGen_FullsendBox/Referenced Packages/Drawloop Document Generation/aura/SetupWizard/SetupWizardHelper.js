({
	updateContent : function(component) {
        var step = component.get("v.step");
        var stepTitle = '';
        var stepDescription = '';
        component.set('v.ready', true);
        
        switch (step) {
            case "Edition":
                stepTitle = step;
                stepDescription = '';
                component.set("v.skipButtonLabel", "Skip");
                component.set("v.saveButtonLabel", "Save & Next");
                break;
            case "Users":
                stepTitle = 'User Permissions and Licensing';
                stepDescription = 'Identify users in your organization who can use the app and set their permission level. Administrators have access to the DDP Admin tab, and can create and run DDPs. Users only have permission to run DDPs.';
                component.set("v.skipButtonLabel", "Skip");
                component.set("v.saveButtonLabel", "Save & Next");
                break;
            case "Authorize":
                stepTitle = "Authorize Drawloop Document Generation";
                stepDescription = '';
                component.set("v.skipButtonLabel", "Skip this and Integration Steps");
                component.set("v.saveButtonLabel", "");
                break;
            case "Integrations":
                stepTitle = 'Third-party Integrations';
                stepDescription = 'Integrate the app with our third-party partner applications. Select a service and fill out the required fields.';
                component.set("v.skipButtonLabel", "");
                component.set("v.saveButtonLabel", "Next");
                break;
            case "Settings":
                stepTitle = step;
                stepDescription = '';
                component.set("v.skipButtonLabel", "Skip");
                component.set("v.saveButtonLabel", "Save & Next");
                break;
            case "Sample DDPs":
                stepTitle = 'Sample DDPs';
                stepDescription = 'Sample DDPs provide everything needed to generate your first document and help you design templates for your business use case.'
                	+ ' Select one or all templates below and then be sure to add the corresponding button for each page layout in the next step.'
                	+ ' For example, if you choose a sample DDP that includes Account as the main object, you will need to add a button to an Account page layout.'
                	+ ' Completing both of these steps will allow you to run your first document at the click of a button, once the Wizard has been completed.';
                component.set("v.skipButtonLabel", "Skip");
                component.set("v.saveButtonLabel", "Save & Next");
                break;
            case "Basic Buttons":
                stepTitle = 'Basic Buttons';
                stepDescription = 'Check the box next to each Classic Experience layout that you would like to add a button on standard and custom objects. For each layout that is enabled, a button will automatically be added.';
                component.set("v.skipButtonLabel", "Skip");
                component.set("v.saveButtonLabel", "Save & Complete");
                if (!component.get('v.customizeApplication')) {
                    component.set('v.ready', false);
                }
                break;
        }

        component.set("v.stepTitle", stepTitle);
        component.set("v.stepDescription", stepDescription);
    },
    moveToNextStep : function(component, event, helper) {
        var steps = component.get("v.steps");
        var nextStep = steps[steps.indexOf(component.get("v.step")) + 1];
        if (nextStep) {
	        component.set("v.busy", false);
            component.set("v.step", nextStep);
	        helper.updateContent(component);
        } else {
            var action = component.get("c.completeSetupWizard");
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state !== "SUCCESS" || response.getReturnValue() != "true") {
                    component.getEvent('showError').setParams({
                        message: 'An unexpected error has occurred.'
                    }).fire();
                } else {
                    // Go to End Page
			        component.set("v.busy", false);
		            component.set("v.step", '');
                    helper.updateContent(component);
                    component.set('v.complete', true);
		            component.set('v.alertType', 'success');
		            component.set('v.alertText', 'You deployed Drawloop Document Generation!');
                }
            });
            $A.enqueueAction(action);
        }
    }
})