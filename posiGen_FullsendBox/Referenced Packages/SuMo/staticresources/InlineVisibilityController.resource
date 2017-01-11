

$j = successSidebarJQ.noConflict();
var success_CONTROLLER = {};

try {
	var r = sforce.apex.execute("success.VisibilityResource", "InlineVisibilityController", {});
	success_CONTROLLER = $j.parseJSON(r) || { appName : 'SuMo'};
} catch (e) {
	console.log(e);
 	success_CONTROLLER.isSumoUser = false;
}

$j(document).ready(function() {
	$j("h2:contains('" + success_CONTROLLER.appName + "Toolkit')")
		.parent().hide()
		.next().hide()
		.parent().css("margin-bottom", 0);
	
	
	if (! success_CONTROLLER.isSumoUser) {
		// hiding the sidebar components
		$j("iframe[title*='SidebarCompetition']").parent().parent().hide();
		$j("iframe[title*='SidebarRotation']").parent().parent().hide();
		$j("iframe[title*='SidebarPerformance']").parent().parent().hide();
		$j("iframe[title*='SidebarRewards']").parent().parent().hide();
		$j("iframe[title*='SidebarPromotions']").parent().parent().hide();
	
		// hiding the narrow components
		$j("iframe[title*='Performance_History_Generic']")
			.parent().parent()
			.hide();
		
		//hiding the Record Layout components
		// comments: we are hiding the SuMo section header, if there is only one row.
		var hasOneRow = $j("img[name*='" +  success_CONTROLLER.appName + "']").parent().next().children().children().children().length == 1;
		
		$j("iframe[title*='Rewards']").parent().hide();
 		$j("iframe[title*='Achievements']").parent().hide();
		if (hasOneRow == 1) {
			$j("img[name*='" +  success_CONTROLLER.appName + "']").parent().hide();
		}
	} else {
		// so the user is active, but still we
		// need to check which component to hide
		if(success_CONTROLLER.Performance == false) {
			$j("iframe[title*='SidebarPerformance']").parent().parent().hide();
		}	
		if(success_CONTROLLER.Competition == false) {
			$j("iframe[title*='SidebarCompetition']").parent().parent().hide();
		}	
		if (success_CONTROLLER.Rewards == false) {
			$j("iframe[title*='SidebarRewards']").parent().parent().hide();
		}
		if (success_CONTROLLER.Promotions == false) {
			$j("iframe[title*='SidebarPromotions']").parent().parent().hide();
		}
	}
});


