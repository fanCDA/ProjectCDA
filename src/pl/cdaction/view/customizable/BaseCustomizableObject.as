package pl.cdaction.view.customizable
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import pl.cdaction.common.Constants;

	public class BaseCustomizableObject extends Sprite implements ICustomizable
	{
		protected var _containerWidth : Number;
		protected var _containerHeight : Number;
		
		protected var _bgColour : uint;
		protected var _bg : Sprite;
		protected var _tf : TextField;
		
		
		public function BaseCustomizableObject(containerWidth : Number, containerHeight : Number)
		{
			_containerWidth = containerWidth;
			_containerHeight = containerHeight;
			
			init();
		}
		
		protected function init():void
		{
			_bg = new Sprite();
			setBgColour( Constants.DEFAULT_BG_COLOUR );
			addChild(_bg);
			
			_tf = new TextField();
			_tf.name = "tfCustomizable";
			_tf.width = _bg.width-1;
			_tf.height = _bg.height - 1;
			_tf.type = TextFieldType.INPUT;
			_tf.multiline = true;
			_tf.border = true;
			_tf.x = _tf.y = 1;
			addChild(_tf);
		}
		
		public function getText() : String
		{
			return _tf.text;
		}
		
		
		public function getTextFormat() : TextFormat
		{
			return _tf.defaultTextFormat;
		}
		public function setTextFormat(value : TextFormat) : void
		{
			_tf.defaultTextFormat = value;
			_tf.setTextFormat(value);
		}
		
		public function getBgColour() : uint
		{
			return _bgColour;
		}
		public function setBgColour(value : uint) : void
		{
			_bgColour = value;
			_bg.graphics.clear();
			_bg.graphics.beginFill(_bgColour);
			_bg.graphics.drawRect(0, 0, _containerWidth, _containerHeight);
			_bg.graphics.endFill();
		}
	}
}