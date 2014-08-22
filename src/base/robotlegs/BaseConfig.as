package base.robotlegs 
{
	
	import base.robotlegs.events.ModularEvent;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.modularity.api.IModuleConnector;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	public class BaseConfig implements IConfig 
	{
		
		[Inject]
		public var inject:IInjector;
		
		[Inject]
		public var mediator:IMediatorMap;
		
		[Inject]
		public var command:IEventCommandMap;
		
		[Inject]
		public var direct:IDirectCommandMap;
		
		[Inject]
		public var moduleConnector:IModuleConnector;
		
		public var name:String;
		
		protected var startupCommand:Class;
		protected var updateCommand:Class;
		protected var startupView:Class;
		
		public function configure():void 
		{
			moduleConnector.onChannel(name).relayEvent(ModularEvent.ACTION_MODULE);	
			initialize();
		}		
		
		public function initialize():void 
		{
			// override
		}
		
		public function startup(contextView:DisplayObjectContainer):void 
		{
			if (startupCommand) direct.map(startupCommand).execute();
			if (updateCommand) {
				moduleConnector.onChannel(name).receiveEvent(ModularEvent.UPDATE_MODULE);
				command.map(ModularEvent.UPDATE_MODULE, ModularEvent).toCommand(updateCommand);
			}
			if (startupView) contextView.addChild(new startupView() as DisplayObject);
		}
		
	}

}