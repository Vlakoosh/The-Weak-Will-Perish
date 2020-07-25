extends Node
class_name StateMachine

var state = null setget set_state
var previous_state = null
var states = {}

onready var parent = get_parent()


# Check every frame 
func _physics_process(delta):

	if state != null:
		# Runs the logic for the current state the parent is in
		_state_logic(delta)
		# Check conditions to see if we should transition to a different state
		var transition = _get_transition(delta)
		if transition != null:
			# Change to the new state
			set_state(transition)

# Virtual method, here goes everything that should execute in each different state
func _state_logic(delta):
	pass
	
# Virtual method, rules for what state transitions into what state under what circunstances
func _get_transition(delta):
	pass
	
# Virtual method, if you need something to execute when a certain state is entered
func _enter_state(new_state,old_state):
	pass
	
# Virtual method, if you need something to execute when a certain state is exited
func _exit_state(old_state,new_state):
	pass
	
# Handles the changes in state
func set_state(new_state):
	previous_state = state
	state = new_state
	
	if previous_state != null:
		_exit_state(previous_state,new_state)
	if new_state !=null:
		_enter_state(new_state,previous_state)
	
# Supposed to be called in the _ready method of the parent that is going
# to use the state machine, adding each state that will be used
func add_state(state_name):
	states[state_name] = states.size()
