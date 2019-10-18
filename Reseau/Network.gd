extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 32023
const MAX_PLAYERS = 4

var local_player_id = 0

signal player_disconnected
signal server_disconnected

func _ready():
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	
func create_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	set_local_player_id()
	print (" Le serveur a été crée")
	print ("Je suis " + str(local_player_id))
	
func connect_to_server():
	var peer = NetworkedMultiplayerENet.new()
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)
	set_local_player_id()

	
func set_local_player_id():
	local_player_id = get_tree().get_network_unique_id()
	
func _connected_to_server():
	rpc("_send_player_info", local_player_id)


#Methode utilisée sur les machines du réseau
#et lancée via 'RPC'
remote func _send_player_info(id):
	# Le serveur a toujours le id ==1
	if local_player_id == 1:
		print (str(id) + " s'est connecté.") 
		
		
func _on_player_connected(id):
	if not get_tree().is_network_server():
		print (str(id) + " s'est connecté.")
	
