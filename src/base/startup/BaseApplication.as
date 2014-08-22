package base.startup {
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.utils.getDefinitionByName;
	
	public class BaseApplication extends Sprite 
	{
		
		protected var nativeClass:Class;
		
		public function BaseApplication() 
		{
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, onStage);
			}
		}
		
		protected function processStage():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;			
		}
		
		protected function init():void {
			startup();
			postStartup();
		}
		
		protected function startup():void {
			// override
		}
		
		protected function resize():void {
			// override
		}
		
		protected function postStartup():void 
		{
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			processStage();
			
			if (Capabilities.playerType != 'Desktop') {
				nativeClass = getDefinitionByName('flash.desktop.NativeApplication') as Class;
				nativeClass.nativeApplication.addEventListener('invoke', onInvoke);
				
			} else {
				init();
			}
		}
		
		private function onInvoke(e:Event):void 
		{
			nativeClass.nativeApplication.removeEventListener('invoke', onInvoke);
			init();
		}
		
		private function onResize(e:Event):void 
		{
			resize();
		}
		
	}

}