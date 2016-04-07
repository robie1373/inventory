# SirKits, Inc. Inventory System

Backend portions of SirKits website and business systems. This chunk is the inventory system which will be the hub of parts ordering, checkin, order fulfillment, and inventory management.

The store will reach back here to determine stock levels of kits and estimate shipping delays.

This will reach out to suppliers upchain to monitor stock levels and place restocking orders. It is possible the store will run just in time /batch. In that scenario, the store will display the number of kits that need to be ordered to reach the supply order threshhold. Once the threashold of kits is reached (which is set by number of components I need to order to get a decent price) then the system could prepare an order, find the best price from the configured vendors, and notify me.


