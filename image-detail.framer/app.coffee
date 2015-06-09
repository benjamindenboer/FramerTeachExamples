# Sketch Import
sketch = Framer.Importer.load "imported/Scrollable"

# Wrap the content within a ScrollComponent
scroll = ScrollComponent.wrap(sketch.content)
scroll.contentInset = {bottom: 32}
scroll.scrollHorizontal = false
scroll.propagateEvents = false

# Store images within array
images = [sketch.img1, sketch.img2, sketch.img3, sketch.img4]
content = [scroll, sketch.navBar]

# Here we make sure the same logic applies to all imported images
for image in images

	# Style
	image.borderRadius = 6
	
	# On Click
	image.on Events.Click, (event, layer) ->
		
		# Unless we're scrolling
		if not scroll.isMoving
		
			# Copy the current image
			currentImage = layer.copy()
			currentImage.placeBehind(sketch.navBar)
			currentImage.frame = layer.screenFrame
			layer.visible = false
			
 			# Ignore events and show the image
			image.ignoreEvents = true for image in images
			
			# Animate the image
			currentImage.animate
				properties:
					scale: Screen.width / currentImage.width
					midY: Screen.height / 2
				curve: "spring(200,20,0)"
			
			for layerToHide in content
				layerToHide.animate
					properties:
						opacity: 0
					time: 0.2
			
			# Return to the default view
			currentImage.on Events.Click, ->
				this.animate
					properties:
						scale: 1
						y: layer.screenFrame.y
					time: 0.3
					
				this.on Events.AnimationEnd, ->
					layer.visible = true
					currentImage.destroy()
				
				for layerToShow in content
					layerToShow.animate
						properties:
							opacity: 1
						time: 0.2
				
				# Remove the ignoreEvents property
				image.ignoreEvents = false for image in images