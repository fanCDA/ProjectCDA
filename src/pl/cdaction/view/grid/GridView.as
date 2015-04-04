package pl.cdaction.view.grid
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import pl.cdaction.common.Constants;
	
	public class GridView extends Sprite
	{
		private var _gridItems : Vector.<GridObject>;
		private var _isDragging : Boolean;
		private var _obj : Sprite;
		private var _startPos : Point;
		
		
		public function GridView()
		{
			init();
		}
		
		private function init() : void
		{
			_gridItems = new Vector.<GridObject>();
			_isDragging = false;
			_startPos = new Point();
			
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}
		
		protected function handleAddedToStage(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function addNew() : void
		{
			var gridObj : GridObject = new GridObject( _gridItems.length );
			
			var totalItems : int = _gridItems.length;
			var itemsInRow : int = Math.floor( stage.stageWidth / (Constants.GRID_OBJECT_WIDTH + Constants.GRID_ITEMS_GAP) );
			
			gridObj.x = (totalItems % itemsInRow) * (Constants.GRID_OBJECT_WIDTH + Constants.GRID_ITEMS_GAP);
			gridObj.y = Math.floor( totalItems / itemsInRow ) * (Constants.GRID_OBJECT_HEIGHT + Constants.GRID_ITEMS_GAP);
			addChild(gridObj);
			
			_gridItems.push(gridObj);
			
			gridObj.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}		
		
		public function handleResize() : void
		{
			if(_gridItems.length > 0)
			{
				var itemsInRow : int = Math.floor( stage.stageWidth / (Constants.GRID_OBJECT_WIDTH + Constants.GRID_ITEMS_GAP) );
				
				var i : int = 0;
				for each(var gridObj : GridObject in _gridItems)
				{
					gridObj.x = (i % itemsInRow) * (Constants.GRID_OBJECT_WIDTH + Constants.GRID_ITEMS_GAP);
					gridObj.y = Math.floor( i / itemsInRow ) * (Constants.GRID_OBJECT_HEIGHT + Constants.GRID_ITEMS_GAP);
					gridObj.updateIndex( i );
					i++;
				}
			}
		}
		
		
		protected function onMouseDown(event : MouseEvent) : void
		{
			if(event.target.name == "header")
			{
				startDraggingGridObject( event.currentTarget as Sprite );
			}
		}
		
		private function startDraggingGridObject(obj : Sprite) : void
		{
			_obj = obj;
			_obj.mouseEnabled = _obj.mouseChildren = false;
			_obj.alpha = 0.4;
			_startPos.x = _obj.x;
			_startPos.y = _obj.y;
			addChild(_obj);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_isDragging = true;
		}
		
		private function stopDraggingGridObject() : void
		{
			var currIndex : int = _gridItems.indexOf(_obj);
			if(_gridItems.length == 1 || currIndex == -1)
			{
				_obj.x = _startPos.x;
				_obj.y = _startPos.y;
			}
			else
			{
				var itemsInRow : int = Math.floor( stage.stageWidth / (Constants.GRID_OBJECT_WIDTH + Constants.GRID_ITEMS_GAP) );
				var destX : int = Math.floor( this.mouseX / (Constants.GRID_OBJECT_WIDTH + Constants.GRID_ITEMS_GAP) );
				var destY : int = Math.floor( this.mouseY / (Constants.GRID_OBJECT_HEIGHT + Constants.GRID_ITEMS_GAP) );
				var destIndex : int = destY * itemsInRow + destX;
				
				if(currIndex == destIndex)
				{
					_obj.x = _startPos.x;
					_obj.y = _startPos.y;
				}
				else
				{
					_gridItems.splice( currIndex, 1 );
					_gridItems.splice( destIndex, 0, _obj );
					
					handleResize();
				}
			}
			
			_obj.mouseEnabled = _obj.mouseChildren = true;
			_obj.alpha = 1;
			_obj = null;
		}
		
		protected function onEnterFrame(event : Event) : void
		{
			_obj.x = this.mouseX;
			_obj.y = this.mouseY;
		}
		
		
		protected function onMouseUp(event : MouseEvent) : void
		{
			if(_isDragging)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				_isDragging = false;
				
				if(_obj)
				{
					stopDraggingGridObject();
				}
			}
		}
	}
}