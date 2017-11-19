# Chrome Native Messaging for Node.js

Transform streams for writing Chrome App [native messaging][1] hosts in Node.js.

[1]: https://developer.chrome.com/extensions/messaging#native-messaging

```

## API

The module exports `Input`, `Output`, and `Transform` transform streams.

`Input` streams transform bytes to objects.

`Output` streams transform objects to bytes.

Use `Transform` to easily create custom object-to-object transform streams.


const nativeMessage = require('./wrapper');

process.stdin
    .pipe(new nativeMessage.Input())
    .pipe(new nativeMessage.Transform(function(msg, push, done) {
        var reply = getReplyFor(msg); // Implemented elsewhere by you.
        push(reply);                  // Push as many replies as you like.
        done();                       // Call when done pushing replies.
    }))
    .pipe(new nativeMessage.Output())
    .pipe(process.stdout)
;
```

## Example

The `extension` directory contains a sample Chrome Extension.

The `host.js` contains a native messaging host that you can send
messages to.

Go to the Chrome Extensions page (chrome://extensions/), hit "Load unpacked
extension...", and select this project's `extension` directory.

SUPER IMPORTANT: Find the ID your app received when you loaded it and copy it
to the host manifest in the `native-messaging` directory.

SUPER IMPORTANT ON MACS: The path to the host must be absolute. Make sure the
"path" property in the manifest is correct (it's probably not unless you're me).

Install the host manifest:

```
sudo ./register.sh
```

On Windows (Run as Administrator):

```
register.bat
```
