package base.model {
	
	import base.model.config.ModuleStore;
	import base.model.logic.LogicStore;
	import base.robotlegs.BaseConfig;
	import base.script.vo.Script;
	import base.script.vo.ScriptStore;
	import com.kashirov.models.Unit;
	
	public class ConfigModel extends Unit
	{
		
		public var modules:ModuleStore;
		public var scripts:ScriptStore;
		public var logics:LogicStore;
		public var services:Array;
		public var startupModule:String;
		public var params:Object;
		
		public function addLogicCommand(name:String, clazz:Class):void
		{
			logics.add(name, {
				commandClass: clazz
			});
		}
		
		public function addModule(name:String, config:Class, openHook:Class = null, updateHook:Class = null):void
		{
			modules.add(name, { 
				config: config,
				openHook: openHook,
				updateHook: updateHook
			});
		}
		
		public function addService(clazz:Class):void
		{
			services.push(clazz);
		}
		
		protected function addScript(text:String, check:Object, execute:Array):void 
		{
			var script:Script = scripts.add();
			script.text = text;
			script.check.updateData(check);
			
			for each (var itemData:Object in execute) 
			{
				script.execute.add(null, itemData);
			}
		}
		
		protected function execute(action:String, module:String = ''):Object {
			return trigger(action, module);
		}
		
		protected function trigger(action:String, module:String = ''):Object {
			return { action: action, module: module };
		}
		
		override public function init():void
		{
			startupModule = getStartupModule();
			
			prepareModules();
			prepareServices();
			prepareLogics();
			prepareScripts();
			prepareParams();
		}
		
		protected function getStartupModule():String
		{
			return '';
		}
		
		protected function prepareParams():void 
		{
			
		}
		
		protected function prepareModules():void 
		{
			
		}
		
		protected function prepareServices():void 
		{
			
		}
		
		protected function prepareLogics():void 
		{	
			
		}
		
		protected function prepareScripts():void 
		{
			
		}
		
	}

}