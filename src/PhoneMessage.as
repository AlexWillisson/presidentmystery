package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PhoneMessage extends Entity {
		private const READ:uint = 0xffffff;
		private const UNREAD:uint = 0xf7941e;

		[Embed(source = "assets/images/phoneWithText.png")] private const phoneBg:Class;
		private var personName:TextEntity, text:TextEntity;
		private var phone:Phone;
		private var _next:Entity;

		public function PhoneMessage(parent:Phone, sender:String, body:String, next:Entity) {
			graphic = new Image(phoneBg)
			x = 0;
			y = 0;

			_next = next;
			phone = parent;
			personName = new TextEntity(290, 120, sender, 36, 0xffffff);
			text = new TextEntity(305, 215, body, 18, 0xffffff);
		}

		override public function update():void
		{
			if (Input.released(Key.ESCAPE) || Input.released(Key.SPACE)) {
				world.remove(this);
			}
		}

		override public function added():void
		{
			world.add(personName);
			world.add(text);
			world.remove(phone);
		}

		override public function removed():void
		{
			world.add(_next);
			world.remove(personName);
			world.remove(text);
		}
	}
}
