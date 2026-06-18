extends PhysicsObject

const MIN_BIAS: float = 0.003
const MAX_BIAS: float = 0.06

@export var player: Player

var is_dragging: bool = false
var joint: PinJoint2D = null
var mouse_body: StaticBody2D = null


func start_drag() -> void:
	print("Started drag!")
	is_dragging = true
	
	# 1. Создаем невидимую статичную точку в месте курсора
	mouse_body = StaticBody2D.new()
	mouse_body.global_position = get_global_mouse_position()
	get_parent().add_child(mouse_body)
	
	# 2. Создаем физическое соединение (пружину)
	joint = PinJoint2D.new()
	joint.global_position = get_global_mouse_position()
	
	# Настройки мягкости и упругости соединения
	joint.softness = 0.5      # Чем выше, тем более «резиновое» натяжение
	joint.bias = clampf(0.03 / mass, MIN_BIAS, MAX_BIAS)  
	print("joint.bias")
	joint.disable_collision = true
	
	get_parent().add_child(joint)
	
	# 3. Связываем точку курсора и наш RigidBody2D
	joint.node_a = mouse_body.get_path()
	joint.node_b = self.get_path()

func end_drag() -> void:
	print("Ended drag!")
	is_dragging = false
	
	# Удаляем временные узлы, чтобы объект полетел по инерции
	if joint:
		joint.queue_free()
	if mouse_body:
		mouse_body.queue_free()


func _ready() -> void:
	input_pickable = true


func _physics_process(_delta: float) -> void:
	if is_dragging and mouse_body:
		mouse_body.global_position = get_global_mouse_position()


func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("use_artefact") and not is_dragging:
		var artefact = player.equipped_artefact
		if artefact is Sapphirium and artefact.activated:
			start_drag()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and is_dragging:
			end_drag()
