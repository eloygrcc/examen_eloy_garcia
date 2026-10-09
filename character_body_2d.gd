extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var muerto = false
var frenesi = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Si esta muerto no podrá moverse
	if muerto:
		velocity.x = 0
		move_and_slide()
		return

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	# variable para poder modificar la velocidad
	var velocidad = SPEED
	
	# si el frenesi esta activo velocidad * 2
	if frenesi == true :
		velocidad = velocidad * 2

	#aqui se aplica la modificación de la velocidad
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * velocidad
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad)

	move_and_slide()
	
# se encarga hacer que el personaje se muera y reiniciar la escena
func morir():
	if muerto:
		return
	muerto = true
	print("Has muerto")
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	
#El timer activaría cada 5 segundos esta funcion haciendo que se pusiese en true y false
func activarFrenesi():
	frenesi = not frenesi
	
