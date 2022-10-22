
XcodeMergeDriver: Automatically resolve conflicts in your Xcode project files
=================================================
[![Swift](https://github.com/steven851007/XcodeMergeDriver/actions/workflows/swift.yml/badge.svg)](https://github.com/steven851007/XcodeMergeDriver/actions/workflows/swift.yml)

Table of contents
-----------------

* [Introduction](#introduction)
* [Installation](#installation)
* [Usage](#usage)
* [Known issues and limitations](#known-issues-and-limitations)
* [About the project](#about-the-project)
* [Contributing](#contributing)
* [License](#license)


Introduction
------------

Xcode Merge Driver is a script to automatically resolve git conflicts in Xcode project files (.pbxproj). These conflicts often happen when a project regularly merges branches with project file modifications. The project file is modified whenever we add, delete, move or rename files and groups. Due to how Xcode handles these changes, conflicts happen even if we change the files and groups in different locations in the folder structure. Resolving these conflicts is a repetitive task that we can automate. 

Installation
------------

Xcode Merge Driver is a git-merge-driver that git will call automatically when a conflict occurs in the .pbxproj file. For that, we have to integrate it with git. We can do this in three steps:

1: Download the latest version from the [Release page](https://github.com/steven851007/XcodeMergeDriver/releases) and put the XcodeMergeDriver executable into your project folder.

 	Alternatively, check out the project and build it on your local machine.

2: Define XcodeMergeDriver as a custom merge driver. We can do this in the .git/config file:

```gitconfig
[merge "XcodeMergeDriver"]
	name = Xcode .pbxproj project file merge driver
	driver = ./XcodeMergeDriver %A %O %B
```

The `merge` block contains the merge driver's identifier, used to reference the merge driver later.

The `name` variable gives the driver a human-readable name.

The `driver` variable is used to construct a command to run the merge driver. Our merge driver expects three parameters that it can pass to it:
- `%A`: the file name containing the **current** version
- `%O`: the file name containing the **common ancestor** (base) version
- `%B`: the file name containing the **other** version

The order of the parameters is essential.
You can read more about how to define a custom merge driver in the [official documentation](https://git-scm.com/docs/gitattributes#_defining_a_custom_merge_driver)

3: Update the .gitattributes file

In the project .gitattributes file, we have to define to run this merge driver for the .pbxproj files:
```gitattributes
*.pbxproj merge=XcodeMergeDriver
```
 
Usage
-----

After the setup, git will run the merge driver automatically when a conflict occurs in the .pbxproj files: 

![](git-merge.gif)

When a merge happens with a conflict, Xcode Merge Driver will launch and analyses the changes. First, it takes the changeset in the current branch compared to the base version. Then it takes the changset between the base branch and the other branch and merges these two changesets into one, respecting the logical structure of the project file. This merge strategy ensures that it resolves all conflicts correctly and generates a valid project file.

The script exits with code 0 if it successfully resolved the conflicts and with code 1 if the merge went awry. If a failure occurs, the XcodeMergeDriver will leave the remaining conflicts in the current version file, where you can resolve them manually. In case of success, the merged result will be in the file passed as the current version. 

Known issues and limitations
----------------------------

Currently, the driver can only resolve conflicts in the following sections in the project file:
- PBXBuildFile section
- PBXFileReference section
- PBXGroup section
- PBXSourcesBuildPhase section

Handling these sections cover the most common file operations that cause a conflict:
- Adding, deleting, moving renaming files and groups

The script can't resolve conflicts caused by changes at other places in the Xcode project, like build configurations, schemes, etc. You can fix those conflicts manually after the script finishes.

About the project
------------

The project is implemented in Swift as a Swift package. It uses Swifts [argument parser](https://github.com/apple/swift-argument-parser) library to create a command line tool that accepts the parameters from git. 

To run the project in Xcode, do the following steps:
- Check out the project
- Open the XcodeMergeDriver folder in Xcode
- Select the XcodeMergeDriver scheme -> Edit scheme -> Run -> Options and make sure the "Use custom working directory" is ticked and set to the project folder
- Build and run all unit tests with Cmd+U

You can also run the project with Cmd+R, but you must pass the three required arguments. You can do that under XcodeMergeDriver scheme -> Edit scheme -> Run -> Arguments -> Arguments Passed On Launch.

Contributing
------------

I appreciate your contributions. To make changes to the project, you can clone the repo and open the XcodeMergeDriver folder in Xcode. This folder includes the following:

- The XcodeMergeDriver package
- Unit tests for business logic
- End-to-end tests for covering the most common use cases

All pull requests with new features or bug fixes that change the business logic should include test cases validating the changes.

License
-------

[MIT licensed.](LICENSE)
