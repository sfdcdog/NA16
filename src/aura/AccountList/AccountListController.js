({
	doInit : function(component) {
		var action = component.get("c.getAccounts");
        
        action.setCallback(this, function(response){
            var state = response.getState();
            $A.log(response);
            if(state === "SUCCESS"){
                console.log('which comes first???Eh!?!?')
                component.set("v.accounts", response.getReturnValue());
            }
        });
        console.log('$$$$'+action);
    	$A.enqueueAction(action);
	}
})