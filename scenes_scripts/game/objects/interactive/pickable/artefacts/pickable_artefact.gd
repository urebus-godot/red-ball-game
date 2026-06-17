class_name PickableArtefact extends InteractiveObject

@export var root_node: Node2D = get_parent()
@export var pickable_component: PickableComponent

@export var artifact_texture: Texture2D

@export_enum(
	Constants.SAPPHIRIUM, 
	Constants.EMERALDIUM, 
	Constants.RUBIUM,
	Constants.DIAMONDIUM
	) var artefact_name: String
	
var artefacts_parent: Node = null
var ui_layer: GameUILayer = null

var collected: bool = false


func spawn_equipped_artefact() -> Artefact:
	var artefact_scene = load(Constants.ARTEFACT_PATH % artefact_name)
	var artefact: Artefact = artefact_scene.instantiate()

	if artefact_name == Constants.EMERALDIUM:
		artefact.change_velocity = root_node.change_velocity
		artefact.change_jump_force = root_node.change_jump_force

	artefact.artefacts_parent = artefacts_parent
	artefact.ui_layer = ui_layer
	artefact.player = player
	player.arm.add_child(artefact)
	return artefact


func equip_artefact() -> void:
	if player.equipped_artefact:
		General.spawn_pickable_artefact(player, artefacts_parent, ui_layer)

	var artefact = spawn_equipped_artefact()
	player.equipped_artefact = artefact
	player.enable_arm(false)
	player.artefact_equipped.emit(self)


func interact() -> void:
	print("Entered interact() of %s" % showed_name)
	if not collected:
		print("Interacted with %s" % showed_name)
		collected = true
		equip_artefact()
		pickable_component.fade_out()


func _ready() -> void:
	artefacts_parent = root_node.artefacts_parent
	ui_layer = root_node.ui_layer


func _on_body_entered(body: Player) -> void:
	if can_interact():
		#player_entered.emit(self)
		root_node.player_entered.emit(self)
		player = body
	else:
		return

func _on_body_exited(body: Player) -> void:
	if can_interact():
		#player_exited.emit(self)
		root_node.player_exited.emit(self)
		player = null
	else:
		return
