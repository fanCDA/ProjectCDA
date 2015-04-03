package pl.cdaction.view.grid
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import pl.cdaction.common.Constants;
	
	public class GridObjectHeader extends Sprite
	{
		private var _tfLeft : TextField;
		private var _tfRight : TextField;
		
		
		public function GridObjectHeader()
		{
			init();
		}
		
		private function init() : void
		{
			_tfLeft = new TextField();
			_tfLeft.width = Constants.GRID_OBJECT_WIDTH * 0.5;
			_tfLeft.height = 20;
			addChild(_tfLeft);
			
			_tfRight = new TextField();
			_tfRight.width = Constants.GRID_OBJECT_WIDTH * 0.5;
			_tfRight.height = 20;
			_tfRight.x = Constants.GRID_OBJECT_WIDTH - _tfRight.width;
			addChild(_tfRight);
			
			_tfLeft.selectable = _tfRight.selectable = false;
		}
		
		public function setLabels(labelLeft : String, labelRight : String) : void
		{
			_tfLeft.text = labelLeft;
			_tfRight.text = labelRight;
		}
	}
}