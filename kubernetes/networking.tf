#####################################################################
# Networking
#####################################################################
resource "google_compute_network" "vpc-2" {
  name       = "vpc-2"
  description = "GCP Network VPC San Pablo"
  auto_create_subnetworks = "false"  // optional
}

resource "google_compute_subnetwork" "subnet-a" {
  name = "subnet-a"
  ip_cidr_range = "10.5.4.0/24"  
  network = "${google_compute_network.vpc-2.self_link}"
  region = "${var.region}"
}
