import teilchen.*; 
import teilchen.behavior.*; 
import teilchen.constraint.*; 
import teilchen.cubicle.*; 
import teilchen.force.*; 
import teilchen.integration.*; 
import teilchen.util.*; 
/*
 * this sketch demonstrates how to create and handle multiple particles and remove individual
 * particles.
 *
 * drag mouse to spawn particles.
 */

Physics mPhysics;
Attractor  blackHole;
Wander mWander;

Motor mMotor;

void settings() {
  size(1000, 1000);
}

void setup() {
  /* create a particle system */
  mPhysics = new Physics();
  Teleporter mTeleporter = new Teleporter();
  mTeleporter.min().set(0, 0);
  mTeleporter.max().set(width, height);
  mPhysics.add(mTeleporter);
  mWander=new Wander();
  for (int i = 0; i < 1000; i++) {
    BehaviorParticle mParticle = mPhysics.makeParticle(BehaviorParticle.class);
    mParticle.position().set(random(width), random(height));
    mParticle.maximumInnerForce(100);
    mParticle.mass(random(1.0f, 5.0f));
    //creating behavior
    mMotor=new Motor();
    mMotor.auto_update_direction(true);
    //motor is the gas put into the pedal
    mMotor.strength(1);
    mParticle.behaviors().add(mMotor);
  }
  blackHole=new Attractor();
  int size=150;
  int attractStrength=2000;
  blackHole.radius(size);
  blackHole.strength(attractStrength);
  blackHole.position().set(width/2, height/2);
  mPhysics.add(blackHole);
}

void draw() {
  //update particle system:
  float changeInTime=1.0/frameRate;
  mPhysics.step(changeInTime);
  background(255);

  /*draw hot gorl*/
  fill(255);
  stroke(0, 63);
  strokeWeight(1.0f);
  ellipse(blackHole.position().x, blackHole.position().y, blackHole.radius(), blackHole.radius());

  /* draw all the particles in particle system */





  for (int i = 0; i< mPhysics.particles().size(); i++) {

    Particle myParticle = mPhysics.particles(i);
    if ((myParticle.position().x<(width/2+30) && myParticle.position().x>(width/2-30) 
      && (myParticle.position().y<(height/2+30) && myParticle.position().y>(height/2-30)))) {
      fill(0);
      noStroke();
      ellipse(myParticle.position().x, myParticle.position().y, 5, 5);
      noStroke();
    } else
      if (i==0) {
        fill(#EEF222);
        Attractor sunny=new Attractor();
        ellipse(myParticle.position().x, myParticle.position().y, 100, 100);
        sunny.position().set(myParticle.position().x, myParticle.position().y);
        sunny.strength(50);
        sunny.radius(10000);
      } else if (i%2==0 && i<20) {
        fill(#3542AF);
        ellipse(myParticle.position().x, myParticle.position().y, 50, 50);
      } else {
        fill(#838489);
        ellipse(myParticle.position().x, myParticle.position().y, 10, 10);
      }
  }
}
