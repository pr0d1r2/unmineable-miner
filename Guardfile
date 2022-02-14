guard :shell do
  %w[
    Dockerfile
    install.sh
  ].each do |file|
    `bash docker/build.sh`
  end

  watch(/(commands|config|docker|systemd)\/.*\..*/) { `bash docker/build.sh` }
end
