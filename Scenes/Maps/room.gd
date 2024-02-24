class_name Room
extends Node2D


const BookshelfScene := preload("res://Scenes/Environment/bookshelf.tscn")
const BookshelfTopScene := preload("res://Scenes/Environment/bookshelf_top.tscn")


func fill_holes(directions: Array[int]):
	# I'm so, so sorry about that...
	for direction in directions:
		match direction:
			0:
				var bookshelf1 := BookshelfScene.instantiate()
				bookshelf1.position = Vector2(-8, -80)
				add_child(bookshelf1)
				var bookshelf2 := BookshelfScene.instantiate()
				bookshelf2.position = Vector2(8, -80)
				add_child(bookshelf2)
			1:
				var bookshelf1 := BookshelfScene.instantiate()
				bookshelf1.position = Vector2(-8, 96)
				add_child(bookshelf1)
				var bookshelf2 := BookshelfScene.instantiate()
				bookshelf2.position = Vector2(8, 96)
				add_child(bookshelf2)
			2:
				for y in range(-56, 24, 8):
					var bookshelf_top := BookshelfTopScene.instantiate()
					bookshelf_top.position = Vector2(-160.0, y)
					bookshelf_top.z_index = 2
					add_child(bookshelf_top)
			3:
				for y in range(-56, 24, 8):
					var bookshelf_top := BookshelfTopScene.instantiate()
					bookshelf_top.position = Vector2(160.0, y)
					bookshelf_top.z_index = 2
					add_child(bookshelf_top)
