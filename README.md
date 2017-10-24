# prerequisites 

```
$ sudo apt-get install virtualbox vagrant
```

# provision VM with vagrant

```
$ vagrant up
```

this will create between 1 and n VMs (see the ./vagrant/Vagrantfile to specify how many VM you need)

# log in any vm

```
$ vagrant ssh vm1
```

# run salt 

```
$ salt "*" test.ping
```

