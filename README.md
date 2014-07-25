Vagrant Xoops Development
=========================

Vagrant Xoops Development (VXD) is fully configured and ready to use 
development environment built on Linux (Ubuntu 12) with Vagrant, VirtualBox and 
Chef Solo provisioner. VXD is virtualized environment, so your base system will 
not be changed and remain clean after installation. You can create and delete as
 much environments as you wish without any consequences.

The main goal of the project is to provide easy to use fully functional and
highly customizable Linux based environment for XOOPS development.

Setup is very simple, fast and can be performed on Windows, Linux or Mac
platforms. It's simple to clone ready environment to your Laptop or home
computer and then keep it synchronized.

If you don't familiar with Vagrant, please read about it. Documentation is very
simple to read and understand. http://docs.vagrantup.com/v2/

To start VXD you don't need to write your Vagrantfile. All configurations can be
done inside simple JSON configuration file.


Out of the box features
=======================

  * Configured Linux, Apache, MySQL and PHP stack
  * PhpMyAdmin
  * Xdebug

TODO:

  * Webgrind
  * Xhprof
  * Mailing system
  * Other development tools and useful software


Getting Started
===============

VXD uses Chef Solo provisioner. It means that your environment is built from
the source code. All you need is to get base system, the latest code and build
your environment.

  1. Install VirtualBox
     https://www.virtualbox.org/wiki/Downloads

  2. Install Vagrant
     http://docs.vagrantup.com/v2/installation/index.html

  3. Prepare Vagrant box
     Boxes are the skeleton from which Vagrant machines are constructed.
     They are portable files which can be used by others on any platform that
     runs Vagrant to bring up a working environment.

     Run next command to download and prepare Ubuntu 12 box:
     $ vagrant box add precise64 http://files.vagrantup.com/precise64.box


  4. Prepare VXD source code
     Clone VXD source code and place it inside your home
     directory.
     $ git clone https://github.com/hyperclock/VXD.git VXD

  5. Adjust configuration (optional)
     You can edit config.json file to adjust your settings. If you use VXD first
     time it's recommended to leave config.json as is. Sample config.json is
     just fine.

  6. Build your environment
     To build your environment execute next command inside your VXD copy:
     $ vagrant up

     Vagrant will start to build your environment. You'll see green status
     messages while Chef is configuring the system.

  7. Visit 192.168.3.5 address
     If you didn't change default IP address in config.json file you'll see
     VXD's main page. Main page has links to configured sites, development tools
     and list of frequently asked questions.

  8. SSH into your virtual machine
     Run next command inside your VXD copy's directory:
     $ vagrant ssh

Now you have ready to use virtual development server. By default 2 sites
(similar to virtual hosts) are configured: Xoops 25x (2.5.x Development) and 
Xoops 26x (2.6.x Development). You always can add new ones in config.json file.

Basic Usage
===========

Inside your VXD copy's directory you can find 'data' directory. It's
synchronized with virtual machine. You should place your application's files
inside sub folders with the name of your project. You can edit your application's
files on the host machine using your favorite editor or connect to virtual
machine by SSH. VXD will never delete data from data directory, but you should
backup it.

Vagrant's basic commands (should be executed inside VXD directory):

  * $ vagrant ssh
    SSH into virtual machine.

  * $ vagrant up
    Start virtual machine.

  * $ vagrant halt
    Halt virtual machine.

  * $ vagrant destroy
    Destroy your virtual machine. Source code and content of data directory will
    remain unchangeable. VirtualBox machine instance will be destroyed only. You
    can build your machine again with 'vagrant up' command. The command is
    useful if you want to save disk space.

  * $ vagrant provision
    Reconfigure virtual machine after source code change.

  * $ vagrant reload
    Reload virtual machine. Useful when you need to change network or
    synced folder settings.

Official Vagrant site has beautiful documentation.
http://docs.vagrantup.com/v2/

Customizations
==============

You should understand that every time you start virtual machine Vagrant will
fire Chef provisioner. If you want to customize your VXD copy you should do it
the right way.

Templates override

If you want to change some configuration files, for example, php.ini you should
override default VXD's template. All templates a located in
cookbooks/vxd/vxd/templates/default

All you need is to copy template file into cookbooks/core/vxd/templates/ubuntu
directory and edit it.

Writing custom role

If you want to make serious modifications you should write your custom role and
add it in config.json file. Please, see vxd_example.json file inside roles
directory.

config.json description
=======================

config.json is the main configuration file. Data from config.json is used to
configure virtual machine. After editing file make sure that your JSON syntax is
valid. http://jsonlint.com/ can help to check it.

  * ip (string, required)
    Static IP address of virtual machine. It is up to the users to make sure
    that the static IP doesn't collide with any other machines on the same
    network. While you can choose any IP you'd like, you should use an IP from
    the reserved private address space.

  * memory (string, required)
    RAM available to virtual machine. Minimum value is 1024.

  * synced_folder (object of strings, required)
    Synced folder configuration.

      * host_path (string, required)
        A path to a directory on the host machine. If the path is relative, it
        is relative to VXD root.

      * guest_path (string, required)
        Must be an absolute path of where to share the folder within the guest
        machine.

      * use_nfs (boolean, required)
        In some cases the default shared folder implementations (such as
        VirtualBox shared folders) have high performance penalties. If you're
        seeing less than ideal performance with synced folders, NFS can offer a
        solution. http://docs.vagrantup.com/v2/synced-folders/nfs.

  * php (object of strings, required)
    PHP configuration.

      * version (string or false, required)
        Desired PHP version. Please, see http://www.php.net/releases for proper
        version numbers. If you would like to use standard Ubuntu package you
        should set number to "false". Example: "version": false.

  * mysql (object of strings, required)
    MySQL configuration.

      * server_root_password (string, required)
        MySQL server root password.

  * sites (object ob objects, required)
    List of sites (similar to virtual hosts) to configure. At least one site is
    required.

      * Key (string, required)
        Machine name of a site. Name should fit expression '[^a-z0-9_]+'. Will
        be used for creating subdirectory for site, database name, etc.

          * account_name (string, required)
            Xoops administrator user name.

          * account_pass (string, required)
            Xoops administrator password.

          * account_mail (string, required)
            Xoops administrator email.

          * site_name (string, required)
            Xoops site name.

          * site_mail (string, required)
            Xoops site email.

  * xdebug (object of strings, optional)
    Xdebug configuration.

    * remote_host (string, required)
      Selects the host where the debug client is running.

  * git (object of strings, optional)
    Git configuration.

  * custom_roles (array, required)
    List of custom roles. Key is required, but can be empty array ([]).

If you find a problem, incorrect comment, obsolete or improper code or such,
please let us know by creating a new issue at
https://github.com/hyperclock/VXD/issues


Attribution
===========

Original script wriiten for Drupal. See: https://www.drupal.org/project/vdd
