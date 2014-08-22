package com.kashirov.models 
{
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.Map;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author anton.kashirov
	 */
	public class Hash extends Map 
	{
		
		public var setSignal:Signal;
		public var removeSignal:Signal;
		
		protected var _defaultValue:*;
		
		public function Hash(defaultValue:* = null) 
		{
			_defaultValue = defaultValue;
			setSignal = new Signal(String);
			removeSignal = new Signal(String);
		}
		
		public function dispose():void
		{
			setSignal.removeAll();
			removeSignal.removeAll();
		}
		
		public function del(key:*):void {
			this.removeKey(String(key));
		}
		
		public function set(key:*, value:*):*
		{
			if (this.hasKey(String(key))) del(key);
			this.add(String(key), value);
			return this.itemFor(String(key));
		}
		
		public function get(key:*):*
		{
			if (this.hasKey(String(key))) {
				return this.itemFor(String(key));
			} else {
				return _defaultValue;
			}
		}
		
		public function incr(key:*, value:int):* {
			var newValue:* = get(key) + value;
			set(key, newValue);
			return newValue;
		}
		
		public function updateData(data:Object):void
		{
			for (var name:String in data) 
			{
				// TODO настроить удаление ключей hash + signal
				set(name, data[name]);
				setSignal.dispatch(name);
			}
		}
		
		public function data():Object
		{
			var rt:Object = { };
			
			var iterator:IMapIterator = iterator() as IMapIterator;
			while (iterator.hasNext()) {
				iterator.next();
				rt[iterator.key] = iterator.current;
			}
			
			return rt;
		}
		
		public function sum():int {
			var rt:int = 0;
			var iterator:IMapIterator = iterator() as IMapIterator;
			while (iterator.hasNext()) {
				iterator.next();
				rt += iterator.current;
			}
			return rt;
		}
		
	}

}