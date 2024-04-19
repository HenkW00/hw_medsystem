# HW Scripts - Med System (Rewritten)

**Description**

This is an advanced medical system that can help improve medical RP.
This script is made for NEW Update ESX 
Script got rewritten by HW Development.

**Author**
- HW Development | HenkW

**Changelog:**
- Added debug function to server.
- Added discord logging to server.
- Added debug statements to server.
- Made script more readable.
- Added version support.
- Optimized client-side.
- Optimizer server-side.
- Added helpers to both client and server-side.
- Combined nested if statements into a single condition for checking job whitelist.
- Removed unnecessary else condition in the RegisterCommand function.
- Simplified the condition for sending logs in the sendLog function.
- Removed redundant for loop iteration syntax.
- Simplified the getIdentity function and removed redundant ~= nil checks.

🛠 **Requirements**
- ESX Server

🌐 **Requirements Download links**
- es_extended: [https://github.com/esx-framework/esx_core]

✅ **Features**
- Any players can do /med [player ID] to check someone’s medical info like where they’ve been hit
their pulse and blood level as seen below it also displays the users Character Name.
- Automatic Chat Message when the player is Dead blood 0-5% and hurt area is HEAD using /med [id]
- Discord logging added for better moderation (config.webhook)
- Possibilty for developers to turn on debug mode to get outputs on actions made.

🔧 **Download & Installation**

Follow these steps to set up the med system script on your ESX server:

1. **Download the Files**: Download the script files from the provided source.

2. **Copy to Server Resource Directory**: Place the `hw_medsystem` folder in the server resource directory.

3. **Update `server.cfg`**: Add the following line to your `server.cfg` file:

    ```cfg
    start hw_medsystem
    ```

4. **Start Your Server**: Restart or start your ESX server to load the `hw_medsystem` resource.

Enjoy the script! <3
