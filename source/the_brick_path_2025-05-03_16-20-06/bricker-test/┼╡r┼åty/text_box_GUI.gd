extends Control
@onready var background_panel = $Panel
@onready var MainText = $Panel/NinePatchRect/MainText
@onready var text_timer = $Timer
@onready var name_label = $"textbox/name panel/NinePatchRect/name"
@export var interact_label:Node

const WAIT_TIME =  0.0001
# used to keep track of current index of Text to be displayed
var text_index:int = 0
var processing_text: String
var text_to_be_read: String
#make sure that any dialog overriding activities in other classes (like dialognodes) make sure to only run comands like read() if is_reading is false.
var dialog_overflowing:bool = false
var text_index_state_at_point_of_overflow: int

#make sure that any dialog overriding activities in other classes (like dialognodes) make sure to only run comands like read() if is_reading is false.
var is_reading:bool = false
var is_visible:bool = false

var done_reading:bool = false

func _ready() -> void:
	#read_text("This is an example text with no other purpose than to provide enough space to test the features of the textbox and to see how it behaves with overflowing text. one may find that this is a nessesary thing to test for as it helps when locolizing to different languages where the text length of a specific dialog is not known. furthure more, one might want to even further test the cases of this dialog, as it may only be resolved for one instance, but not any further")
	pass

func _process(delta: float) -> void:
	#print(is_reading, dialog_overflowing)
	background_panel.size.y = MainText.size.y
	#print(MainText.get_line_count(), " : ", MainText.get_visible_line_count())
	if dialog_overflowing == true:
		if Input.is_action_just_pressed("interact"):
			
			text_index = text_index_state_at_point_of_overflow
			processing_text = ""
			MainText.text = ""
			text_index -= 4
			text_timer.start(WAIT_TIME)
			dialog_overflowing = false
	#
	#if Input.is_action_just_pressed("hide_textbox"): 
		#is_visible = false
	#if Input.is_action_just_pressed("show_textbox"): 
		#print("hiiiiiii")
		#is_visible = true
		#read_text("You trying to argue with me?")
	#
	#print(is_visible)
	if is_visible == false:
		set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.08))
	if is_visible == true:
		set_modulate(lerp(get_modulate(), Color(1,1,1,1), 0.2))
	if is_reading == true:
		interact_label.is_visible = false
	
	#print(done_reading)
	if done_reading == true and Input.is_action_just_pressed("interact"):
		is_reading = false
		done_reading = false
		emit_signal("is_done")

func read_text(text:String) -> void:
	is_reading = true
	if dialog_overflowing == false:
		text_index = 0
		MainText.text = ""
		processing_text = ""
		text_to_be_read = text
		
		text_timer.start(WAIT_TIME)

signal is_done()

func _on_timer_timeout() -> void:
	if text_index < text_to_be_read.length() and dialog_overflowing == false:
		#print(text_index," : ",text_to_be_read.length())
		if MainText.get_line_count() > MainText.get_visible_line_count():
			var index_at_which_processing_text_halts = processing_text.length()
			text_index_state_at_point_of_overflow = text_index
			#print(processing_text)
			index_at_which_processing_text_halts -= 3
			processing_text[index_at_which_processing_text_halts] = "."
			processing_text[index_at_which_processing_text_halts+1] = "."
			processing_text[index_at_which_processing_text_halts+2] = "."
			
			
			#print(processing_text[index_at_which_processing_text_halts])
			MainText.text = processing_text
			#wait_for_clearing_of_dialog_overflow()
			dialog_overflowing = true
		processing_text = processing_text + text_to_be_read[text_index]
		MainText.text = processing_text
		text_index += 1
		if text_index == text_to_be_read.length():
			done_reading = true
		text_timer.start(WAIT_TIME)

func wait_for_clearing_of_dialog_overflow() -> void:
	pass
