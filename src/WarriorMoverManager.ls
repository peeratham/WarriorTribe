package
{
    import cocos2d.CCDictionary;
    import cocos2d.CCRect;
    import cocos2d.CCPoint;
    import cocos2d.CCSize;
    import cocos2d.CCTMXLayer;
    import Loom.Graphics.Point2;
    import Loom.GameFramework.TimeManager;

    public class WarriorMoverManager
    {
        [Inject]
        public var timeManager:TimeManager;

        public static var _collisionLayers:Vector.<CCTMXLayer> = new Vector.<CCTMXLayer>();
        public function get collisionLayers():Vector.<CCTMXLayer> 
        {
        return _collisionLayers;
        }
    

    public function warriorMoverManager()
    {
        
    }

    protected var _warriorObjectList:Vector.<WarriorMover> = new Vector.<WarriorMover>();
    public function get warriorObjectList():Vector.<WarriorMover> 
    {
        return _warriorObjectList;
    }

    public function collide( obj:WarriorMover ):void
    {
        var cnt:int;
        var otherObj:WarriorMover;
        var mapLayer:CCTMXLayer;

        mapLayer = _collisionLayers[0]; //only have one collision layer for now
        if (mapLayer != null)
            {
                collideMapVsObj(mapLayer, obj);
            }

        //might compare it against other warrior object later


    }

    public function collideMapVsObj(mapLayer:CCTMXLayer, obj:WarriorMover, resolveCollision:Boolean = true ):Boolean 
    {
        var colliding:Boolean = false;


        return colliding;
    }


    public function tileCoordForPosition( mapLayer:CCTMXLayer, x:Number, y:Number):Point2 
    {
        var mapSize = mapLayer.getLayerSize();
        var tileSize = mapLayer.getMapTileSize();

        var retVal:Point2 = new Point2();
        retVal.x = Math.floor(x / tileSize.width);
        retVal.y = Math.floor(((mapSize.height * tileSize.height) - y) / tileSize.height);

        return retVal;
    }
}
  
}