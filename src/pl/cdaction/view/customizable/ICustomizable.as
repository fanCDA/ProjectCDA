package pl.cdaction.view.customizable
{
	import flash.text.TextFormat;

	public interface ICustomizable
	{
		function getTextFormat() : TextFormat;
		function setTextFormat(value : TextFormat) : void;
		
		function getBgColour() : uint;
		function setBgColour(value : uint) : void;
	}
}