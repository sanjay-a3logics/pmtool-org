({
    init : function(component, event, helper) {
        if ((typeof sforce != 'undefined') && sforce && sforce.one) {
            component.find('viewDdps').set("v.visible", false);
            component.find('createDdps').set("v.visible", false);
            component.set("v.isLightning", true);
        }
        var sampleDdpObjects = component.get('v.sampleDdpObjects');
        var layoutButtonObjects = component.get('v.layoutButtonObjects');
        var union = [];
        for (var i in sampleDdpObjects) {
            var obj = sampleDdpObjects[i];
            if (layoutButtonObjects.indexOf(obj) > -1 && union.indexOf(obj) < 0) {
                union.push(obj);
            }
        }
        var priority = ['Opportunity', 'Account', 'Contact', 'Lead', 'Case', 'Contract'];
        var sampleObject = '';
        for (var i in priority) {
            if (union.indexOf(priority[i]) > -1) {
                sampleObject = priority[i];
                component.set('v.sampleObject', sampleObject);
                break;
            }
        }
        
        var action = component.get("c.getSampleDdpRecords");
        action.setParams({
            objName : sampleObject ? sampleObject : 'none'
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var parsedJSON = JSON.parse(response.getReturnValue());
                if (parsedJSON.status == 'success') {
                    if (sampleObject) {
                        component.set("v.columns", parsedJSON.columns);
                        component.set("v.records", parsedJSON.records);
                    }
                    component.set("v.ddpPrefix", parsedJSON.ddpPrefix);
                } else {
                    component.getEvent('showError').setParams({
                        message: parsedJSON.errorMessage
                    }).fire();
                    component.find('viewDdps').set("v.visible", false);
                    component.find('createDdps').set("v.visible", false);
                    component.find('ddpAdmin').set("v.visible", false);
                }
            }
        });
        $A.enqueueAction(action);
    },
    viewDdps : function(component, event, helper) {
        var url = '/' + component.get("v.ddpPrefix") + '/o';
        if (component.get("v.isLightning")) {
            if (sforce != undefined && sforce.one && sforce.one.navigateToURL) {
                sforce.one.navigateToURL(url);
            }  
        } else {
            window.location = url;
        }
    },
    createDdps : function(component, event, helper) {
        var url = '/apex/Loop__ddpWizard?retURL=' + encodeURIComponent('/' + component.get("v.ddpPrefix") + '/o') + '&save_new=1';
        if (component.get("v.isLightning")) {
            if (sforce != undefined && sforce.one && sforce.one.navigateToURL) {
                sforce.one.navigateToURL(url);
            }
        }else {
            window.location = url;
        }
    },
    ddpAdmin : function(component, event, helper) {
        var url = '/apex/Loop__aboutloop?sfdc.tabName=123456';
        if (component.get("v.isLightning")) {
            if (sforce && sforce.one && sforce.one.navigateToURL) {
                sforce.one.navigateToURL(url);
            }  
        } else {
            window.location = url;
        }
    }
})