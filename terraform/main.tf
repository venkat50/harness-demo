provider "random" {}

resource "null_resource" "test" {
}


resource "random_pet" "dog" {
  length = 2
}

output "foo" {
 value = random_pet.dog.id
}
