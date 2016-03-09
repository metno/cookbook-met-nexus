@test "nexus http reponds Ok" {
    # nexus is using a looong time to start. Wait some
    sleep 15
    curl -I http://localhost:8081 | {
        run egrep "HTTP/1.1 200 OK"
        [ $status -eq 0 ]
    }
}

@test "maven_sudo_access user is in security.conf" {
    run grep "testuser " /etc/security/access.conf
    [ $status -eq 0 ]
}

@test "maven_sudo_access is in sudoers" {
    run test -f /etc/sudoers.d/testuser
    [ $status -eq 0 ]
}
