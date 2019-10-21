extends Control

onready var NameTextBox = $VBoxContainer/CenterContainer/GridContainer/NomTextBox
onready var port = $VBoxContainer/CenterContainer/GridContainer/PortTextBox
onready var ip = $VBoxContainer/CenterContainer/GridContainer/IpTextBox

func _ready():
	NameTextBox.text = Saved.save_data["Player_name"]
	ip.text = Network.DEFAULT_IP
	port.text = str(Network.DEFAULT_PORT)
	 
	

func _on_HostBouton_pressed():
	Network.selected_port = int(port.text)
	Network.create_server()
	create_attente_partie()


func _on_JoinBouton_pressed():
	Network.selected_port = int(port.text)
	Network.selected_IP = ip.text
	
	Network.connect_to_server()
	create_attente_partie()


func _on_NomTextBox_text_changed(new_text):
	Saved.save_data["Player_name"] = NameTextBox.text
	Saved.save_game()
	
func create_attente_partie():
	$AttentePartie.popup_centered()
	$AttentePartie.refresh_players(Network.players)