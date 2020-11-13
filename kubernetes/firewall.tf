#####################################################################
# Firewall rules
#####################################################################

 resource "google_compute_firewall" "allow-icmp-ssh-vpc-2" {
   name    = "allow-icmp-ssh-network-1"
   network = "${google_compute_network.vpc-2.name}"

   allow {
     protocol = "tcp"
     ports    = ["22"]
   }

   allow {
     protocol = "icmp"
   }
   source_ranges = ["0.0.0.0/0"]
 }

resource "google_compute_firewall" "allow-http-vpc-2" {
  name = "allow-http-vpc-2"
  network = "${google_compute_network.vpc-2.name}"

  allow {
    protocol = "tcp"
    ports = [
      "80"
    ]
  }

  allow {
    protocol = "tcp"
    ports = [
      "31469", "30439"
    ]
  }

  //target_tags = ["http-server"]

  source_ranges = [
    "0.0.0.0/0"
    // = everything @todo
  ]
}
