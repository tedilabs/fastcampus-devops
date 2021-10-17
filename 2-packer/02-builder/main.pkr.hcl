/**
 * Without Name
 */
build {
  sources = [
    "source.null.one",
    "source.null.two",
  ]
}

/**
 * With Name
 */
build {
  name    = "fastcampus-packer"

  sources = [
    "source.null.one",
    "source.null.two",
  ]
}

/**
 * Fill-in
 */
build {
  name    = "fastcampus-packer-fill-in"

  source "null.one" {
    name = "terraform"
  }

  source "null.two" {
    name = "vault"
  }
}
