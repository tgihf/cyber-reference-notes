# [phoneinfoga](https://github.com/sundowndev/phoneinfoga)

> Go tool for gathering information related to a phone number, including location, carrier, line type, and Internet appearances.

---

## Gather Phone Number Information via Command Line

```bash
phoneinfoga scan -n $PHONE_NUMBER_WITH_COUNTRY_CODE
```

- `$PHONE_NUMBER_WITH_COUNTRY_CODE` example: `12223333`.

---

## Serve `phoneinfoga` and Gather Phone Number Information via Web Application

```bash
phoneinfoga serve -p $PORT_TO_SERVE_PHONEINFOGA
```

`phoneinfoga` will start a web application on `$PORT_TO_SERVE_PHONEINFOGA`. You can visit this web application in your browser by navigating to `http://localhost:$PORT_TO_SERVE_PHONEINFOGA`.

From the web application interface you can initiate scans and view the results.
