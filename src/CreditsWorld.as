package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image
	public class CreditsWorld extends World
	{
		[Embed(source = "../assets/images/back_button.png")] private const BACK_BUTTON:Class;
		[Embed(source = "../assets/images/phoneWithText.png")] private const BACKGROUND:Class;
		protected var _backbutton:Button;
		protected var title:TextEntity;
		protected var credits:TextEntity;
		public function CreditsWorld() 
		{
			addGraphic(new Image(BACKGROUND));
			_backbutton = new Button(backToMain, 20, FP.height - 50, 140, 20);
			_backbutton.addGraphic(new Image(BACK_BUTTON));
			add(_backbutton);
			
			title = new TextEntity(290, 120, "Credits", 36, 0xffffff);
			credits = new TextEntity(300, 210, "Team:\n -Alex Willison\n -Benjamin Shaibu\n -Laura Shih\n -Polina Shpilker\n -Tyler Laprade\n -Rohan Mahajan", 20, 0xffffff);
			add(title);
			add(credits);
		}
		
		public function backToMain():void
		{
			FP.world = new StartWorld();
		}
		
	}

}