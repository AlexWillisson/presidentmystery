package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Phone extends Entity {
		private const READ:uint = 0xffffff;
		private const UNREAD:uint = 0xf7941e;

		[Embed(source = "../assets/images/phone.png")] private const phone:Class;
		private var texts:Array;
		private var inboxTitle:TextEntity;

		public function Phone() {
			graphic = new Image(phone)
			x = 0;
			y = 0;

			texts = new Array();
			texts.push(new Message(300, 170, "VP", "8:38p", UNREAD));
			texts.push(new Message(300, 200, "Speaker", "4:32p", READ));
			texts.push(new Message(300, 230, "Mayor", "2:33p", READ));
			texts.push(new Message(300, 260, "Police", "Tues", READ));
			texts.push(new Message(300, 290, "Doctor", "Tues", READ));

			inboxTitle = new TextEntity(290, 120, "Inbox", 36, 0xffffff);
		}

		override public function added():void
		{
			world.add(inboxTitle);

			for (var idx:int = 0; idx < texts.length; idx++) {
				world.add(texts[idx]);
			}
		}

		override public function removed():void
		{
			world.remove(inboxTitle);

			for (var idx:int = 0; idx < texts.length; idx++) {
				world.remove(texts[idx]);
			}
		}
	}
}
