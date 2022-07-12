
locals {
  full_project_name = "${var.env}-${var.project_name}"
  project_owner     = "${var.owner} owner of ${var.project_name}"
}