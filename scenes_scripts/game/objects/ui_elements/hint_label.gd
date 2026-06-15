extends ActivatedObject

const TWEEN_DURATION: float = 0.5

@onready var hint_label: RichTextLabel = $HintLabel


func activate() -> void:
	if not is_activated:
		await super.activate()
		var pos_tween = hint_label.create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
		pos_tween.tween_property(hint_label, "position:y", 0.0, TWEEN_DURATION).from(-110)
		var mod_tween = hint_label.create_tween().set_trans(Tween.TRANS_SINE)
		mod_tween.tween_property(hint_label, "modulate:a", 1.0, TWEEN_DURATION).from(0.0)
	is_activated = true


func _ready() -> void:
	hint_label.modulate.a = 0.0
