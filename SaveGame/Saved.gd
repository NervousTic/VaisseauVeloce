extends Node

var save_data = {}

const SAVEGAME = "user://Savegame.json"

func _ready():
	save_data = get_data()

func get_data():
	var fichier = File.new()
	if not fichier.file_exists(SAVEGAME):
		save_data  = {"Player_name": "incognito"}
		save_game()
	fichier.open(SAVEGAME, File.READ)
	var contenu = fichier.get_as_text()
	var data = parse_json(contenu)
	save_data = data
	fichier.close()
	return (data)


func save_game():
	var save_game = File.new()
	save_game.open(SAVEGAME, File.WRITE)
	save_game.store_line(to_json(save_data))