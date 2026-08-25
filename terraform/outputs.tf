output "pub-web" {
  value = module.pub-web.public_ip
}

output "ssm_pub-web" {
  value = "aws ssm start-session --target ${module.pub-web_public.id}"
}

#TO-DO : check if when apply able to SSM into private servers
output "pri-ctr" {
  value = module.pri-ctr.public_ip
}

output "ssm_pri-ctr" {
  value = "aws ssm start-session --target ${module.pri-ctr.id}"
}

#TO-DO : check if when apply able to SSM into private servers
output "pri-mon" {
  value = module.pri-mon.public_ip
}

output "ssm_pri-mon" {
  value = "aws ssm start-session --target ${module.pri-mon.id}"
}