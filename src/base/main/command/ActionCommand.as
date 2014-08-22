package base.main.command 
{
	
	import base.robotlegs.events.ModularEvent;
	import base.robotlegs.ModularData;
	import flash.events.IEventDispatcher;
	
	public class ActionCommand extends MainCommand 
	{
		
		[Inject]
		public var event:ModularEvent;
		
		override public function execute():void
		{
			scriptManager.update(event.data);
		}
		
	}

}