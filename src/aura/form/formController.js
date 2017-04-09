({
    doInit: function(component, event, helper) {
        //Update expense counters
        console.log('1) Init based cmp: ' + component);
        console.log('2) Init based event: ' + event);
        /*for(var p in event){
    	   console.log('Event Prps fire: '+p.fire);
    	   console.log('Event Prps Name: '+p.getName);
    	   console.log('Event Prps Param: '+p.getParam);
    	   console.log('Event Prps Params: '+p.getParams);
    	   console.log('Event Prps Phase: '+p.getPhase);
    	   console.log('Event Prps Source: '+p.getSource);
    	   console.log('Event Prps prevent default: '+p.preventDefault);
    	   console.log('Event Prps resume: '+p.resume);
       }*/
        console.log('3) Init based helper: ' + helper);
        for (var p in helper) {
            console.log('Helper Prps: ' + helper[p]);
        }
        helper.getExpenses(component);
    },

    createExpense: function(component, event, helper) {
        //Obtaining amount value inputed.
        var amtField = component.find("amount");
        var amt = amtField.get("v.value");

        //Error Handling
        if (isNaN(amt) || amt == '') {
            
            //Set Errors
            amtField.set("v.errors", [{
                message: "Enter an expense amount."
            }]);
        } else {
        	//process when there are no errors
            amtField.set("v.errors", null);
            var newExpense = component.get("v.newExpense");
            helper.createExpense(component, newExpense);
        }
    },

    updateEvent: function(component, event, helper) {
        console.log('Update based cmp: ' + component);
        helper.upsertExpense(component, event.getParam("expense"));
    }
})