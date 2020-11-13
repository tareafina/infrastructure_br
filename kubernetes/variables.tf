variable "credentials_file" {
	default		=	"terraform.json"
	description	=	"API credentials JSON file"
}

variable "region" {
	default		=	"us-central1"
	description	=	"Region	name"
}

variable  "region_zone"  {
    default     = "us-central1-c"
    description = "Availability zone"
}

variable "project_name"	{
	default		=	"default-project"
	description	=	"Project ID to use"
}

variable "machine_type"  {
    default     = "f1-micro"
    description = "Machine type"
}

variable  "disk_image"  {   
    default     = "centos-cloud/centos-7"
    description = "Disk image"
}

variable  "ssh_key" {
    default     = "keys/admin_key"
    description = "SSH  key"
}

variable  "ssh_username"  {
    default     = "root"
    description = "The SSH username to use"
}

#####################################################################
#  Kubernetes variables
#####################################################################

# variable "env" {
#   description = "The environment you are creating the cluster for"
# }

# variable "subnet_range" {
#   description = "The ip range for the subnet which kubernetes machines will be created in"
# }

variable "cluster_name" {
  description = "Name of the K8s cluster"
  default = "k8s-cluster"
}

variable "cluster_username" {
  description = "The username for logging into kubernetes ui"
  default = "admin" 
}

variable "cluster_password" {
  description = "The password for logging into kubernetes ui"
  default = "admin-0123456789"
}

variable  "container_cidr_range" {
    default     = "10.37.64.0/19"
    description = "The IP range for the containers"
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster (not including the Kubernetes master)"
  default     = 1
}
