package base.startup {
	
	import base.model.ConfigModel;
	import base.startup.BaseApplication;
	import base.startup.StarlingRoot;
	import com.junkbyte.console.Cc;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	
	public class StarlingApplication extends BaseApplication 
	{
		
		protected var starling:Starling;
		
		public function getConfig():ConfigModel
		{
			return null;
		}
		
		override protected function resize():void
		{
			var rect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight)
			starling.viewPort = rect;
			starling.stage.stageWidth = rect.width;
			starling.stage.stageHeight = rect.height;
			starling.render();
		}
		
		override protected function startup():void
		{
			Cc.startOnStage(this, 'w');
			Cc.listenUncaughtErrors(loaderInfo);
			
			StarlingRoot.setConfig(getConfig());
			StarlingRoot.setLoaderInfo(loaderInfo);
			starling = new Starling(StarlingRoot, stage, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			starling.showStats = true;
			starling.start();
		}
		
	}

}