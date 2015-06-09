# This imports all the layers for "chat" into chatLayers
sketch = Framer.Importer.load "imported/chat"

# Set device background 
Framer.Device.background.style.background = 
	"linear-gradient(45deg, #fff 50%, #D8F0FF 100%)"

# Make the chat view scrollable
scroll = ScrollComponent.wrap(sketch.scroll)
scroll.scrollY = scroll.content.height
scroll.scrollHorizontal = false

# Add a little padding on the bottom
scroll.contentInset = {bottom: 32}


# Set the beginner state for the microphone icon
sketch.iconMicActive.visible = false
sketch.audioMessage.visible = false


# On tap, animate & scale the icon
sketch.iconMic.on Events.TouchStart, ->
	sketch.iconMicActive.visible = true
	sketch.iconMicActive.scale = 0.8
	sketch.iconMicActive.opacity = 0
	
	sketch.iconMicActive.animate
		properties:
			scale: 1, opacity: 1
		time: 0.4
		
	sketch.inputContent.animate 
		properties:
			opacity: 0
		time: 0.2
		
	sketch.iconMicActive.on Events.AnimationEnd, ->
		this.animate 
			properties:
				opacity: 0
			time: 0.4
	
sketch.audioMessage.bringToFront()	

# On release, scale back the button and hide
# sketch.likeButton.on Events.TouchEnd, ->
# 	sketch.like.animate
# 		properties:
# 			scale: 0.2
# 		curve: "spring(800,20,0)"
# 	sketch.like.on Events.AnimationEnd, ->
# 		sketch.like.visible = false