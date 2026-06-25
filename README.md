Eclipse SDK port for illumos-based distros and Oracle Solaris 11.4 CBE
======================================

This repo is used to build the Eclipse SDK which provides the framework for Eclipse based applications, the Java development tooling and the Plug-in development tooling.
To clone it, it is recommended to use one of the URLs found on the following website: 
https://github.com/dvt64/oi-eclipse

An anonymous clone can be done via the following commands:

```
git clone https://github.com/dvt64/oi-eclipse.git
cd oi-eclipse
git submodule update --init --recursive
```

The latter command will clone all submodules.

How to build the Eclipse SDK
----------------------------

To run a complete build, on your local machine, run the following commands:
./scripts/solaris/build-solaris.sh

find the results in
oi-eclipse/products/eclipse-sdk/target/products/org.eclipse.sdk.ide/solaris/gtk/x86_64/eclipse
```

Build requirements
------------------

The build commands require the installation and setup of Java 17 or higher, Maven version 3.5.4 or higher.
Extra dependencies: gcc, gnu-make, pkg-config, gtk3, cairo.

How to run
----------
1. Create file org.eclipse.urischeme.prefs in oi-eclipse/products/eclipse-sdk/target/products/org.eclipse.sdk.ide/solaris/gtk/x86_64/eclipse/configuration/.settings with following contents:
eclipse.preferences.version=1
skipAutoRegistration=true

2. Running via: GTK_IM_MODULE=ibus ./eclipse

License
-------

[Eclipse Public License (EPL) v2.0][2]

[2]: https://www.eclipse.org/legal/epl-2.0/
