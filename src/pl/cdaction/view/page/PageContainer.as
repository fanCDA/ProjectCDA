package pl.cdaction.view.page
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	public class PageContainer extends Sprite
	{
		private var _containerWidth : Number;
		private var _containerHeight : Number;
		
		private var _bg : Sprite;
		private var _tf : TextField;
		
		
		public function PageContainer(containerWidth : Number, containerHeight : Number)
		{
			_containerWidth = containerWidth;
			_containerHeight = containerHeight;
			
			init();
		}
		
		private function init():void
		{
			_bg = new Sprite();
			_bg.graphics.beginFill(0xCCCCCC);
			_bg.graphics.drawRect(0, 0, _containerWidth, _containerHeight);
			_bg.graphics.endFill();
			addChild(_bg);
			
			_tf = new TextField();
			_tf.width = _bg.width-1;
			_tf.height = _bg.height - 1;
			_tf.type = TextFieldType.INPUT;
			_tf.multiline = true;
			_tf.border = true;
			_tf.x = _tf.y = 1;
			addChild(_tf);
		}
	}
}