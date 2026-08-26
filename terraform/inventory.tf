resource "local_file" "inventory" {
  filename = "../ansible/inventory.ini"
  content = templatefile("inventory.ini.tftpl", {
    node1_ip = module.pub-web.public_ip
    node2_ip = module.pri-ctr.private_ip
    node3_ip = module.pri-mon.private_ip
  })
}