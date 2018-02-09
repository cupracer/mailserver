milter = yes;
timeout = 120s;
upstream "local" {
    default = yes;
    self_scan = yes;
}
