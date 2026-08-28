variable "cloudflare_api_token" {
  type        = string
  description = "API token for CF"
  sensitive   = true
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Zone ID for CF"
}

variable "cloudflare_record" {
  type        = string
  description = "The subdomain or root name for the record"
}