wget https://github.com/k0sproject/k0sctl/releases/download/v0.14.0/k0sctl-linux-x64 -O k0sctl

# Make the binary executable
chmod +x k0sctl

# Move the binary to a directory in your PATH
sudo mv k0sctl /usr/local/bin/

# Check that the binary works
which k0sctl

# Check version
k0sctl version