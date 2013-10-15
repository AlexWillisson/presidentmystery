package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class WikiPage extends Entity {
		[Embed(source = "../assets/images/wiki.png")] private const page:Class;

		private var ctrls:TextEntity;
		private var next:Theory;

		public function WikiPage(theory:Theory) {
			graphic = new Image(page)
			x = 0;
			y = 0;

			next = theory;
			ctrls = new TextEntity(300, 550, "Press space to continue", 18, 0xffffff);
		}

		override public function update():void
		{
			if (Input.released(Key.SPACE)) {
				world.add(next);
				world.remove(this);
			}
		}

		override public function added():void
		{
			world.add(ctrls);
		}

		override public function removed():void
		{
			world.remove(ctrls);
		}
	}
}
