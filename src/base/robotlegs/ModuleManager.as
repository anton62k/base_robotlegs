package base.robotlegs 
{
	
	import base.model.ConfigModel;
	import base.starling.BaseSprite;
	import org.as3commons.collections.Map;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class ModuleManager
	{
		
		private var modules:Map;
		
		private var contextView:DisplayObjectContainer;
		private var popUp:Sprite;
		private var quad:Quad;
		private var moduleContainer:Sprite;
		
		[Inject]
		public var view:BaseSprite;
		
		[Inject]
		public var configModel:ConfigModel;
		
		public function ModuleManager() 
		{
			modules = new Map();
		}
		
		[PostConstruct]
		public function init():void
		{
			this.contextView = view;
			
			moduleContainer = new Sprite();
			this.contextView.addChild(moduleContainer);
			
			var quad:Quad = new Quad(contextView.stage.stageWidth, contextView.stage.stageHeight, 0x0);
			quad.alpha = 0.5;
			quad.visible = false;
			this.contextView.addChild(quad);
			
			popUp = new Sprite()
			this.contextView.addChild(popUp);
		}
		
		public function has(name:String):Boolean
		{
			return modules.hasKey(name);
		}
		
		public function add(name:String, moduleData:ModularData, up:Boolean = true):Boolean
		{
			if (has(name)) {
				if (up) {
					var module:BaseContext = get(name);
					module.contextView.parent.addChild(module.contextView);
				}
				return false;
			}
			
			var container:BaseSprite = new BaseSprite();
			moduleContainer.addChild(container);
			
			var clazz:Class = configModel.modules.get(name).config as Class;
			var context:BaseContext = new BaseContext(name, clazz, container, moduleData) as BaseContext;
			modules.add(name, context);
			
			return true;
		}
		
		public function get(name:String):BaseContext
		{
			return modules.itemFor(name);
		}
		
		public function remove(name:String):Boolean
		{
			if (!has(name)) return false;
			
			var context:BaseContext = get(name);
			context.contextView.parent.removeChild(context.contextView);
			context.destroy();
			if (context.contextView is BaseSprite) {
				(context.contextView as BaseSprite).dispose();
			}
			modules.removeKey(name);
			popUp.visible = (popUp.numChildren > 0 );
			
			if (popUp.numChildren > 0) {
				popUp.getChildAt(popUp.numChildren - 1).visible = true;
			}
			
			return true;
		}
		
	}

}