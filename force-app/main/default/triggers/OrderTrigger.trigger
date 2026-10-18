trigger OrderTrigger on Order (after insert, after update, after delete) {

    if (Trigger.isAfter) {

        Set<Id> setOfAccIds = new Set<Id>();

        if (Trigger.isInsert) {
            for (Order recOfOrder : Trigger.new) {
                if (recOfOrder.AccountId != null) {
                    setOfAccIds.add(recOfOrder.AccountId);
                }
            }
        }

        if (Trigger.isUpdate) {
            for (Order recOfOrder : Trigger.new) {

                if (recOfOrder.AccountId != null) {
                    setOfAccIds.add(recOfOrder.AccountId);
                }

                if (Trigger.oldMap.get(recOfOrder.Id).AccountId != null) {
                    setOfAccIds.add(Trigger.oldMap.get(recOfOrder.Id).AccountId);
                }
            }
        }

        if (Trigger.isDelete) {
            for (Order recOfOrder : Trigger.old) {
                if (recOfOrder.AccountId != null) {
                    setOfAccIds.add(recOfOrder.AccountId);
                }
            }
        }

        if (!setOfAccIds.isEmpty()) {
            OrderTriggerHandler.calculateTotalOrders(setOfAccIds);
        }
    }
}