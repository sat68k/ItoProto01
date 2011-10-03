emo.Runtime.import("physics.nut");
emo.Runtime.import("bg.nut");


//===================================================
// Global work
//===================================================
work <-
{
	physics = null,
	world = null,
}



//===================================================
// Main Class
//===================================================
class Main
{
	physics = null;
	world = null;
	bg = null;

	ballFixture = null;
	ballDef = null;

	boxes = [];
	obj1 = null;
	stX = 0;
	stY = 0;
	rope = null;

	mouseJoint = null;
	mouseJointDef = null;

	//===================================================
	// onLoad
	//===================================================
	function onLoad()
	{
		print("onLoad"); 
//		emo.Runtime().setOptions(OPT_ORIENTATION_LANDSCAPE);

		::work.physics = emo.Physics();
		physics = ::work.physics;

		::work.world = emo.physics.World( emo.Vec2(0,10), true );
		world = ::work.world;

		bg = Bg();
		bg.load();

		obj1 = emo.Rectangle();
		obj1.move( 100, 40 );
		obj1.color(1, 0, 0, 1);
		obj1.setSize(50, 50);
		obj1.load();

		rope = emo.Line();
		rope.load();
		rope.hide();


		ballFixture = emo.physics.FixtureDef();
		ballFixture.density  = 1.0;
		ballFixture.friction = 0.3;
		ballFixture.restitution = 0.2;

		// the balls won't sleep
		ballDef = emo.physics.BodyDef();
		ballDef.allowSleep = false;

		local box1 = AddBox( 50, 50 );
		emo.Event().enableOnDrawCallback( 1000.0 / 60.0 );
		emo.Stage().interval( 1000.0 / 60.0 );

		mouseJointDef = emo.physics.MouseJointDef();
		mouseJointDef.bodyA = world.getGroundBody();
		mouseJointDef.bodyB = box1.getBody();
		mouseJointDef.maxForce = 50;

	}


	//===================================================
	// AddBox
	//===================================================
	function AddBox( x, y )
	{
		local box = emo.Rectangle();
		box.setSize( 20, 20 );
		box.load();
		box.move( x, y );

		local dSprite = physics.createDynamicSprite
		(
			world, box, ballFixture, ballDef
		);
		boxes.append( dSprite.body );

		print("AddBox");
		print(boxes[0]);
		return dSprite;
	}


	//===================================================
	// onGainedFocus
	//===================================================
	function onGainedFocus()
	{
		print("onGainedFocus");
	}


	//===================================================
	// onLostFocus
	//===================================================
	function onLostFocus()
	{
		print("onLostFocus"); 
	}


	//===================================================
	// onDispose
	//===================================================
	function onDispose()
	{
		print("onDispose");
	}


	//===================================================
	// onMotionEvent
	//===================================================
	function onMotionEvent( mevent )
	{
		local x = mevent.getX();
		local y = mevent.getY();
		if( mevent.getAction() == MOTION_EVENT_ACTION_DOWN )
		{
			mouseJointDef.target = world.getWorldCoord(mevent.getX(), mevent.getY());
			mouseJoint = world.createJoint(mouseJointDef);
			stX = x;
			stY = y;
		}
		else if( mevent.getAction() == MOTION_EVENT_ACTION_MOVE )
		{
			mouseJoint.setTarget(world.getWorldCoord(mevent.getX(), mevent.getY()));
//			obj1.moveCenter( x, y );
//			print( boxes[0].setTransform( emo.Vec2(3,10), 0.0 ) );
//			print( boxes[0].getPosition().x+","+boxes[0].getPosition().y );
			rope.show();
			rope.move( stX, stY, x, y );
		}
		else if( mevent.getAction() == MOTION_EVENT_ACTION_UP ||
				 mevent.getAction() == MOTION_EVENT_ACTION_CANCEL )
		{
			world.destroyJoint(mouseJoint);
			mouseJoint = null;
			rope.hide();
		}
	}


	//===================================================
	// onDrawFrame
	//===================================================
	function onDrawFrame( dt )
	{
		world.step( dt / 1000.0, 5, 2 );
		world.clearForces();
	}
}


//===================================================
// onLoad
//===================================================
function emo::onLoad()
{
	emo.Stage().load( Main() );
}
