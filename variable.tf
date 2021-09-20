variable "server_port"{
	description = "The port server will use for http request"
	type = string
}

variable "list_example" {
	description = "An example of list ni terraform"
	type = list
	default = [1, 2, 3]
}

variable "map_ex"{
	description = "Example for Map variable"
	type = map
	default = {
		key1 = "value1"
		key2 = "value2"
		key3 = "value3"
	}
}
