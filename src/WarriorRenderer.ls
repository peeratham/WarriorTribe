package
{
    import cocos2d.CCSprite;
    import cocos2d.CCSpriteFrame;
    import cocos2d.CCSpriteFrameCache;
    import cocos2d.CCNode;
    import Loom.GameFramework.AnimatedComponent;

    public class WarriorRenderer extends AnimatedComponent
    {
    	var parent:CCNode;
    	var frame:CCSpriteFrame;
        public var sprite:CCSprite;         ///< The sprite that the class must render.
    	var _texture:String;

    	public function WarriorRenderer(__texture:String, nodeParent:CCNode) //nodeParent is the layer we want to render our obj
    	{	
    		parent=nodeParent;
    		_texture = __texture;
    		// reuse the sprite frame in cache to create new sprite to be displayed so no need to pull it from file again
    		frame = CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(_texture);
    		sprite = CCSprite.createWithSpriteFrame(frame);

    	}

    	public function set x(value:Number):void
        {
            if(sprite)
                sprite.setPositionX(value);
        }

        public function set y(value:Number):void
        {
            if(sprite)
                sprite.setPositionY(value);
        }

         public function set scaleX(value:Number):void
        {
            if(sprite)
                sprite.setScaleX(value);
        }

        
        public function set scaleY(value:Number):void
        {
            if(sprite)
                sprite.setScaleY(value);
        }

        public function set texture(value:String):void
        {
            if(value != _texture)
            {
                _texture = value;

                var nextFrame = CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(_texture);
                if (nextFrame)
                    sprite.setDisplayFrame(nextFrame);
            }
        }

        //add sprite to the layer
        protected function onAdd():Boolean
        {
            if(!super.onAdd())
                return false;

            parent.addChild(sprite);

            return true;
        }


    }
}