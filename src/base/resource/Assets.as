package base.resource 
{
	
	import starling.utils.AssetManager;
	
	public class Assets extends AssetManager
	{
		private static var _instance:Assets;
		public static function get instance():Assets { return _instance; }
		
		private var logFunc:Function;
		
		[PostConstruct]
		public function init():void
		{
			_instance = this;
		}
		
		public function addLogFunc(func:Function):void
		{
			logFunc = func;
		}
		
        override protected function log(message:String):void
        {
            super.log(message);
			
			if (logFunc != null) {
				logFunc('AssetsManager', message);
			}
        }
		
	}

}