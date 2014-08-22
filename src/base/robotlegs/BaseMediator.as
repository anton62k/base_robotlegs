package base.robotlegs 
{
	
	import flash.display.Stage;
	import flash.events.Event;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class BaseMediator extends StarlingMediator 
	{
		
		[Inject]
		public var stage:Stage;
		
		[PostConstruct]
		public function postConstruct():void
		{
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		[PreDestroy]
		public function preDestroy():void
		{
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		public function resize():void
		{
			// override
		}
		
		private function onResize(e:Event):void 
		{
			resize();
		}
		
	}

}