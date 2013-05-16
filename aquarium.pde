// the nature of overfishing
// a processing.js aquarium that shows how fish populations have changed over 100 years
// by Sam Slover, for NYU ITP, in the spring of 2013
// much credit goes to the incredible work of Dan Shiffman at www.natureofcode.com

// set the visualization sketch to the size of the window
var screenWidth = window.innerWidth;
var screenHeight = window.innerHeight;

ArrayList<Bubble> bubbles;
int numOfBubbles; // we will determine number of bubbles based on screensize in the startBubbles function

// arraylist for the coral
ArrayList<Coral> corals;

School bigFish;
School smallFish1;
School smallFish2;
School smallFish3;
PShape[] fishShape;

// the number of fish that we start with - will base it on screensize in setup function
float numOfBf; 
float numOfSf;

void setup() {
  size(screenWidth, screenHeight);
  //in js mode,  set the background to transparent initially. we'll do it with the webpage CSS.
  background(0, 0, 0, 0);
  numOfBf = screenWidth/80;
  numOfSf = screenWidth/10;
  bubbles = new ArrayList<Bubble>();
  startBubbles();
  corals = new ArrayList<Coral>();
  loadCoral();
  fishShape = new PShape [6];
  loadFish();
  smooth();
  console.log(screenWidth + " " + screenHeight);
}

void draw() {  
  background(52, 152, 219);
  showCoral();
  updateBubbles();
  smallFish1.run();
  bigFish.run();
  smallFish2.run();
  smallFish3.run();
  removeFish();
}

void startBubbles() {
  numOfBubbles = (int) screenWidth/80;
  for (int i=0; i<numOfBubbles; i++) {
    // let's introduce some randomness for the bubbles
    float bubSize = (screenWidth/40) + random(screenWidth/(-40), screenWidth/50);  
    float bubY = random(screenHeight/80, screenHeight+50); 
    bubbles.add(new Bubble(bubSize, new PVector(i*screenWidth/numOfBubbles, bubY)));
  }
}

void updateBubbles() {
  float xOfLast = 0; //what was the X of the bubble leaving?
  for (int i = bubbles.size()-1; i >= 0; i--) {
    Bubble b = (Bubble) bubbles.get(i);
    // the bubbles need a water force
    // Magnitude is coefficient * speed squared
    float speed = b.velocity.mag();
    float dragMagnitude = 0.1 * speed * speed;

    // Direction is inverse of velocity
    PVector dragForce = b.velocity.get();
    dragForce.mult(-1);

    // Scale according to magnitude
    // dragForce.setMag(dragMagnitude);
    dragForce.normalize();
    dragForce.mult(dragMagnitude);    
    b.applyForce(dragForce);  
    b.run();
    if (b.isDead()) {
      xOfLast = b.location.x;
      bubbles.remove(i);
    }
  }
  // if we lost a bubble, well let's add another!)
  if (bubbles.size()<numOfBubbles) {
    float bubSize = (screenWidth/170) + random(screenWidth/(-50), screenWidth/50);
    float bubY = screenHeight + random(screenHeight/(-70), screenHeight/70); 
    bubbles.add(new Bubble(bubSize, new PVector(xOfLast, bubY)));
  }
}

void loadCoral() {
  //first, we load the coral images with an array
  PShape[] coralShape = new PShape [7];
  for (int i = 0; i < coralShape.length; i++) {
    coralShape[i] = loadShape("coral"+ i + ".svg");
  }
  //then, let's bring them into the array
  int numOfCoral= (int) screenWidth/100;
  for (int i=0; i<numOfCoral; i++) {
    int ran = (int) random(coralShape.length);
    int sizeRan = (int) random(2, 6);
    corals.add(new Coral(coralShape[ran], i*screenWidth/numOfCoral, screenHeight-(screenHeight/sizeRan), screenHeight/sizeRan, screenHeight/sizeRan));
  }
}

