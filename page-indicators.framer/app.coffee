# Sketch Import
sketch = Framer.Importer.load "imported/page-indicators"

# Array that will store our layers
allIndicators = []	

# Set-up PageComponent
page = PageComponent.wrap(sketch.content)
page.scrollVertical = false

page.addPage(sketch.photoB)
page.addPage(sketch.photoC)
page.snapToPage(sketch.photoA)

# Generate card layers
for i in [0...3]
	indicator = new Layer 
		backgroundColor: "#fff"
		width: 14, height: 14
		x: 28 * i, y: 1167
		borderRadius: "50%", opacity: 0.2
		
	# Center indicators
	indicator.x += (Screen.width / 2) - (14 * 3)
	
	# States
	indicator.states.add(active: {opacity: 1, scale:1.2})
	indicator.states.animationOptions = time: 0.5
	
	# Store indicators in our array
	allIndicators.push(indicator)

# Set indicator for current page
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Update indicators
page.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	
	current = page.horizontalPageIndex(page.currentPage)
	allIndicators[current].states.switch("active")