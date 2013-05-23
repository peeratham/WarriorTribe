package
{
//my version
//update some more
//change from karnuva
    import cocos2d.Cocos2DGame;
    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCLayer;
    import cocos2d.ScaleMode;
    import cocos2d.CCSpriteFrameCache;
    import cocos2d.CCDirector;
    import cocos2d.CCTMXTiledMap;
    import Loom.Platform.LoomKey;

    import UI.Label;

    public class Game extends Cocos2DGame
    {

        public var level:GameLevel = null;
        public var isTouching:Boolean;
        public static var moveDirX = 0.0;
        public static var moveDirY = 0.0;

        override public function run():void
        {
            // Comment out this line to turn off automatic scaling.
            layer.scaleMode = ScaleMode.LETTERBOX;

            super.run();

            //load sprite sheet
            CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile(
                "assets/sprites/PlatformerSprites.plist", 
                "assets/sprites/PlatformerSprites.png");


            var startingLevel = "assets/BuckysMap.tmx";
            level = new GameLevel(this, startingLevel);
            CCDirector.sharedDirector().replaceScene(level.getScene());

                       // Also listen to the keyboard.
            level.setKeypadEnabled(true);
            level.onKeyDown += handleKeyDown;
            level.onKeyUp += handleKeyUp;

        }


                public var leftKeyFlag:Boolean = false;
        public var rightKeyFlag:Boolean = false;

        protected function handleKeyDown(keycode:int):void
        {
            if(keycode == LoomKey.A)
                leftKeyFlag = true;
            if(keycode == LoomKey.D)
                rightKeyFlag = true;
            recalculateKeyInput()
        }

        protected function handleKeyUp(keycode:int):void
        {
            if(keycode == LoomKey.A)
                leftKeyFlag = false;
            if(keycode == LoomKey.D)
                rightKeyFlag = false;
            recalculateKeyInput()
        }

        protected function recalculateKeyInput():void
        {
            if((leftKeyFlag && rightKeyFlag)
               || (!leftKeyFlag && !rightKeyFlag))
                moveDirX = 0;
            else if(leftKeyFlag)
                moveDirX = -1;
            else if(rightKeyFlag)
                moveDirX = 1;
            else
                moveDirX = 0;
        }
    }
}