package base.robotlegs {

	import starling.display.DisplayObjectContainer;

	public interface IModuleLayout {

		function init(container:DisplayObjectContainer):void;

		function add(module:String):DisplayObjectContainer;

		function update(module:String, view:DisplayObjectContainer):void;

		function remove(module:String, view:DisplayObjectContainer):void;

	}
}
