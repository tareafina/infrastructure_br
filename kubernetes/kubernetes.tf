#####################################################################
#  GKE - Google Kubernetes Cluster
#####################################################################

resource "google_container_cluster" "mykube" {

  name = "${var.cluster_name}"
  location = "${var.region_zone}"
  
  initial_node_count = "${var.initial_node_count}" 

#  additional_zones = [
#    "us-central1-a"    
#  ]

  cluster_ipv4_cidr = "${var.container_cidr_range}"

  master_auth {
    username = "${var.cluster_username}"
    password = "${var.cluster_password}"
  }

  network = "${google_compute_network.vpc-2.self_link}"
  subnetwork = "${google_compute_subnetwork.subnet-a.self_link}"
  monitoring_service = "monitoring.googleapis.com"
  logging_service = "logging.googleapis.com"
  
  #node_version = "1.6.6"
  node_config {    
    machine_type =  "${var.machine_type}"
    disk_size_gb = "20"
  
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/datastore",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

    labels {
      environment = "PROD"
    }

    tags = ["${var.cluster_name}-cluster", "nodes"]    
  }

 # provisioner "local-exec" {
 #    command = "gcloud container clusters get-credentials ${var.cluster_name} --zone ${google_container_cluster.mykube.zone} --project ${var.project_name}"
 #}
}

resource "null_resource" "kube_config" {
  provisioner "local-exec" {
      command = "gcloud container clusters get-credentials ${var.cluster_name} --zone ${google_container_cluster.mykube.zone} --project ${var.project_name}"
  }

  depends_on = ["google_container_cluster.mykube"]
}

resource "null_resource" "tiller_sa" {
  provisioner "local-exec" {
      command = "kubectl --namespace kube-system create sa tiller"
  }

  depends_on = ["null_resource.kube_config"]
}


resource "null_resource" "tiller_permission" {
  provisioner "local-exec" {
      command = "kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller"
  }

  depends_on = ["null_resource.tiller_sa"]
}


resource "null_resource" "tiller_init" {
  provisioner "local-exec" {
      command = "helm init --service-account tiller"
  }

  depends_on = ["null_resource.tiller_permission"]
}

