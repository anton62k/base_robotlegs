package base.robotlegs 
{
	
	import base.robotlegs.events.ModularEvent;
	import flash.events.IEventDispatcher;
	import robotlegs.bender.framework.api.IContext;
	
	public class BaseService 
	{
		
		[Inject]
		public var context:IContext;		
		
		public function action(data:ModularData):Boolean
		{
			var event:ModularEvent = new ModularEvent(ModularEvent.ACTION_MODULE, data);
			var eventDispatcher:IEventDispatcher = context.injector.getInstance(IEventDispatcher);
			return eventDispatcher.dispatchEvent(event);
		}
		
	}

}