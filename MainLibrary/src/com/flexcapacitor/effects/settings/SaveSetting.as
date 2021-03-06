

package com.flexcapacitor.effects.settings {
	
	import com.flexcapacitor.effects.settings.supportClasses.SaveSettingInstance;
	import com.flexcapacitor.effects.supportClasses.ActionEffect;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	
	import mx.effects.Effect;
	
	/**
	 * Event when there is an error during save
	 * */
	[Event(name="error", type="flash.events.Event")]

	/**
	 * Event when save is successful
	 * */
	[Event(name="saved", type="flash.events.Event")]
	
	/**
	 * Event when save is pending
	 * 
	 * */
	[Event(name="pending", type="flash.events.Event")]

	/**
	 * Saves a setting to the client disk. This uses Shared Objects to save the setting
	 * value. The group option is also the path to the shared object. 
	 * */
	public class SaveSetting extends ActionEffect {
		
		public static const ERROR:String = "error";
		public static const SAVED:String = "saved";
		public static const PENDING:String = "pending";
		
		
		/**
		 *  Constructor.
		 *
		 *  @param target The Object to animate with this effect.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function SaveSetting(target:Object = null) {
			// Effect requires non-null targets, so if they didn't give us one
			// we will create a dummy object to serve in its place. If the effect
			// is being used to listen to events, then they will supply a real
			// target of type IEventDispatcher instead, either here or separately
			// in the target attribute
			if (!target)
				target = new Object();
			
			super(target);
			

			instanceClass = SaveSettingInstance;
			
		}
		
		
		/**
		 * Reference to the shared object
		 * */
		public var sharedObject:SharedObject;
		
		/**
		 * Name of group for setting. Default is general. 
		 * Required. The name can include forward slashes (/); for example, 
		 * work/addresses is a legal name. 
		 * Spaces are not allowed in the name, nor are the following characters: 
		 * ˜ % & \ ; : ' , < > ? #
		 *  
		 * The group name equals the name passed in to getLocal()<br/>
		 * 
		 * @copy flash.net.SharedObject.getLocal()
		 * */
		public var group:String = "general";
		
		/**
		 * If this parameter is set to true, creates a new secure settings file 
		 * (ie shared object) or gets a reference to an existing secure shared object. 
		 * 
		 * If your SWF file is delivered over a non-HTTPS connection and you try to set 
		 * this parameter to true, the creation of a new shared object (or the access of 
		 * a previously created secure shared object) fails and null is returned. <br/>
		 * 
		 * @copy flash.net.SharedObject.getLocal()
		 * */
		public var secure:Boolean;
		
		/**
		 * Saves the setting. Locally persistent shared object equals setting. <br/>
		 * 
		 * @copy flash.net.SharedObject.flush()
		 * */
		public var applyImmediately:Boolean = true;
		
		/**
		 * Name of setting. Required.
		 * */
		public var name:String;
		
		/**
		 * Value of setting. Required.
		 * To remove a setting use remove setting. 
		 * */
		public var data:Object;
		
		/**
		 * Value can be null or empty.
		 * */
		public var valueCanBeNull:Boolean = true;
		
		/**
		 * Effect to play when the save is pending. 
		 * 
		 * @copy flash.net.SharedObject.flush()
		 * */
		public var pendingEffect:Effect;
		
		/**
		 * Effect to play when the save is successful. 
		 * 
		 * @copy flash.net.SharedObject.flush()
		 * */
		public var savedEffect:Effect;
		
		/**
		 * Effect to play when an error during save occurs. 
		 * 
		 * @copy flash.net.SharedObject
		 * */
		public var errorEffect:Effect;
		
		/**
		 * Minimum amount of space in bytes to request when more space is needed. 
		 * Default is 0.<br/>
		 * 
		 * @copy flash.net.SharedObject.flush()
		 * */
		public var minimumSettingsSpace:int;
		
		/**
		 * Optional.
		 * @copy flash.net.SharedObject.getLocal()
		 * */
		public var localPath:String;
		
		/**
		 * Reference to AsyncErrorEvent when an AsyncError event occurs.
		 * */
		public var asyncErrorEvent:AsyncErrorEvent;
		
		/**
		 * Reference to NetStatusEvent when an NetStatus event occurs.
		 * */
		public var netStatusEvent:NetStatusEvent;
		
		/**
		 * Reference to error event when a shared object error event occurs.
		 * */
		public var errorEvent:Object;
		
		/**
		 * Object encoding. Default is ObjectEncoding.AMF3
		 * */
		public var objectEncoding:uint = ObjectEncoding.AMF3;
		
		/**
		 * Trace the shared object data to the console
		 * */
		public var traceDataToConsole:Boolean;
		
	}
}