package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Phone extends Entity {
		private const READ:uint = 0xffffff;
		private const UNREAD:uint = 0xf7941e;

		[Embed(source = "assets/images/phone.png")] private const phone:Class;
		private var texts:Array, levels:Array;
		private var inboxTitle:TextEntity;
		private var msg0:PhoneMessage, msg1:PhoneMessage;
		private var wikiSplash:WikiSplash;
		private var wiki:WikiPage;
		private var theory:Theory;

		public function Phone(maps:Array) {
			graphic = new Image(phone)
			x = 0;
			y = 0;

			levels = maps;

			texts = new Array();
			texts[0] = new Message(300, 170, "???", "Now", UNREAD, txt0);
			// texts.push(new Message(300, 230, "Mayor", "2:33p", READ, vpMsg));
			// texts.push(new Message(300, 260, "Police", "Tues", READ, vpMsg));
			// texts.push(new Message(300, 290, "Doctor", "Tues", READ, vpMsg));

			inboxTitle = new TextEntity(290, 120, "Inbox", 36, 0xffffff);

			theory = new Theory(levels[0]);
			wiki = new WikiPage(theory);
			wikiSplash = new WikiSplash(wiki);

			msg0 = new PhoneMessage(this, "???", "It's been a while. If I'm\nright, you're in the\nhospital right now.\nYou need to leave.\n\nNow.", this);
			msg1 = new PhoneMessage(this, "???", "And yes, you were the\nPresident. We need\nto talk -- in person.", wikiSplash);
		}

		private function level0():void
		{
			world.add(levels[0]);
			world.remove(this);
		}

		private function txt0():void
		{
			world.add(msg0);
			world.remove(texts[0]);
			texts[0] = new Message(300, 170, "???", "10:33a", READ, txt0r);
			texts[1] = new Message(300, 200, "???", "Now", UNREAD, txt1);
			world.remove(this);
		}

		private function txt0r():void
		{
			world.add(msg0);
			world.remove(this);
		}

		private function txt1():void
		{
			world.add(msg1);
			world.remove(texts[1])
			texts[1] = new Message(300, 200, "???", "10:34a", READ, txt1r);
			world.remove(this);
		}

		private function txt1r():void
		{
			world.add(msg1);
			world.remove(this);
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
