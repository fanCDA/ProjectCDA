package pl.cdaction.view
{
	import flash.display.Sprite;
	
	import pl.cdaction.common.Constants;
	
	public class GridObject extends Sprite
	{
		private var _index : int;
		
		private var _bg : Sprite;
		private var _header : GridObjectHeader;
		
		
		public function GridObject( index : int )
		{
			_index = index;
			
			init();
		}
		
		private function init():void
		{
			_bg = new Sprite();
			_bg.graphics.beginFill(0xEEEEEE);
			_bg.graphics.drawRect(0, 0, Constants.GRID_OBJECT_WIDTH, Constants.GRID_OBJECT_HEIGHT);
			_bg.graphics.endFill();
			addChild(_bg);
			
			_header = new GridObjectHeader();
			_header.setLabels( (2*_index + 1).toString(), (2*_index + 2).toString() );
			addChild(_header);
		}
	}
}