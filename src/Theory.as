package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Theory extends Entity {
		[Embed(source = "../assets/images/blank.png")] private const bg:Class;

		private var text:TextEntity, ctrls:TextEntity;
		private var _next:Entity;

		public function Theory(next:Entity) {
			graphic = new Image(bg)
			x = 0;
			y = 0;

			_next = next;
			text = new TextEntity(270, 150, "So much for that theory.", 22, 0xffffff);

			ctrls = new TextEntity(300, 400, "Press space to continue", 18, 0xffffff);
		}

		override public function update():void
		{
			if (Input.released(Key.SPACE)) {
				world.add(_next);
				world.remove(this);
			}
		}

		override public function added():void
		{
			world.add(text);
			world.add(ctrls);
		}

		override public function removed():void
		{
			world.remove(text);
			world.remove(ctrls);
		}
	}
}
