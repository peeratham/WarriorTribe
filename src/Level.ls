// THIS IS THE ENTRY POINT TO YOUR APPLICATION
// YOU DON'T WANT TO MESS WITH ANYTHING HERE
// UNLESS YOU KNOW WHAT YOU'RE DOING
package
{
    import cocos2d.Cocos2DGame;
    import cocos2d.Cocos2D;
    import cocos2d.CCLayer;
    import cocos2d.CCSprite;
    import cocos2d.CCScene;
    import cocos2d.CCScaledLayer;
    import cocos2d.ScaleMode;
    import cocos2d.CCTMXTiledMap;
    import cocos2d.CCTMXLayer;
    import cocos2d.CCTMXObjectGroup;
    import cocos2d.CCSpriteFrameCache;
    import cocos2d.CCDictionary;
    import cocos2d.CCArray;
    import cocos2d.CCPoint;
    import cocos2d.CCSize;
    import cocos2d.CCDirector;

    import Loom.GameFramework.AnimatedComponent;
    import Loom.GameFramework.LoomComponent;
    import Loom.GameFramework.LoomGroup;
    import Loom.GameFramework.LoomGameObject;

 

    import UI.Label;

    public class GameLevel extends CCScaledLayer
    {
        public var tmxFile:String;
        public var map:CCTMXTiledMap;

        public var game:Cocos2DGame;
        public var group:LoomGroup;

        protected var scene:CCScene;

        public var bgLayer:CCLayer;
        public var fgLayer:CCLayer;

        public var warrior:CCSprite;

        public var moverManager:WarriorMoverManager = new WarriorMoverManager();

        public function getScene():CCScene
        {
            return scene;
        }

        // Constructor
        public function GameLevel( gameInstance:Cocos2DGame, tmxFileName:String )
        {
            scaleMode = ScaleMode.FILL;
            designWidth = 1600;
            designHeight = 1600;
            tmxFile = tmxFileName;
            game = gameInstance;
            group = game.group;

            scene = CCScene.create();
            scene.addChild(this);


            map = CCTMXTiledMap.tiledMapWithTMXFile(tmxFile);
            map.reload = onMapReload;

            var bglayer = map.layerNamed("bg");
            moverManager.collisionLayers.push(bglayer);

            var fglayer = map.layerNamed("fg");
            moverManager.collisionLayers.push(bglayer);

            var collisionLayer = map.layerNamed("st");
            if(collisionLayer)
            {
                collisionLayer.setVisible(false);
            }


            fgLayer = CCLayer.create();
            addChild(fgLayer);
            fgLayer.addChild(map);


            //warrior = CCSprite.createFromFile("assets/logo.png");
            //addChild(warrior);

            //add warrior to the scene

            var objects:CCTMXObjectGroup = map.objectGroupNamed("oj");
            var startPoint:CCDictionary = objects.objectNamed("StartPoint");
            var objX:int = startPoint.valueForKey("x").toNumber();
            var objY:int = startPoint.valueForKey("y").toNumber();
            var objW:int = startPoint.valueForKey("width").toNumber();
            var objH:int = startPoint.valueForKey("height").toNumber();

            objX += objW / 2;
            objY += objH / 2;

            Console.print("warrior" + " on map at (" + objX + ", " + objY + "), size (" + objW + ", " + objH + ")");
                    

            var wo = addWarriorObject(objX, objY, objW, objH);
            var rend = wo.lookupComponentByName("renderer") as WarriorRenderer;
            var mover = wo.lookupComponentByName("mover") as WarriorMover;

            var controller = new WarriorController(mover);

            rend.addBinding("texture", "@controller.spriteFrame");
            rend.addBinding("scaleX", "@controller.scaleX");
            rend.addBinding("scaleY", "@controller.scaleY");
            wo.addComponent(controller, "controller");


       }

               protected function onMapReload():void
        {
            // Anything that needs to happen on a map live reload can go here
            moverManager.collisionLayers.clear();
            setLayerCollisionActive("bg", true);
            setLayerCollisionActive("fg", true);
        }

       public function addWarriorObject(x:int, y:int, w:int, h:int):LoomGameObject
        {
            var wo = new LoomGameObject();
            var spriteName:String = "block32.png";  //use base 32x32 to initialize obj

            var solidSizeX:int = w;
            var solidSizeY:int = h;

            var rend = new WarriorRenderer(spriteName, fgLayer);
            var mover = new WarriorMover(x, y, this.moverManager);

            mover.solidSizeX = solidSizeX;
            mover.solidSizeY = solidSizeY;

            rend.addBinding("x", "@mover.positionX");
            rend.addBinding("y", "@mover.positionY");

            wo.addComponent(rend, "renderer");
            wo.addComponent(mover, "mover");

            wo.initialize();

            return wo;

        }

        public function setLayerCollisionActive( layerName:String, layerActive:Boolean )
        {
            var layer = map.layerNamed(layerName);

            if (layer == null)
            {
                trace ("ERROR: Could not find layer '" + layerName + "' to set collision active");
                return;
            }

            if (layerActive)
            {
                if (!moverManager.collisionLayers.contains(layer))
                {
                    moverManager.collisionLayers.push(layer);
                }
            }
            else
            {
                if (moverManager.collisionLayers.contains(layer))
                {
                    moverManager.collisionLayers.remove(layer);
                }
            }
        }


       public function setCenterOfScreen(pos:CCPoint):void
       {    
            var screenSize:CCSize = CCDirector.sharedDirector().getWinSize();
            var x:int = Math.max(pos.x, screenSize.width/2);
            var y:int = Math.max(pos.y, screenSize.height/2);

            x = Math.min(x, map.getMapSize().width * map.getTileSize().width - screenSize.width/2);
            y = Math.min(y, map.getMapSize().height * map.getTileSize().height - screenSize.height/2);
            var goodPoint:CCPoint = new CCPoint(x,y);
            var centerOfScreen:CCPoint = new CCPoint(screenSize.width/2,screenSize.height/2);
            var diff:CCPoint = new CCPoint(centerOfScreen.x - goodPoint.x, centerOfScreen.y - goodPoint.y);
            this.setPosition(diff.x,diff.y);
       }


   }
}