void showCoral() {
  for (int i = corals.size()-1; i >= 0; i--) {
    Coral c = (Coral) corals.get(i);
    c.display();
  }
}


void loadFish() {
  //first, we load the fish images with an array
  for (int i = 0; i < fishShape.length; i++) {
    fishShape[i] = loadShape("fish"+ i + ".svg");
  }
  // now, creates the schools
  bigFish = new School();
  smallFish1 = new School();
  smallFish2 = new School();
  smallFish3 = new School();
  for (int i = 0; i<numOfBf; i++) {
    int ran = (int) random(0, 3);
    int ranCol = (int) random(-10, 10);
    Fish f = new Fish(fishShape[ran], 10+ranCol, 43+ranCol, 115+ranCol, 21, screenHeight/4, i*screenWidth/numOfBf, random(21, screenHeight/2), 0.2, 0, 0, 10, 4, false, 0.05);
    bigFish.addFish(f);
  }
  int sfDivisor = (int) numOfSf/3;
  for (int i = 0; i<sfDivisor; i++) {
    int ran = (int) random(3, 6);
    int ranCol = (int) random(-10, 10);
    Fish f = new Fish(fishShape[ran], 217+ranCol, 59+ranCol, 88+ranCol, 21, screenHeight/50, random(21, screenWidth/4), random(0, screenHeight/2), 3.0, 0.8, 1.2, 8, 25, true, 0.2);
    smallFish1.addFish(f);
  }
  for (int i = 0; i<sfDivisor; i++) {
    int ran = (int) random(3, 6);
    int ranCol = (int) random(-10, 10);
    Fish f = new Fish(fishShape[ran], 217+ranCol, 59+ranCol, 88+ranCol, 21, screenHeight/50, random(21, screenWidth/4), random(0, screenHeight/2), 3.0, 0.8, 1.2, 8, 25, true, 0.2);
    smallFish2.addFish(f);
  }
  for (int i = 0; i<sfDivisor; i++) {
    int ran = (int) random(3, 6);
    int ranCol = (int) random(-10, 10);
    Fish f = new Fish(fishShape[ran], 217+ranCol, 59+ranCol, 88+ranCol, 21, screenHeight/50, random(21, screenWidth/4), random(0, screenHeight/2), 3.0, 0.8, 1.2, 8, 25, true, 0.2);
    smallFish3.addFish(f);
  }
}

