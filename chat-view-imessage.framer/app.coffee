# Sketch Import
sketch = Framer.Importer.load "imported/chat"

# Make the chat view scrollable
scroll = ScrollComponent.wrap(sketch.scroll)
scroll.scrollY = scroll.content.height
scroll.scrollHorizontal = false

# Add a little padding on the bottom
scroll.contentInset = {bottom: 32}

# Set the beginner state for the microphone icon
sketch.iconMicActive.visible = false

# Animate the indicator
sketch.indicator.animate 
	properties: 
		opacity: 0
	time: 0.5
	delay: 0.25
	repeat: 100

# On tap, animate & scale the icon
sketch.iconMic.on Events.Click, ->
	sketch.iconMicActive.visible = true
	sketch.iconMicActive.scale = 0.8
	sketch.iconMicActive.opacity = 0
	
	# Animate the active state
	sketch.iconMicActive.animate
		properties:
			scale: 1, opacity: 1
		time: 0.4
		
	# Fade the text field
	sketch.inputContent.animate 
		properties:
			opacity: 0
		time: 0.4
		
	# After 0.4 seconds, fade-out the active state again
	sketch.iconMicActive.on Events.AnimationEnd, ->
		this.animate 
			properties:
				opacity: 0
			time: 0.4
			
	# After 2 seconds, make the text-field re-appear
	# Also hide the active state again
	Utils.delay 2, ->
		sketch.inputContent.animate 
			properties:
				opacity: 1
			time: 0.4
			
		sketch.iconMicActive.visible = false