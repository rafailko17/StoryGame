extends Control

# References to UI elements
@onready var story_text = $StoryText
@onready var option1_button = $ChoiceContainer/Option1
@onready var option2_button = $ChoiceContainer/Option2

# Story Data Structure
var story_data = {
	"start": {
		"text": "You wake up in a dark, quiet forest. You hear a river to the left and see a distant campfire light to the right.",
		"choice1": "Head toward the river",
		"next1": "river",
		"choice2": "Walk toward the campfire",
		"next2": "campfire"
	},
	"river": {
		"text": "You reach a rushing river. You spot a small wooden boat tied to a tree.",
		"choice1": "Untie the boat and row away",
		"next1": "escape",
		"choice2": "Follow the river bank on foot",
		"next2": "lost"
	},
	"campfire": {
		"text": "You approach the fire and find a friendly traveler offering soup.",
		"choice1": "Accept the soup",
		"next1": "friend",
		"choice2": "Decline and ask for directions",
		"next2": "directions"
	},
	"escape": {
		"text": "You safely row downstream to civilization! [THE END - VICTORY]",
		"choice1": "Restart Game",
		"next1": "start",
		"choice2": "",
		"next2": ""
	},
	"lost": {
		"text": "The river bank collapses, and you fall into deep waters! [THE END - DEFEAT]",
		"choice1": "Restart Game",
		"next1": "start",
		"choice2": "",
		"next2": ""
	},
	"friend": {
		"text": "The traveler welcomes you as a lifelong friend! [THE END - VICTORY]",
		"choice1": "Restart Game",
		"next1": "start",
		"choice2": "",
		"next2": ""
	},
	"directions": {
		"text": "The traveler points you safely to the main road! [THE END - VICTORY]",
		"choice1": "Restart Game",
		"next1": "start",
		"choice2": "",
		"next2": ""
	}
}

var current_node = "start"

func _ready():
	# Connect buttons to functions
	option1_button.pressed.connect(_on_option1_pressed)
	option2_button.pressed.connect(_on_option2_pressed)
	
	# Load the opening story segment
	display_story(current_node)

func display_story(node_key: String):
	current_node = node_key
	var node = story_data[node_key]
	
	story_text.text = node["text"]
	option1_button.text = node["choice1"]
	
	if node["choice2"] != "":
		option2_button.text = node["choice2"]
		option2_button.show()
	else:
		option2_button.hide()

func _on_option1_pressed():
	var next_node = story_data[current_node]["next1"]
	display_story(next_node)

func _on_option2_pressed():
	var next_node = story_data[current_node]["next2"]
	display_story(next_node)
