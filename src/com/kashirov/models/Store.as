package com.kashirov.models 
{
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author 
	 */
	public class Store extends Proxy implements IModel
	{
		
		protected var _models:Object;
		protected var _assign:Class;
		protected var modelFields:Array;
		protected var className:String;
		protected var _prefix:String;
		
		private var _addSignal:Signal;
		private var _removeSignal:Signal;
		private var _changeSignal:Signal;
		private var _length:int;
		
		public var nextId:int = 0;
		
		public function toString():String
		{
			return '[object ' + className.split('::')[1] + ']';
		}		
		
		override flash_proxy function nextNameIndex(index:int):int 
		{
			if (index < modelFields.length) {
				return index + 1;
			} else {
				return 0;
			}
		}
		
		override flash_proxy function nextName(index:int):String
		{
			return modelFields[index - 1];
		}
		
		override flash_proxy function nextValue(index:int):*
		{
			var field:String = modelFields[index - 1];
			return _models[field];
		}		
		
		public function Store() 
		{
			_models = { };
			modelFields = [];
			_length = 0;
			
			prefix = '';
			
			_addSignal = new Signal(IModel);
			_removeSignal = new Signal(IModel);
			_changeSignal = new Signal(IModel, Object);
			
			var structure:XML = Cache.getDescribeType(this);
			className = Cache.getClassName(this);
			_assign = Cache.getAssignClass(this);
		}
		
		public function data():Object
		{
			var rt:Object = { };
			
			for (var name:String in _models) 
			{
				var item:IModel = getItem(name);
				rt[name] = item.data();
			}
			
			return rt;
		}
		
		[PreDestroy]
		public function dispose():void
		{
			addSignal.removeAll();
			removeSignal.removeAll();
			
			for (var name:String in _models) 
			{
				var item:IModel = getItem(name);
				item.dispose();
			}
		}
		
		public function getItem(key:*):IModel
		{
			key = String(key);
			return _models[key];
		}
		
		public function addItem(key:* = null, data:Object = null):IModel
		{
			if (key == null) {
				key = incrKey();
			}
			
			key = String(key);
			if (getItem(key)) return null;
			
			var item:IModel = new _assign() as IModel;
			_models[key] = item;
			item.prefix = key;
			if (data) item.updateData(data);
			item.init();
			modelFields.push(key);
			_length += 1;
			addSignal.dispatch(item);
			item.changeSignal.add(onItemSignal);
			return item;
		}
		
		protected function onItemSignal(item:IModel, fields:Object):void 
		{
			changeSignal.dispatch(item, fields);
		}
		
		public function removeItem(key:*):IModel
		{
			key = String(key);
			var item:IModel = _models[key] as IModel;
			delete _models[key];		
			modelFields.splice(modelFields.indexOf(key), 1);
			_length -= 1;
			removeSignal.dispatch(item);
			item.dispose();
			return item;
		}
		
		public function removeAll():void
		{
			var modelFields:Array = this.modelFields.slice();
			for each (var key:String in modelFields) 
			{
				removeItem(key);
			}
		}
		
		public function updateData(data:Object):void
		{
			for (var name:String in data) 
			{
				var value:Object = data[name];
				
				if (value == null && getItem(name)) {
					removeItem(name);
					continue;
				}
				
				if (getItem(name)) {
					getItem(name).updateData(value);
				} else {
					addItem(name, value);
				}
			}
		}
		
		public function init():void
		{
			// override
		}
		
		public function count():int
		{
			trace('Store.count() deprecated. Use Store.length');
			return modelFields.length
		}
		
		private function getIncrKey(id:int):int {
			if (getItem(id)) {
				return getIncrKey(id + 1);
			}
			return id;
		}
		
		private function incrKey():int
		{
			var id:int = getIncrKey(this.nextId);
			nextId = id + 1;
			return id;
		}
		
		public function get prefix():String 
		{
			return _prefix;
		}
		
		public function set prefix(value:String):void 
		{
			_prefix = value;
		}
		
		public function get addSignal():Signal 
		{
			return _addSignal;
		}
		
		public function get removeSignal():Signal 
		{
			return _removeSignal;
		}
		
		public function get changeSignal():Signal 
		{
			return _changeSignal;
		}
		
		public function get length():int 
		{
			return _length;
		}
		
	}

}
