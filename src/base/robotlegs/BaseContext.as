package base.robotlegs
{
	
	import flash.display.Stage;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	
	public class BaseContext extends Context 
	{
		
		public var contextView:DisplayObjectContainer;
		public var config:BaseConfig;
		
		public function BaseContext(name:String, config:Class, contextView:DisplayObjectContainer, ...injects) 
		{
			this.config = new config() as BaseConfig;
			this.config.name = name;
			this.contextView = contextView;
			
			injects.push(this.contextView);
			
			var cl:Class;
			for each (var item:Object in injects) 
			{
				if (item as Array) {
					cl = item[1];
					item = item[0];
				} else if (item) {
					cl = getDefinitionByName(getQualifiedClassName(item)) as Class;
				}
				injector.map(cl).toValue(item);
			}
			
			injector.map(Stage).toValue(Starling.current.nativeStage);
			startup();
		}
		
		protected function startup():void
		{
			install(MVCSBundle, StarlingViewMapExtension);
			configure(new ContextView(Starling.current.nativeStage), config, Starling.current);
			initialize(onInitialize);
			beforeDestroying(onBeforeDestroying);
		}
		
		protected function onInitialize():void 
		{
			config.startup(contextView);
		}
		
		protected function onBeforeDestroying():void 
		{
			contextView.dispose();
			contextView = null;
			config = null;
		}		
		
	}

}