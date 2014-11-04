package base.robotlegs {

	import base.model.ConfigModel;
	import base.starling.BaseSprite;

	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;

	public class ModuleManager {

		[Inject]
		public var view:BaseSprite;

		[Inject]
		public var configModel:ConfigModel;

		private var modules:Object;
		private var contextView:DisplayObjectContainer;
		private var moduleContainer:Sprite;

		private var moduleLayout:IModuleLayout;

		[PostConstruct]
		public function init():void {
			modules = {};

			moduleContainer = new Sprite();
			view.addChild(moduleContainer);

			moduleLayout = new SimpleModuleLayout();
			moduleLayout.init(moduleContainer);
		}

		public function setLayout(moduleLayout:IModuleLayout):void {
			this.moduleLayout = moduleLayout;
			this.moduleLayout.init(moduleContainer);
		}

		public function has(name:String):Boolean {
			return modules.hasOwnProperty(name);
		}

		public function add(name:String, moduleData:ModularData, up:Boolean = true):Boolean {
			if (has(name)) {
				if (up) {
					var module:BaseContext = get(name);
					moduleLayout.update(name, module.contextView);
				}
				return false;
			}

			var clazz:Class = configModel.modules.get(name).config as Class;
			var context:BaseContext = new BaseContext(name, clazz, moduleLayout.add(name), moduleData) as BaseContext;
			modules[name] = context;

			return true;
		}
		
		public function getOpened():Array {
			var retval:Array = [];
			for (var name:String in modules) {
				retval.push(name);
			}
			return retval;
		}
		
		public function get(name:String):BaseContext {
			return modules[name];
		}

		public function remove(name:String):Boolean {
			if (!has(name)) return false;

			var context:BaseContext = get(name);
			moduleLayout.remove(name, context.contextView);
			context.destroy();
			if (context.contextView is BaseSprite) {
				(context.contextView as BaseSprite).dispose();
			}
			delete modules[name];

			return true;
		}

	}

}