void updateFish(int sliderValue) {

  //compute the fish for that year based on the data and screensize
  float bf1920 = numOfBf; 
  float sf1920 = numOfSf;
  for (int year=0; year<=9; year++) {
    bf1920 = bf1920 * 0.998;
    sf1920 = sf1920 * 1.0085;
  }

  float bf1930 = bf1920;
  float sf1930 = sf1920;
  for (int year=0; year<=9; year++) {
    bf1930 = bf1930 * 0.998;
    sf1930 = sf1930 * 1.0085;
  }

  float bf1940 = bf1930;
  float sf1940 = sf1930;
  for (int year=0; year<=9; year++) {
    bf1940 = bf1940 * 0.998;
    sf1940 = sf1940 * 1.0085;
  }

  float bf1950 = bf1940;
  float sf1950 = sf1940;
  for (int year=0; year<=9; year++) {
    bf1950 = bf1950 * 0.998;
    sf1950 = sf1950 * 1.0085;
  }

  float bf1960 = bf1950;
  float sf1960 = sf1950;
  for (int year=0; year<=9; year++) {
    bf1960 = bf1960 * 0.998;
    sf1960 = sf1960 * 1.0085;
  }

  float bf1970 = bf1960;
  float sf1970 = sf1960;
  for (int year=0; year<=9; year++) {
    bf1970 = bf1970 * 0.998;
    sf1970 = sf1970 * 1.0085;
  }

  float bf1980 = bf1970;
  float sf1980 = sf1970;
  for (int year=0; year<=9; year++) {
    bf1980 = bf1980 * 0.96;
    sf1980 = sf1980 * 1.0085;
  }

  float bf1990 = bf1980;
  float sf1990 = sf1980;
  for (int year=0; year<=9; year++) {
    bf1990 = bf1990 * 0.96;
    sf1990 = sf1990 * 1.0085;
  }

  float bf2000 = bf1990;
  float sf2000 = sf1990;
  for (int year=0; year<=9; year++) {
    bf2000 = bf2000 * 0.971;
    sf2000 = sf2000 * 1.0085;
  }

  float bf2010 = bf2000;
  float sf2010 = sf2000;
  for (int year=0; year<=9; year++) {
    bf2010 = bf2010 * 0.971;
    sf2010 = sf2010 * 1.0085;
  }

  float currentBF = bigFish.fishes.size();
  float currentSF = smallFish1.fishes.size() + smallFish2.fishes.size() + smallFish3.fishes.size();

  float desiredBF = numOfBf;
  float desiredSF = numOfSf;

  if (sliderValue == 1910) {
    desiredBF = floor(numOfBf);
    desiredSF = numOfSf;
  }
  else if (sliderValue == 1920) {
    desiredBF = floor(bf1920);
    desiredSF = sf1920;
  }
  else if (sliderValue == 1930) {
    desiredBF = floor(bf1930);
    desiredSF = sf1930;
  }
  else if (sliderValue == 1940) {
    desiredBF = floor(bf1940);
    desiredSF = sf1940;
  }
  else if (sliderValue == 1950) {
    desiredBF = floor(bf1950);
    desiredSF = sf1950;
  }
  else if (sliderValue == 1960) {
    desiredBF = floor(bf1960);
    desiredSF = sf1960;
  }
  else if (sliderValue == 1970) {
    desiredBF = floor(bf1970);
    desiredSF = sf1970;
  }
  else if (sliderValue == 1980) {
    desiredBF = floor(bf1980);
    desiredSF = sf1980;
  }
  else if (sliderValue == 1990) {
    desiredBF = floor(bf1990);
    desiredSF = sf1990;
  }
  else if (sliderValue == 2000) {
    desiredBF = floor(bf2000);
    desiredSF = sf2000;
  }
  else if (sliderValue == 2010) {
    desiredBF = floor(bf2010);
    desiredSF = sf2010;
  }
  //now, update the arrays based on the desired number
  //first, the big fish
  if ((currentBF - desiredBF) > 0) {
    //then we need to remove fish from the array
    int amountToRemove = (int) floor(currentBF-desiredBF);
    int currentBFSIZE = bigFish.fishes.size();
    for (int i = currentBFSIZE-1; i >= (currentBFSIZE - amountToRemove); i--) {
      Fish f = (Fish) bigFish.fishes.get(i);
      bigFish.removeFish(f);
    }
  }
  else if ((currentBF - desiredBF) < 0) {
    int amountToAdd = (int) round(abs(currentBF-desiredBF));
    for (int i=0; i<amountToAdd; i++) {
      int ran = (int) random(0, 3);
      int ranCol = (int) random(-10, 10);
      Fish f = new Fish(fishShape[ran], 10+ranCol, 43+ranCol, 115+ranCol, 21, screenHeight/4, i*screenWidth/amountToAdd, random(0, screenHeight/2), 0.2, 0, 0, 10, 4, false, 0.05);
      bigFish.addFish(f);
    }
  }
  //now, the small fish
  if ((currentSF - desiredSF) > 0) {
    //then we need to remove fish from the array
    int amountToRemove = (int) (round(currentSF-desiredSF)/3);
    int currentSFSIZE1 = smallFish1.fishes.size();
    int currentSFSIZE2 = smallFish2.fishes.size();
    int currentSFSIZE3 = smallFish3.fishes.size();
    for (int i = currentSFSIZE1-1; i >= (currentSFSIZE1 - amountToRemove); i--) {
      Fish f = (Fish) smallFish1.fishes.get(i);
      smallFish1.removeFish(f);
    }
    for (int i = currentSFSIZE2-1; i >= (currentSFSIZE2 - amountToRemove); i--) {
      Fish f = (Fish) smallFish2.fishes.get(i);
      smallFish2.removeFish(f);
    }
    for (int i = currentSFSIZE3-1; i >= (currentSFSIZE3 - amountToRemove); i--) {
      Fish f = (Fish) smallFish3.fishes.get(i);
      smallFish3.removeFish(f);
    }
  }
  else if ((currentSF - desiredSF) < 0) {
    int amountToAdd = (int) (round(abs(currentSF-desiredSF))/3);
    for (int i=0; i<amountToAdd; i++) {
      int ran = (int) random(3, 6);
      int ranCol = (int) random(-10, 10);
      Fish f = new Fish(fishShape[ran], 217+ranCol, 59+ranCol, 88+ranCol, 21, screenHeight/50, i*screenWidth/amountToAdd, random(0, screenHeight/2), 3.0, 0.8, 1.2, 8, 25, true, 0.2);
      smallFish1.addFish(f);
    }
    for (int i=0; i<amountToAdd; i++) {
      int ran = (int) random(3, 6);
      int ranCol = (int) random(-10, 10);
      Fish f = new Fish(fishShape[ran], 217+ranCol, 59+ranCol, 88+ranCol, 21, screenHeight/50, i*screenWidth/amountToAdd, random(0, screenHeight/2), 3.0, 0.8, 1.2, 8, 25, true, 0.2);
      smallFish2.addFish(f);
    }
    for (int i=0; i<amountToAdd; i++) {
      int ran = (int) random(3, 6);
      int ranCol = (int) random(-10, 10);
      Fish f = new Fish(fishShape[ran], 217+ranCol, 59+ranCol, 88+ranCol, 21, screenHeight/50, i*screenWidth/amountToAdd, random(0, screenHeight/2), 3.0, 0.8, 1.2, 8, 25, true, 0.2);
      smallFish3.addFish(f);
    }
  }
}

