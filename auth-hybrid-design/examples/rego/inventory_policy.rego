package authz

default allow = false

allow {
  input.action == "reserve"
}
