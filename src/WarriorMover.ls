// THIS IS THE ENTRY POINT TO YOUR APPLICATION
// YOU DON'T WANT TO MESS WITH ANYTHING HERE
// UNLESS YOU KNOW WHAT YOU'RE DOING
package
{   
    import Loom.GameFramework.AnimatedComponent;
    import Loom.GameFramework.TickedComponent;
    import cocos2d.CCRect;
    import cocos2d.CCTMXLayer;
    import Loom.Graphics.Point2;
    import Loom.GameFramework.TimeManager;



    public class WarriorMover extends TickedComponent
    {
        public var manager:WarriorMoverManager
        public var positionX:Number = 0;
        public var positionY:Number = 0;
        public var velocityX:Number = 0;
        public var velocityY:Number = 0;
        public var solidSizeX:Number = 32;
        public var solidSizeY:Number = 32;
        public var gravityX:Number = 0;
        public var gravityY:Number = -0.5;
        public var velocityMaxX:Number = 5;
        public    var velocityMaxY:Number = 10;

        public var collisionSlope:Number = 0;
        public var dest:CCRect;


        public function WarriorMover(x:Number, y:Number, warriorManager:WarriorMoverManager )
        {
            positionX = x;
            positionY = y;

            manager = warriorManager;
        }

        protected function onAdd():Boolean
        {
            if(!super.onAdd())
                return false;

            if (manager != null)
                manager.warriorObjectList.push(this);

         return true;
        }


        override public function onTick():void
        {
            // Acceleration due to gravity
            //velocityY += gravityY;
            //velocityX += gravityX;

            // Clamp velocity to min / max
            velocityX = Math.clamp( velocityX, 0-velocityMaxX, velocityMaxX );
            velocityY = Math.clamp( velocityY, 0-velocityMaxY, velocityMaxY );


            positionX += velocityX;
            positionY += velocityY;

            manager.collide(this);


            //update position of our dude
            //positionX = dest.getMidX(); 
            //positionY = dest.getMidY();

        }
        


    }
}