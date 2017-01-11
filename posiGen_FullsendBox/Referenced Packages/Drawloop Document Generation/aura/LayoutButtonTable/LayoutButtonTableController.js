({
    toggleGroup : function(component, event, helper) {
        var row = event.target.closest('tr');
        // Only continue to expand/collapse row if it is a group (header)
        var isGroup = row.getAttribute('data-is-group');
        if (isGroup == 'true') {
        var industry = row.getAttribute('id');
            var expanded = row.getAttribute('data-expanded');
            if (expanded == 'false') {
                helper.expandGroup(row, industry);
            } else {
                helper.retractGroup(row, industry);
            }
        }        
    },
    updateCheckboxes : function(component, event, helper) {
		var checkbox = event.source.getElement();
        var groupCheckboxes = document.getElementsByClassName(checkbox.classList[0]);
        var groupCheckboxesClassList = groupCheckboxes[0].closest('.slds-checkbox').classList;
        var isGroup = checkbox == groupCheckboxes[0];

        var selectedCountString = component.find("selectedCount").getElement().innerHTML;
        var selectedMatches = selectedCountString.match(/ \((\d+)\)/i);
        var selectedCount = (selectedMatches && selectedMatches.length == 2) ? parseInt(selectedMatches[1]) : 0;
        
        if (isGroup) {
            for (var i = 0; i < groupCheckboxes.length; i++) {
                if (groupCheckboxes[i].checked != checkbox.checked) {
	                groupCheckboxes[i].checked = checkbox.checked;
		            selectedCount += checkbox.checked ? 1 : -1;
                }
            }
            if (groupCheckboxesClassList.contains('tristate')) {
                groupCheckboxesClassList.remove('tristate');
            }
        } else if (!checkbox.checked) {
            var checkedExists = false;
            for (var i = 1; i < groupCheckboxes.length; i++) {
                if (groupCheckboxes[i].checked) {
                    checkedExists = true;
                    break;
                }
            }
            
            if (checkedExists) {
                if (!groupCheckboxesClassList.contains('tristate')) {
                    groupCheckboxesClassList.add('tristate');
                }
            } else {
            	groupCheckboxes[0].checked = false;
                if (groupCheckboxesClassList.contains('tristate')) {
                    groupCheckboxesClassList.remove('tristate');
                }
            }
            selectedCount -= 1;
        } else if (checkbox.checked) {
            // groupCheckbox is the checkbox on the "header" row that represents the following rows in the "group"; this checkbox holds the "tristate" when necessary
            var groupCheckbox = groupCheckboxes[0];
            var uncheckedExists = false;
            for (var i = 1; i < groupCheckboxes.length; i++) {
                if (!groupCheckboxes[i].checked) {
                    uncheckedExists = true;
                    break;
                }
            }
            
            groupCheckbox.checked = true;
            if (uncheckedExists) {
                if (!groupCheckboxesClassList.contains('tristate')) {
                    groupCheckboxesClassList.add('tristate');
                }
            } else {
                if (groupCheckboxesClassList.contains('tristate')) {
                    groupCheckboxesClassList.remove('tristate');
                }
            }
            selectedCount += 1;
        }
        // Updated selected count with javascript so table is not rerendered
        component.find("selectedCount").getElement().innerHTML = selectedCount > 0 ? ' (' + selectedCount + ')' : '';
    },
    save : function(component, event, helper) {
        var moveToNextStep = component.getEvent("moveToNextStep");
        var objectIds = [];
        var objects = component.get("v.objectGroups");

		var objectTypeMap = {};
        if (objects && objects.length > 0) {
            for (var i in objects) {
                if (!objects[i].isGroup) {
                    objectIds.push(objects[i].id);
                    objectTypeMap[objects[i].id] = objects[i].obj;
                }
            }
            var checkedIds = [];
            var checkedObjectTypes = [];
            for (var i in objectIds) {
                var label = document.getElementById(objectIds[i]);
                if (label.firstChild.checked) {
                    checkedIds.push(objectIds[i]);
                    var objectType = objectTypeMap[objectIds[i]];
                    if (checkedObjectTypes.indexOf(objectType) < 0) {
	                    checkedObjectTypes.push(objectType);
                    }
                }
            }
            
            var action = component.get("c.saveLayouts");
            action.setParams({
                sessionId: component.get("v.sessionId"),
                checkedLayoutIds: JSON.stringify(checkedIds),
                layoutMetadataJson: component.get("v.layoutMetadata")
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.getEvent('setSampleObjects').setParams({
                        sampleType: 'layoutButtons',
                        objectTypes: checkedObjectTypes
                    }).fire();
                    moveToNextStep.setParams({success: true}).fire();
                } else if (state === "ERROR") {
                    component.getEvent('showError').setParams({
                        message: 'There was a problem modifying layouts.'
                    }).fire();
                }
            });
            $A.enqueueAction(action);
        } else {
            moveToNextStep.fire();
        }
    },
    createButton : function(component, event, helper) {
        var objectType = component.find('customObjectSelect').get('v.value');
        var cmp = component;
        var help = helper;
        if (objectType) {
        	helper.toggleLinkAndSpinner(component, false);
            
            var action = component.get("c.createWeblink");
            action.setParams({
                sessionId: component.get("v.sessionId"),
                objectType: objectType
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    // re-fetch groups to get updates and rerender
			        help.getObjectGroups(cmp);
                } else if (state === "ERROR") {
                    component.getEvent('showError').setParams({
                        message: 'There was a problem creating this button.'
                    }).fire();
                }
            });
            $A.enqueueAction(action);
        } else {
            component.getEvent('showError').setParams({
                title: 'Unexpected Error',
                message: 'This object type could not be found.'
            }).fire();
        }
    }
})