# HW Scripts - Med System (Rewritten)

**Description**
This is an advanced medical system that can help improve medical RP.
This script is made for NEW Update ESX 
Script got rewritten by HW Development.

**Author**
- HW Development | HenkW

**Changelog:**
- Added Config.IDmode for changing functions for radial menu.
- Added new function for retreiving correct player ID based on how the Config.IDmode is set. (either we use 'own' or 'player')
- Changed new export for retreiving/using the med system via a radial menu. (for now i just created my own, since i then can go wild on how i want it)

**Important note from the developer!**
For now the export is there, but i cant give you that much support on how to use it, if u dont use my (hw_radialmenu) on a other radial menu.
Since i focussed on working alot with OX, its easy and they just have alot of docs to learn from <3

It does use the OX Radial Menu because its easy to use, and we already work with ox_lib/ox_inventory/oxmysql/ox_target in our scripts like i mentioned.
But if you have any suggestions/ideas please join our discord, create a support ticket and let us know what you would like to see beeing implemented into the radial menu.

(yes i know, this is the med system script, but since this release is working now with the radial menu its good to inform you as reader)


🛠 **Requirements**
- ESX Server
- HW Radial Menu --> Optional

🌐 **Requirements Download links**
- es_extended: [https://github.com/esx-framework/esx_core]
- hw_radialmenu: [https://github.com/HenkW00/hw_radialmenu] (This is only needed if you use the radial menu script, since we can retreive med stats via export)

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
