package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Intro extends Entity {
		[Embed(source = "assets/images/blank.png")] private const bg:Class;

		private var text:TextEntity, ctrls:TextEntity;
		private var _callback:Function;

		public function Intro(callback:Function) {
			graphic = new Image(bg)
			x = 0;
			y = 0;

			_callback = callback;
			text = new TextEntity(50, 150, "You wake up... you're in a hospital. No one is around, and you don't\nremember how you got here. You roll over, and see a phone on the\nbedside table. It says 'Property of Jack Craine, US President' on the\nback. You pick it up, and reflexively key in the combination. How\ndid you do that? It's your name, and must be your phone, but you\ndon't remember being President...", 22, 0xffffff);

			ctrls = new TextEntity(300, 400, "Press space to continue", 18, 0xffffff);
		}

		override public function update():void
		{
			if (Input.released(Key.SPACE)) {
				_callback();
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
