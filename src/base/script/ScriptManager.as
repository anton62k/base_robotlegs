package base.script {

	import base.Actions;
	import base.events.LogicEvent;
	import base.model.ConfigModel;
	import base.model.ModularStore;
	import base.model.config.Module;
	import base.robotlegs.ModularData;
	import base.robotlegs.ModuleManager;
	import base.robotlegs.events.ModularEvent;
	import base.script.vo.Check;
	import base.script.vo.Script;

	import flash.events.IEventDispatcher;

	import robotlegs.bender.extensions.commandCenter.api.CommandPayload;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.framework.api.IInjector;

	public class ScriptManager {

		[Inject]
		public var modularStore:ModularStore;

		[Inject]
		public var moduleManager:ModuleManager;

		[Inject]
		public var inject:IInjector;

		[Inject]
		public var eventDispatcher:IEventDispatcher;

		[Inject]
		public var configModel:ConfigModel;

		[Inject]
		public var direct:IDirectCommandMap;

		private var logFunc:Function;
		private var excludeLogic:Object;
		private var excludeUpdate:Object;

		[PostConstruct]
		public function init():void {
			excludeLogic = { };
			excludeUpdate = { };
		}

		public function addLogFunc(func:Function):void {
			logFunc = func;
		}

		public function excludeLoggedLogicCommand(logic:String):void {
			excludeLogic[logic] = true;
		}

		public function excludeLoggedUpdateModule(module:String):void {
			excludeUpdate[module] = true;
		}

		public function update(config:ModularData):void {
			if (config.ownModule) {
				var modularItem:ModularData = modularStore.get(config.ownModule) || modularStore.add(config.ownModule);
				modularItem.updateData(config.data());
			}

			var total:int = 0;
			var count:int = 0;

			for each (var script:Script in configModel.scripts) {
				total += 1;
				var check:Boolean = execute(script, config);

				if (check) {
					count += 1;
				}
			}

			if (!count) {
				if (config.action == Actions.CLOSE) {
					closeModule(config.module);

				} else if (config.action == Actions.OPEN) {
					openModule(config.module, config);

				} else if (config.action == Actions.UPDATE) {
					updateModule(config.module, config);

				} else if (config.action == Actions.LOGIC) {
					logicCommand(config.logic, config);
				}
			}
		}

		public function logicCommand(logic:String, data:ModularData = null):void {
			if (!excludeLogic[logic]) log('logicCommand', logic);
			eventDispatcher.dispatchEvent(new LogicEvent(logic, data));
		}

		protected function openModule(moduleName:String, config:ModularData):void {
			var moduleData:Object = null;
			var module:Module = configModel.modules.get(moduleName);

			if (module.openHook) {
				log('openModule', moduleName, 'with hook ' + String(module.openHook));
				direct.map(module.openHook as Class).execute(new CommandPayload([module, config], [Module, ModularData]));
				moduleData = modularStore.get(moduleName).moduleData;
			} else {
				log('openModule', moduleName);
			}

			moduleManager.add(moduleName, ModularData.moduleData(moduleData));
		}

		protected function closeModule(moduleName:String):void {
			if (moduleManager.has(moduleName)) {
				log('closeModule', moduleName);
				moduleManager.remove(moduleName);
			} else {
				log('closeModule', moduleName, 'error module not exist');
			}
		}

		protected function updateModule(moduleName:String, config:ModularData):void {
			if (moduleManager.has(moduleName)) {
				var dispatcher:IEventDispatcher = inject.getInstance(IEventDispatcher, moduleName) as IEventDispatcher;

				var moduleData:Object = null;
				var module:Module = configModel.modules.get(moduleName);

				if (module.updateHook) {
					if (!excludeUpdate[moduleName]) log('updateModule', moduleName, 'with hook ' + String(module.updateHook));
					direct.map(module.updateHook as Class).execute(new CommandPayload([module, config], [Module, ModularData]));
					moduleData = modularStore.get(moduleName).moduleData;
				} else {
					if (!excludeUpdate[moduleName]) log('updateModule', moduleName);
				}

				dispatcher.dispatchEvent(new ModularEvent(ModularEvent.UPDATE_MODULE, ModularData.moduleData(moduleData)));
			}
		}

		protected function log(...rest):void {
			rest.unshift('ScriptManager');
			if (logFunc != null) {
				logFunc.apply(null, rest);
			}
		}

		private function execute(script:Script, config:ModularData):Boolean {
			var check:Boolean = false;

			if (script.check.action == config.action && script.check.module == config.module) {
				check = true;
			}

			if (check) {
				for each (var _item:Check in script.execute) {
					if (_item.action == Actions.OPEN) {
						openModule(_item.module, config);

					} else if (_item.action == Actions.CLOSE) {
						closeModule(_item.module);

					} else if (_item.action == Actions.UPDATE) {
						updateModule(_item.module, config);

					} else if (_item.action == Actions.LOGIC) {
						logicCommand(_item.module, config);
					}
				}
			}
			return check;
		}

	}

}
