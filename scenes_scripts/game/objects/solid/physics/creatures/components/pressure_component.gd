class_name PressureComponent extends Node

const MASS_TO_DIE: float = 5.0

@export var life_component: LifeComponent
@export var target: Creature


func _ready() -> void:
	target.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body is PhysicsObject:
		print("Detected collision with object ", body.name)
		if body.position.y > target.position.y and body.mass >= MASS_TO_DIE:
			print("And it's heavy!")
			var time = (MASS_TO_DIE / body.mass) * 0.25

			await get_tree().create_timer(time).timeout
			print(time)
			if body in target.get_colliding_bodies():
				print("Time to die!")
				life_component.die(true)