void removeFish() {
  for (int i = smallFish1.fishes.size()-1; i >= 0; i--) {
    Fish f = (Fish) smallFish1.fishes.get(i);
    if (f.isDead()) {
      smallFish1.fishes.remove(i);
    }
  }
  for (int i = smallFish2.fishes.size()-1; i >= 0; i--) {
    Fish f = (Fish) smallFish2.fishes.get(i);
    if (f.isDead()) {
      smallFish2.fishes.remove(i);
    }
  }
  for (int i = smallFish3.fishes.size()-1; i >= 0; i--) {
    Fish f = (Fish) smallFish3.fishes.get(i);
    if (f.isDead()) {
      smallFish3.fishes.remove(i);
    }
  }
  for (int i = bigFish.fishes.size()-1; i >= 0; i--) {
    Fish f = (Fish) bigFish.fishes.get(i);
    if (f.isDead()) {
      bigFish.fishes.remove(i);
    }
  }
} 

//Bubble Class 
class Bubble {

  PVector location;
  PVector velocity;
  PVector acceleration;
  // Mass is tied to size
  float mass;

  Bubble(float _m, PVector _l) {
    mass = _m;
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-0.15,0.15),-3.0);
    location = _l;
  }

  void run() {
    update();
    display();
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);   
    acceleration.add(f);
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  // Method to display
  void display() {
    stroke(0);
    strokeWeight(0.25);
    fill(255,50);
    ellipse(location.x,location.y,mass,mass);
  }

  // Is the bubble still on screen? if it is not, remove it
  boolean isDead() {
    if (location.y <= -30) {
      return true;
    } else {
      return false;
    }
  }

}// ends bubble class

// Coral class
class Coral {
  PShape s;
  float colorR;
  float colorG;
  float colorB;
  float x;
  float y;
  float w;
  float h;

  Coral (PShape _s, float _x, float _y, float _w, float _h) {
    s = _s;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    colorR = random(0, 255);
    colorG = random(0, 255);
    colorB = random(0, 255);
  }

