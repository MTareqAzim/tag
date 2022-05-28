extends StateMachine


func _on_stun_body():
	var stunned_event = InputAction.new()
	stunned_event.action = "stunned"
	stunned_event.pressed = true
	
	handle_input(stunned_event)
