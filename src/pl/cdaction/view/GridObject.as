package pl.cdaction.view
{
	import flash.display.Sprite;
	
	public class GridObject extends Sprite
	{
		public function GridObject()
		{
			var gridObj : Sprite = new Sprite();
			gridObj.graphics.beginFill(0x000000);
			gridObj.graphics.drawRect(0, 0, 160, 160);
			gridObj.graphics.endFill();
			
			addChild(gridObj);
		}
	}
}