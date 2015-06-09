# Sketch Import
sketch = Framer.Importer.load "imported/chat"

# Make the chat view scrollable
scroll = ScrollComponent.wrap(sketch.scroll)
scroll.scrollY = scroll.content.height
scroll.scrollHorizontal = false
 
thumbButton = new Layer 
	x: Screen.width - 116, y: 802
	backgroundColor: "transparent"
	
thumbIcon = new Layer 
	width: 320, height: 320
	x: Screen.width - 320
	y: scroll.content.height
	superLayer: scroll.content
	backgroundColor: null

# Add a little padding on the bottom
# Subtract that with the height of the thumb
scroll.contentInset = {bottom: 32 - 320}

# Animate the indicator
sketch.indicator.animate 
	properties: 
		opacity: 0
	time: 0.5
	delay: 0.4
	repeat: 100
	
# Thumb image
thumb = new Layer 
	width: 320, height: 320
	image: "images/thumb.png"
	scale: 0, superLayer: thumbIcon

thumb.originY = 0.3
thumb.originX = 0.6

# Slowly grow on touchStart	
thumbButton.once Events.TouchStart, ->
	this.backgroundColor = "#fff"
	this.opacity = 0.5
	scroll.scrollY = 520 + 320
	
	# Rotation
	thumbIcon.animate 
		properties:
			rotation: thumbIcon.rotation + 4
		time: 0.1
		repeat: 15
		
	# Scale
	thumb.animate 
		properties:
			scale: 1
		curve: "ease-out"
		time: 3
		
	Utils.delay 1.5, -> 
		thumbIcon.animateStop()
		thumbIcon.rotation = 0

# Animate on touchEnd	
thumbButton.on Events.TouchEnd, ->
	thumb.animateStop()
	this.backgroundColor = "transparent"
	this.opacity = 1
	
	currentScale = thumb.scale
	if currentScale > 0.4 then currentScale = 1
	if currentScale < 0.3 then currentScale = 0.3
	
	# Reset rotation
	thumbIcon.animate 
		properties:
			rotation: 0
		curve: "spring(400,10,0)"
		
	# Reset scale
	thumb.animate 
		properties:
			scale: currentScale
		curve: "spring(300,20,0)"
	
# Link the scale change to the contentInset and scroll position
thumb.on "change:scale", ->
	currentHeight = this.height * this.scale 
	height = Utils.modulate(this.scale, [0, 1], [0, currentHeight], true)
	scroll.contentInset = {bottom: 32}
	scroll.scrollY = 520 + 160 + height