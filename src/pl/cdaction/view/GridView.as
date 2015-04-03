package pl.cdaction.view
{
	import flash.display.Sprite;
	
	public class GridView extends Sprite
	{
		private static const ITEMS_GAP	: Number = 5;
		
		private var _gridItems : Vector.<GridObject>;
		
		
		public function GridView()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			_gridItems = new Vector.<GridObject>();
		}
		
		public function addNew() : void
		{
			var gridObj : GridObject = new GridObject( _gridItems.length );
			
			var totalItems : int = _gridItems.length;
			var itemsInRow : int = Math.floor( stage.width / (gridObj.width + ITEMS_GAP) );
			
			gridObj.x = (totalItems % itemsInRow) * (gridObj.width + ITEMS_GAP);
			gridObj.y = Math.floor( totalItems / itemsInRow ) * (gridObj.height + ITEMS_GAP);
			addChild(gridObj);
			
			_gridItems.push(gridObj);
		}
		
		
		public function handleResize() : void
		{
			if(_gridItems.length > 0)
			{
				var itemsInRow : int = Math.floor( stage.width / (_gridItems[0].width + ITEMS_GAP) );
				
				var i : int = 0;
				for each(var gridObj : GridObject in _gridItems)
				{
					gridObj.x = (i % itemsInRow) * (gridObj.width + ITEMS_GAP);
					gridObj.y = Math.floor( i / itemsInRow ) * (gridObj.height + ITEMS_GAP);
					i++;
				}
			}
		}
	}
}