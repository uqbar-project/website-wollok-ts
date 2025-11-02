---
title: Common Issues
description: Problems when trying to use Wollok
---

Here is a list of common errors detected when installing or running Wollok.


## Script execution is disabled on this system (Powershell)

When trying to run wollok for the first time on Windows, it may throw the following error indicating that the console does not have _script execution permissions_ or that _The term 'wollok' is not recognized as the name of a cmdlet, function, script file, or executable program_.

<img width="646" alt="image" src="/assets/installation/troubleshooting/wollokInitWindowsFailure.png">

To fix it, you need to _enable script execution_. To do this:

1. Open a console (Powershell) in administrator mode: `Search for the Powershell application -> Right click -> Run as administrator`.

2. Change the policy to `Unrestricted` with the command:

```powershell
Set-ExecutionPolicy Unrestricted
```

3. Answer yes to the change confirmation: type `Y` and enter.

4. Confirm that the value has changed, it should respond `Unrestricted`:

```powershell
Get-ExecutionPolicy 
```

5. Done! Close that console and run wollok again from a new console or from VSCode.


## Problems using `nvm`

If you already had another version of `node` in addition to [the one needed for Wollok](../installation_recomended), and you use `nvm`, you may have _problems using VSCode_ if **the `default` version is not the expected one**.

To check the `default` version:

```bash
nvm version default
```

If it is _not_ the recommended one, you can change the alias:

```bash
nvm alias default 20
```

:::note[Note]
The version of `node` used by Wollok may change. Refer to what the [instructions](../installation_recomended) say.
:::


## What do I do now?

#### If you solved the problem
You can continue by taking the [Tour of VSCode tools](/en/tour/console) to see how to take advantage of the tool.

#### If you didn't find the problem or it's not solved
Please report it as an [issue in the Github repository](https://github.com/uqbar-project/wollok-language/issues/new) so we can help you and follow up.

If you had problems installing Wollok using Node, we suggest trying the [alternative installation](../installation_alternative) while we find a solution.

You can also contact the team through [Uqbar's Discord](https://discord.gg/ZstgCPKEaa).

