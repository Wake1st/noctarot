class_name Kitchen
extends Node2D


@onready var bar: Bar = $Bar


func setup(finished_callable: Callable) -> void:
	bar.finished.connect(finished_callable)


func reset() -> void:
	bar.reset()
