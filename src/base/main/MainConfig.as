package base.main 
{
	
	import base.events.LogicEvent;
	import base.main.command.ActionCommand;
	import base.main.command.StartupCommand;
	import base.model.config.Module;
	import base.model.ConfigModel;
	import base.model.logic.LogicItem;
	import base.model.ModularStore;
	import base.resource.Assets;
	import base.robotlegs.BaseConfig;
	import base.robotlegs.events.ModularEvent;
	import base.robotlegs.ModuleManager;
	import base.script.ScriptManager;
	
	public class MainConfig extends BaseConfig 
	{
		
		override public function initialize():void
		{
			var configApp:ConfigModel = inject.getInstance(ConfigModel);
			configApp.init();
			
			inject.map(Assets).asSingleton();
			inject.map(ModuleManager).asSingleton();
			inject.map(ScriptManager).asSingleton();
			inject.map(ModularStore).asSingleton();
			
			for each (var logicItem:LogicItem in configApp.logics) 
			{
				command.map(logicItem.prefix, LogicEvent).toCommand(logicItem.commandClass as Class);
			}
			
			for each (var module:Module in configApp.modules) 
			{
				if (module.prefix != name) moduleConnector.onChannel(module.prefix).receiveEvent(ModularEvent.ACTION_MODULE);
				if (module.prefix != name) moduleConnector.onChannel(module.prefix).relayEvent(ModularEvent.UPDATE_MODULE);
			}
			
			for each (var service:Class in configApp.services) 
			{
				inject.map(service).asSingleton();
			}
			
			moduleConnector.onDefaultChannel().receiveEvent(ModularEvent.ACTION_MODULE);
			command.map(ModularEvent.ACTION_MODULE).toCommand(ActionCommand);
			startupCommand = StartupCommand;
		}
		
	}

}