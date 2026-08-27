resource "local_file" "inventory" {
  filename = "../ansible/inventory.ini"
  content = templatefile("inventory.ini.tftpl", {
    node1_id = module.pub-web.id
    node2_id = module.pri-ctr.id
    node3_id = module.pri-mon.id
    region   = "ap-southeast-1"
    bucket_id= module.s3_bucket.s3_bucket_id
  })
}