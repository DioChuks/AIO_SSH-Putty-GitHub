```markdown
# Connecting SSH to GitHub via Putty or any other clients

If you're using cPanel, enable remote SSH access by either contacting the hosting support or toggling the access permission.

Once that is done, generate new valid key pairs (this includes a public and private key) and add a passphrase to it.
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
Open the contents of the public key and copy it, then go to GitHub account settings > SSH and GPG keys > click `New SSH key` and follow the rest instructions from there.

After that, go back to cPanel and download the private/public key as Putty file format or as original file format.

If downloaded as Putty file format, open Putty, head to `SSH > Auth > Credentials`, then select the path where it's saved on your local machine.

If not downloaded as Putty file format, then open Puttygen and click on `Conversions > Import key`, select the file, and click `Save as private key`.

Once that is done, setup host address and port, make sure to remember password if any, then click open and connect once or accept.

Once shell is opened, enter password if prompted, then turn on SSH agent with this command:
```bash
eval "$(ssh-agent -s)"
```
Then add the public key (this is due to wrong SSH key been used) with this command:
```bash
ssh-add ~/.ssh/NAME_OF_KEY_AS_SAVED_WHEN_CREATED
```
Then run the command for testing with GitHub:
```bash
ssh -vT git@github.com
```
If connected, the response will be: 
```
Hi USERNAME! You've successfully authenticated, but GitHub does not provide shell access.
```

### Make sure Key Algorithms are types of SHA-2, RSA, ECDSA (not allowed is SHA-1 and older).

**Note**: Contributions are accepted.
```
This markdown file provides clear instructions on how to connect SSH to GitHub via Putty or any other clients. It includes steps for both cPanel users and those not using cPanel, ensuring comprehensive guidance for users of different systems. Additionally, it emphasizes the importance of using secure key algorithms and encourages contributions.