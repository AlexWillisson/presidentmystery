package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;

	public class TextEntity extends Entity {
		[Embed(source = "../assets/fonts/Ubuntu-B.ttf", embedAsCFF="false", fontFamily = "UbuntuB")] private const UbuntuB:Class;

		public function TextEntity(posX:int, posY:int, text:String,
			textSize:int, textColor:uint)
		{
			Text.font = "UbuntuB";

			graphic = new Text(text, posX, posY,
				{size: textSize, color: textColor});
		}
	}
}
