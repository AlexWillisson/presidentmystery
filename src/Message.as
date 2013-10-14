package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;

	public class Message extends Entity {
		[Embed(source = "../assets/fonts/Ubuntu-B.ttf", embedAsCFF="false", fontFamily = "UbuntuB")] private const UbuntuB:Class;

		private var sender:TextEntity, time:TextEntity, btn:Button;

		public function Message(posX:int, posY:int, senderName:String,
			timestamp:String, textColor:uint, callback:Function)
		{
			Text.font = "UbuntuB";

			sender = new TextEntity(posX, posY, senderName, 22, textColor);
			time = new TextEntity(posX + 155, posY + 5, timestamp,
				12, textColor);
			btn = new Button(callback, posX - 10, posY, 205, 30);
		}

		override public function added():void
		{
			world.add(sender);
			world.add(time);
			world.add(btn);
		}

		override public function removed():void
		{
			world.remove(sender);
			world.remove(time);
			world.remove(btn);
		}
	}
}
