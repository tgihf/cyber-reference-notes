# Transfering Files over HTTP

---

## Python Web Server

```bash
python3 -m http.server $PORT
```

---

## Node.js HTTP Client (`curl.js`)

```javascript
// curl.js
const http = require('http'); // or 'https' for https:// URLs
const fs = require('fs');

const file = fs.createWriteStream(process.argv[3]);
const request = http.get(process.argv[2], function(response) {
   response.pipe(file);

   // after download completed close filestream
   file.on("finish", () => {
       file.close();
       console.log("Download Completed");
   });
});
```

Usage:

```bash
node $PATH_TO_SCRIPT $URL $PATH_TO_OUTPUT_FILE
```
