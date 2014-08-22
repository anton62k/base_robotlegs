package base.starling 
{
	
	import base.resource.Assets;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.animation.DelayedCall;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	
	public class BaseSprite extends Sprite 
	{
		
		static private var _textureScaleFactor:Number = 1;
		
		public static function setTextureScaleFactor(value:Number):void
		{
			_textureScaleFactor = value;
		}
		
		protected var calls:Vector.<DelayedCall> = new Vector.<DelayedCall>();
		
		public function get asset():Assets
		{
			return Assets.instance;
		}
		
		public function get textureScaleFactor():Number
		{
			return _textureScaleFactor;
		}
		
		public function get juggler():Juggler
		{
			return Starling.current.juggler;
		}
		
		public function scale(value:Number):Number
		{
			return value * _textureScaleFactor;
		}
		
		override public function dispose():void {
			disposeMovies();
			super.dispose();
		}
		
		public function disposeMovies():void
		{
			for (var i:int = 0; i < numChildren; i++) 
			{
				if (getChildAt(i) as MovieClip) {
					var movie:MovieClip = getChildAt(i) as MovieClip;
					juggler.remove(movie);
					movie.stop();
				}
			}
		}
		
		public function getImage(name:String):Image
		{
			var image:Image = new Image(asset.getTexture(name));
			return image;
		}
		
		public function addImage(name:String, x:int = 0, y:int = 0):Image
		{
			var image:Image = new Image(asset.getTexture(name));
			addChild(image);
			image.x = x;
			image.y = y;
			return image;
		}
		
		public function addMovie(prefix:String, container:DisplayObjectContainer = null, played:Boolean = true, fps:int = 30):MovieClip
		{
			return addMovieInternal(asset.getTextures(prefix), container, played, fps);
		}
		
		public function addMovieInternal(textures:Vector.<Texture>, container:DisplayObjectContainer = null, played:Boolean = true, fps:int = 30):MovieClip
		{
			var movie:MovieClip = new MovieClip(textures, fps);
			Starling.current.juggler.add(movie);
			if (played) {
				movie.play();
			} else {
				movie.stop();
			}
			if (!container) {
				container = this;
			}
			container.addChild(movie);
			return movie;
		}
		
		public function delayCall(call:Function, delay:Number, ...args):DelayedCall
		{
			var rt:DelayedCall = juggler.delayCall.apply(null, [call, delay].concat(args));
			calls.push(rt);
			rt.addEventListener(Event.REMOVE_FROM_JUGGLER, onRemoveFromJuggler);
			return rt;
		}
		
		public function removeCalls():void
		{
			for each (var call:DelayedCall in calls) 
			{
				juggler.remove(call);
			}
			calls = new Vector.<DelayedCall>();
		}
		
		private function onRemoveFromJuggler(e:Event):void 
		{
			var call:DelayedCall = e.currentTarget as DelayedCall;
			call.removeEventListener(Event.REMOVE_FROM_JUGGLER, onRemoveFromJuggler);
			calls.splice(calls.indexOf(call), 1);
		}
		
		public function scale3grid(name:String, firstRegion:int, secondRegion:int, direction:String = "horizontal", width:int = -1, height:int = -1, container:DisplayObjectContainer = null):Scale3Image
		{
			var image:Scale3Image = getScale3Grid(name, firstRegion, secondRegion, direction, width, height);
			if (!container) {
				container = this;
			}
			container.addChild(image);
			return image;
		}
		
		public function getScale3Grid(name:String, firstRegion:int, secondRegion:int, direction:String = "horizontal", width:int = -1, height:int = -1):Scale3Image
		{	
			var image:Scale3Image = new Scale3Image( new Scale3Textures(asset.getTexture(name), firstRegion, secondRegion, direction) );
			if (width != -1) image.width = width;
			if (height != -1) image.height = height;
			return image;
		}
		
		public function scale9grid(name:String, rect:Rectangle, width:int = -1, height:int = -1, container:DisplayObjectContainer = null):Scale9Image
		{	
			var image:Scale9Image = getScale9grid(name, rect, width, height);
			if (!container) {
				container = this;
			}
			container.addChild(image);
			return image;
		}
		
		public function getScale9grid(name:String, rect:Rectangle, width:int = -1, height:int = -1):Scale9Image
		{	
			var image:Scale9Image = new Scale9Image( new Scale9Textures(asset.getTexture(name), rect) );
			if (width != -1) image.width = width;
			if (height != -1) image.height = height;
			return image;
		}
		
		public function addBitmapFont(text:String, font:String, x:int = 0, y:int = 0, autoSize:String = null):TextField
		{
			if (autoSize == null) autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			
			var textFld:TextField = new TextField(10, 10, text, font, TextField.getBitmapFont(font).size, 0xFFFFFF);
			textFld.batchable = true;
			textFld.autoSize = autoSize;
			textFld.x = x;
			textFld.y = y;
			addChild(textFld);	
			return textFld;
		}
		
		public function getBitmapFont(text:String, font:String, color:uint = 0xFFFFFF):TextField
		{
			var textFld:TextField = new TextField(10, 10, text, font, TextField.getBitmapFont(font).size, color);
			textFld.batchable = true;
			textFld.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;	
			return textFld;
		}
		
	}

}