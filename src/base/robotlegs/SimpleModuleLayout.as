package base.robotlegs {

	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;

	public class SimpleModuleLayout implements IModuleLayout {

		protected var container:DisplayObjectContainer;

		public function add(module:String):DisplayObjectContainer {
			return container.addChild(new Sprite()) as DisplayObjectContainer;
		}

		public function update(module:String, view:DisplayObjectContainer):void {
			container.addChild(view)
		}

		public function remove(module:String, view:DisplayObjectContainer):void {
			this.container.removeChild(view);
		}

		public function init(container:DisplayObjectContainer):void {
			this.container = container;
		}
	}
}
