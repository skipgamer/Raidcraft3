package Menu.Character 
{
	import Menu.Login.LoginBox;
	import Menu.MainMenu;
	import Menu.MenuButton;
	import net.flashpunk.World;
	import UI.SimpleText;
	
	/**
	 * ...
	 * @author skipgamer
	 */
	public class CreateCharacter extends World 
	{
		public var numberOfChars:int = 3;
		
		protected var mageSelect:CharacterSelect = new CharacterSelect(GC.GFX_SELECT_MAGE, 1, this);
		protected var rogueSelect:CharacterSelect = new CharacterSelect(GC.GFX_SELECT_ROGUE, 2, this);
		protected var warriorSelect:CharacterSelect = new CharacterSelect(GC.GFX_SELECT_WARRIOR, 3, this);
		
		public function CreateCharacter() 
		{
			add (new LoginBox());
			add (new MouseCursorEntity());
			add (new MenuButton("back", 5, MainMenu));
			
			add (new SimpleText(7, 2, "Create Character"));
			
			mageSelect = new CharacterSelect(GC.GFX_SELECT_MAGE, 1, this);
			rogueSelect = new CharacterSelect(GC.GFX_SELECT_ROGUE, 2, this);
			warriorSelect = new CharacterSelect(GC.GFX_SELECT_WARRIOR, 3, this);
			
			add (mageSelect);
			add (rogueSelect);
			add (warriorSelect);
		}
		
		public function SelectCharacter(_selected:Class):void
		{
			if (_selected == GC.GFX_SELECT_MAGE)
			{
				trace("mage selected");
			}
			if (_selected == GC.GFX_SELECT_ROGUE)
			{
				trace("rogue selected");
			}
			if (_selected == GC.GFX_SELECT_WARRIOR)
			{
				trace("warrior selected");
			}
		}
		
	}

}