extends Control




func _on_HostBouton_pressed():
	Network.create_server()


func _on_JoinBouton_pressed():
	Network.connect_to_server()
