@test "nexus http reponds Ok" {
    # nexus is using a looong time to start. Wait some
    sleep 15
    curl -I http://localhost:8081 | {
        run egrep "HTTP/1.1 200 OK"
        [ $status -eq 0 ]
    }
}
