package
{
  import Loom.GameFramework.AnimatedComponent;
  import Loom.GameFramework.TickedComponent;
  import cocos2d.CCRect;
  import Loom.Graphics.Point2;

  public class WarriorController extends TickedComponent
  {
  	  private var mover:WarriorMover;
      public var spriteFrame:String = "";
      public var scaleX:Number = 1;
      public var scaleY:Number = 1;

      public var idleFrame:String = "hero_stand.png";

      public function WarriorController( _mover:WarriorMover) // tmxObj:CCDictionary)
      {
        mover = _mover;
      }

      override public function onTick():void
      {
      	if (Game.moveDirX == 0)
        {
          // If we're not holding down the stick, slow down.
          mover.velocityX = mover.velocityX * 0.75;
        }
        else
        {
          // Set the velocity gradually (this method works better for dpads)
          mover.velocityX += Game.moveDirX * 0.2;
      	}


		//for now our character is constant and not animated regardless of any actions
      	spriteFrame = idleFrame;

      }
  }

}