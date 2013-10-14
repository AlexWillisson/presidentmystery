package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Splash extends Entity {
		[Embed(source = "assets/images/blank.png")] private const bg:Class;

		private var text:TextEntity;

		public function Splash() {
			graphic = new Image(bg)
			x = 0;
			y = 0;

			text = new TextEntity(240, 200, "President Mystery", 36, 0xffffff);
		}

		override public function added():void
		{
			world.add(text);
		}

		override public function removed():void
		{
			world.remove(text);
		}
	}
}
