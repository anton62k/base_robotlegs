package base.robotlegs 
{
	
	import base.model.ConfigModel;
	import base.robotlegs.events.ModularEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;
	
	public class BaseCommand extends Command 
	{
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var configModel:ConfigModel;
		
		public function isStartupModule():Boolean
		{
			var name:String = (context as BaseContext).config.name;
			return configModel.startupModule == name;
		}
		
		public function action(data:ModularData):void
		{
			var name:String = (context as BaseContext).config.name;
			data.setOwnModule(name);
			var event:ModularEvent = new ModularEvent(ModularEvent.ACTION_MODULE, data);
			
			if (name == 'main') {
				dispatchForChannel('', event);
			} else {
				dispatchForChannel(name, event);
			}
			
		}
		
		public function dispatchForChannel(name:String, event:Event):Boolean
		{
			var eventDispatcher:IEventDispatcher = context.injector.getInstance(IEventDispatcher, name);
			return eventDispatcher.dispatchEvent(event);
		}
		
	}

}