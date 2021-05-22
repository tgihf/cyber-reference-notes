# Extracting Files from Bro Logs

1. Use `bro-cut` to determine the file's ID

    ```bash
    cat files.log | bro-cut filename fuid | grep $FILENAME
    ```

2. You can find the file in the `extracted` directory using the `file ID`

    ```bash
    ls -la /nsm/bro/extracted | grep $FUID
    ```
