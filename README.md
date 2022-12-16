# Brachistochrone Viewer
 Calculating a brachistochrone (For Mythbusters week)
<p align="center"><img width="500" height="500" src="https://user-images.githubusercontent.com/111876987/208113973-9d399f07-61e5-40e9-a467-11527a008795.gif">
  </p>
 
## Creating the gif
In the draw function, change ```mx``` from ```mouseX``` to frameCount. You can then save every frame to create a GIF.
```ruby
int mx;

void draw(){
 mx = mouseX;
 ...
}
```
