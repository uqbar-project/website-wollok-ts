---
title: -> Wollok CLI without Admin Rights
description: Steps to install Wollok with Node without administrator permissions
sidebar:
    order: 10
---

## Wollok Command Line Interface: without admin permissions

If you're on a machine without administrator permissions, for example on a university lab machine or a work computer, we recommend following these steps.

### Installation on Windows

#### Enable script execution

Open a Powershell Terminal window and run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Confirm it's correctly configured:

```powershell
Get-ExecutionPolicy
RemoteSigned # expected response
```

#### Download Node as executable

First confirm that we don't have Node installed:

```powershell
node -v
node: The term 'node' is not recognized as a name of a cmdlet, function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Go to [Node's download page](https://nodejs.org/en/download), it will have the LTS version of Node pre-selected.

![Download Node zip](/assets/installation/non-admin/node_zip_win.png)

Choose the option that says `Or get a prebuild Node.js for...` for Windows, and finally click on `Standalone Binary (.zip)`.

Unzip and move to a common folder `$HOME\node`. $HOME is your user's root folder, which can be C:\Users\Username for example. Note that the node folder must contain the executables, like `node.exe`. If you see that inside the node folder there's another folder `node-v22.19.0-win-x64` or similar, this means you need to move the files from that subfolder to the parent `node` folder. The file structure should look like this:

```bash
C:\
  + Users
    + Username # your username
      + node
        + node.exe
        + npm.cmd
```

#### Make Node executable from any folder

To do this, you need to add the `node` folder to the user's PATH. Run from a Powershell terminal:

```powershell
# Step 1, test if there's a profile
Test-Path $PROFILE
# if it responds True, go to step 2
# if it responds False, run the following commands
New-Item -Path (Split-Path $PROFILE -Parent) -ItemType Directory -Force
New-Item -Path $PROFILE -Type File -Force

# Step 2, edit the profile
notepad $PROFILE
```

When opening the file, write the following lines:

```powershell
$nodePath = "$env:USERPROFILE\node"
if ($env:PATH -notlike "*$nodePath*") {
    $env:PATH += ";$nodePath"
}
Set-Alias npm npm.cmd
```

Save the file and close Notepad.

Then verify how the PATH variable looks. Close and open a new Powershell terminal:

```powershell
$env:PATH
```

The PATH should now contain the folder `C:\Users\Username\node`, where `Username` is your username.

Run:

```powershell
node -v
```

It should show the Node version we installed, like `v22.19.0`.

#### Downloading npm

From the terminal run:

```powershell
Unblock-File -Path $HOME\node\npm.ps1
```

Verify that the Node package downloader works:

```powershell
npm -v
```

The version should appear.

#### Downloading the CLI

Now install wollok by running:

```bash
npm i -g wollok-ts-cli
```

Verify that we have Wollok CLI installed. In the terminal type:

```zsh
wollok --version
```

![Verify wollok ts cli](/assets/installation/recommended/wollok-ts-cli-path-win-3.gif)

:::note[About the version]
The version shown will be the latest one you downloaded (it doesn't have to be 0.2.2)
:::

### Installation on Linux

#### Download Node and npm

Go to the official [Node](https://nodejs.org/en/download/) download page.

![Download Node](/assets/installation/non-admin/node-linux.png)

Choose the default option (LTS), where nvm and npm are installed, and run in a terminal (Ctrl + Alt + T):

```bash
# Download nvm (node version manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Restart the shell
\. "$HOME/.nvm/nvm.sh"

# Download npm
nvm install 22

# Verifications: node
node -v # should show the installed node version

# Verifications: npm
npm -v # should show the installed npm version
```

:::note[About the version]
The versions that appear may be newer, choose the LTS (Long Term Support) version of Node 22 or 20.
:::

Now install wollok by running:

```bash
npm i -g wollok-ts-cli
```

Verify that we have Wollok CLI installed. In the terminal type:

```bash
wollok --version
```

![Verify Linux wollok ts cli](/assets/installation/recommended/wollok-ts-cli-linux-cmd-2.gif)

:::note[About the version]
The version shown will be the latest one you downloaded (it doesn't have to be 0.2.2)
:::

