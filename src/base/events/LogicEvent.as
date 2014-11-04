package base.events 
{

	import base.robotlegs.ModularData;

	import flash.events.Event;
	
	public class LogicEvent extends Event 
	{

		public static const SCRIPT_MANAGER:String = 'scriptManager';

		public var data:ModularData;
		
		public function LogicEvent(type:String, data:ModularData = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.data = data;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new LogicEvent(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LogicEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}