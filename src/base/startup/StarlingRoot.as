package base.startup {
	
	import base.main.MainConfig;
	import base.model.ConfigModel;
	import base.robotlegs.BaseContext;
	import base.starling.BaseSprite;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingRoot extends Sprite
	{
		
		public static function setConfig(value:ConfigModel):void
		{
			_config = value;
		}
		
		private static var _config:ConfigModel;
		
		public function StarlingRoot() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var container:BaseSprite = new BaseSprite();
			addChild(container);			
			
			var context:BaseContext = new BaseContext('main', MainConfig, this, container, [_config, ConfigModel]);
		}
		
	}

}