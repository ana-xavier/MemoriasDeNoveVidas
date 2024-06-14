extends Node

signal open_content_container(text: String)
signal opened_content_container
signal closed_content_container

signal open_feedback_container(text: String, show_cancel: bool, show_confirm: bool)
signal feedback_returned(message: String)

signal loading_level

signal start_cutscene_by_id(id: String)

signal rebuilt_bridge

signal dialog_boxes_finished