  void display() {   
    s.disableStyle();
    stroke(colorR, colorG, colorB);
    fill (colorR, colorG, colorB);
    strokeWeight(1);
    shapeMode(CORNER);
    shape(s, x, y, w, h);
  }
} // end coral class

class Fish {

  PShape s;
  float colorR;
  float colorG;
  float colorB;
  float colorA;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float separation;
  float alignment;
  float cohes;
  float _initvel;
  float theta;
  boolean flocking;
  boolean removed;

  Fish(PShape _s, float _cr, float _cg, float _cb, float _ca, float _r, float x, float y, float _separation, float _alignment, float _cohes, float _maxspeed, float _initvel, boolean _flocking, float _maxforce) {
    s = _s;
    colorR = _cr;
    colorG = _cg;
    colorB = _cb;
    colorA = _ca;
    acceleration = new PVector(0, 0);
    
    // set the starting angle to be somewhat horizontal
    float angle = random(-radians(10),radians(10));
    velocity = new PVector(cos(angle),sin(angle));
    velocity.mult(_initvel);
    // give it random starting velocity/direction
    if (random(1) < 0.5) {
       velocity.mult(-1);
    }
    //velocity = new PVector(random(-1, 1), random(-0.1, 0.1));
    //velocity.mult(_initvel);
    location = new PVector(x, y);
    r = _r;
    maxspeed = _maxspeed;
    flocking = _flocking;

    maxforce = _maxforce;
    separation = _separation;
    alignment = _alignment;
    cohes = _cohes;
    theta = 0.01;
    
    removed = false;  
  }

  void run(ArrayList<Fish> fishes) {
    school(fishes);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void school(ArrayList<Fish> fishes) {
    PVector sep = separate(fishes);   // Separation
    PVector ali = align(fishes);      // Alignment
    PVector coh = cohesion(fishes);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(separation);
    ali.mult(alignment);
    coh.mult(cohes);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
    if (colorA < 255 && removed == false){
      colorA = colorA + 10;
    }
    if (removed == true){
      colorA = colorA - 10;  
    } 
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    // Draw a fish rotated in the direction of velocity
    if (flocking == true){
      theta = atan2(velocity.y, velocity.x) + radians(180);
    } 
    else{
      theta = 0;
    }
    stroke(colorR, colorG, colorB, colorA);
    fill (colorR, colorG, colorB, colorA);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    
    if (velocity.x > 0 && flocking == false) {
      scale(-1,1); 
    }
    
    s.disableStyle();
    strokeWeight(1);
    shapeMode(CORNER);
    shape(s, 0, 0, r, r);
    popMatrix();
  }

  // Wraparound and check edges
  void borders() {
    PVector desired = null;

    if (location.y < screenHeight/60) {
      desired = new PVector(velocity.x, maxspeed/2);
    }
    else if (location.y > screenHeight/1.5) {
      desired = new PVector(velocity.x, -maxspeed/2);
    }

    if (desired != null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Fish> fishes) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Fish other : fishes) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby fish in the system, calculate the average velocity
  PVector align (ArrayList<Fish> fishes) {
    float neighbordist = r*16;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Fish other : fishes) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList<Fish> fishes) {
    float neighbordist = r*16;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Fish other : fishes) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Is the fish still "alive", if not, remove it
  boolean isDead() {
    if (colorA < 20) {
      return true;
    } else {
      return false;
    }
  }
  
} // end Fish Class


// School class
class School {
  ArrayList<Fish> fishes; // An ArrayList for all the fishes

    School() {
    fishes = new ArrayList<Fish>(); // Initialize the ArrayList
  }

  void run() {
    for (Fish f : fishes) {
      f.run(fishes);  // Passing the entire list of boids to each boid individually
    }
  }

  void addFish(Fish f) {
    fishes.add(f);
  }

  void removeFish(Fish f) {
    f.removed = true;
  }
} // end school class