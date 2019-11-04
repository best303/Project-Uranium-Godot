extends Node
var game = null
var gameInstance = null
var deviceResolution = OS.get_real_window_size()
var controlScale
var dir
var last_dir = null
var count = 0

func _ready():
	Global.isMobile = true
	$ColorRect.rect_size = deviceResolution
	$ColorRect.visible = true
	
	$ViewportContainer/GameViewport.set_size_override_stretch(true)
	$ViewportContainer/GameViewport.set_size_override(true, Vector2(512,384))
	resize()
	game = load("res://IntroScenes/Intro.tscn")
	#game = load("res://Maps/Moki Town/HeroHome.tscn") 
	gameInstance = game.instance()
	$ViewportContainer/GameViewport.add_child(gameInstance)
	pass
	
func _process(delta):
	count += 1
	if count == 10:
		count = 0
		
		if Input.is_action_pressed("ui_touch"):
			var event = get_viewport().get_mouse_position()
			if !checkCostraints(false,event, $D_Pad2/TextureRect/ui_up):
				if !checkCostraints(false,event, $D_Pad2/TextureRect/ui_down):
					if !checkCostraints(false,event, $D_Pad2/TextureRect/ui_left):
						checkCostraints(false,event, $D_Pad2/TextureRect/ui_right)
		else:
			if last_dir != null:
				Input.action_release(last_dir)
			last_dir = null
			dir = null

func checkCostraints(oneshot,pos,val):
	if pos.x > val.rect_global_position.x and pos.y > val.rect_global_position.y and pos.x < val.rect_global_position.x + val.rect_size.x * controlScale and pos.y < val.rect_global_position.y + val.rect_size.y * controlScale:
		if last_dir != null:
			Input.action_release(last_dir)
			
		last_dir = val.name
		dir = val.name
		Input.action_press(dir)
		if oneshot == true:
			Input.action_release(dir)
			
		return 1
	else:
		dir = null
		return 0

func resize():
	deviceResolution = OS.get_real_window_size()
	#print(deviceResolution)
	
	var horizontalSize = int(round(deviceResolution.y * 1.333))
	$ViewportContainer.rect_position = Vector2( (deviceResolution.x - horizontalSize) / 2, 0)
	$ViewportContainer.rect_size = Vector2(horizontalSize, deviceResolution.y)
	controlScale = deviceResolution.y / 3000
	$D_Pad2.position = Vector2(0, int(round(deviceResolution.y / 2)))
	$D_Pad2.scale = Vector2(controlScale, controlScale)
	
	$Buttons.position = Vector2(deviceResolution.x - int(round(1500 * controlScale))   , int(round(deviceResolution.y / 2)))
	$Buttons.scale = Vector2(controlScale, controlScale)
	pass
	
	
func changeScene(scene):
	gameInstance.queue_free()
	game = load(scene)
	gameInstance = game.instance()
	$ViewportContainer/GameViewport.add_child(gameInstance)
	pass

func _on_Z_button_down():
	Input.action_press("z")
	pass # replace with function body


func _on_X_button_down():
	Input.action_press("x")
	pass # replace with function body


func _on_C_button_down():
	Input.action_press("c")
	pass # replace with function body


func _on_S_button_down():
	Input.action_press("ui_accept")
	pass # replace with function body


func _on_Z_button_up():
	Input.action_release("z")
	pass # replace with function body


func _on_X_button_up():
	Input.action_release("x")
	pass # replace with function body


func _on_C_button_up():
	Input.action_release("c")
	pass # replace with function body


func _on_S_button_up():
	Input.action_release("ui_accept")
	pass # replace with function body
