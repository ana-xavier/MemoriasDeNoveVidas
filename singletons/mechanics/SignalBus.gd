extends Node

signal open_content_container(text: String)
signal opened_content_container
signal closed_content_container

signal open_feedback_container(text: String, show_cancel: bool, show_confirm: bool)
signal feedback_returned(message: String)

signal loading_level
