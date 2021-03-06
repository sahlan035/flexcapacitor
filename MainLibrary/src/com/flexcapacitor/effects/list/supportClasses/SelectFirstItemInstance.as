

package com.flexcapacitor.effects.list.supportClasses {
	
	import com.flexcapacitor.effects.list.SelectFirstItem;
	import com.flexcapacitor.effects.supportClasses.ActionEffectInstance;
	
	import flash.events.Event;
	

	/**
	 * @copy SelectFirstItem
	 * */  
	public class SelectFirstItemInstance extends ActionEffectInstance {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 *
		 *  @param target This argument is ignored by the effect.
		 *  It is included for consistency with other effects.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function SelectFirstItemInstance(target:Object) {
			super(target);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 * */
		override public function play():void {
			super.play(); // dispatch startEffect
			
			var action:SelectFirstItem = SelectFirstItem(effect);
			var allowNullDataProvider:Boolean = action.allowNullDataProvider;
			// we were checking for ListBase but DataGrid doesn't use ListBase so list is an object
			var list:Object = target;
			
			
			///////////////////////////////////////////////////////////
			// Verify we have everything we need before going forward
			///////////////////////////////////////////////////////////
			
			if (validate) {
				if (list==null) {
					dispatchErrorEvent("The target must be set to a list or datagrid type of component.");
				}
				
				if (!list.hasOwnProperty("dataProvider")) {
					dispatchErrorEvent("The list must have a dataProvider property");
				}
				
				if (list.dataProvider==null && !action.allowNullDataProvider) {
					dispatchErrorEvent("The list data provider is not set");
				}
			}
			
			
			///////////////////////////////////////////////////////////
			// Continue with action
			///////////////////////////////////////////////////////////
			
			// no items in the data provider
			if (list.dataProvider==null || list.dataProvider.length==0) {
				
				if (action.hasEventListener(SelectFirstItem.NO_ITEMS)) {
					action.dispatchEvent(new Event(SelectFirstItem.NO_ITEMS));
				}
				
				if (action.noItemsEffect) { 
					playEffect(action.noItemsEffect);
				}
				
			}
			else {
				list.selectedIndex = 0;
				action.data = list.selectedItem;
				action.dataIndex = list.selectedIndex;
				
				if (action.hasEventListener(SelectFirstItem.ITEM_SELECTED)) {
					action.dispatchEvent(new Event(SelectFirstItem.ITEM_SELECTED));
				}
				
				if (action.itemSelectedEffect) { 
					playEffect(action.itemSelectedEffect);
				}
			}
			
			///////////////////////////////////////////////////////////
			// Finish the effect
			///////////////////////////////////////////////////////////
			
			finish();
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
	}
	
	
}