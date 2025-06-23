extends Node


func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		
		if node.scene_file_path.is_empty():
			continue
		
		#Vérifie si chaque classe a une méthode sauvegarde
		if !node.has_method("sauvegarde"):
			continue
		
		#Appelle la méthode sauvegarde
		var node_data = node.call("sauvegarde")
		
		#JSON -> String
		var json_string = JSON.stringify(node_data)
		
		#Ecrit la ligne sur le fichier de sauvegarde
		save_file.store_line(json_string)
	

func load_game():
	#Vérifie si le fichier de sauvegarde est présent
	if not FileAccess.file_exists("user://savegame.save"):
		return 
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Permet d'intéragire avec JSON
		var json = JSON.new()

		# Vérifi si il y a des erreurs
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " dans ", json_string, " a la ligne ", json.get_error_line())
			continue

		# Prend les valeurs du fichier JSON
		var node_data = json.data

		# Création de l'objet
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "score" or i == "skinActuel":
				continue
			new_object.set(i, node_data[i])
