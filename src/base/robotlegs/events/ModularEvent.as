package base.robotlegs.events
{
	
	import base.robotlegs.ModularData;
	import flash.events.Event;
	
	public class ModularEvent extends Event 
	{
		
		public static const ACTION_MODULE:String = 'actionModule';
		public static const UPDATE_MODULE:String = 'updateModule';
		
		public var data:ModularData;
		
		public function ModularEvent(type:String, data:ModularData = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.data = data;
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ModularEvent(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ModularEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}