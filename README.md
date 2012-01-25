# refh

This is a little command-line tool for pasting to <https://refheap.com>.
It requires at least version 1.9.2 of Ruby.

```
68-245-171-115:refh anthony$ refh --help
Refh is a simple command-line application for pasting to https://refheap.com

Usage:
      refh [options] <filename>
      refh [options]

If the second form is used, input will be expected on stdin. 

Options are:
       --private, -p:   Make the paste private.
  --language, -l <s>:   Set the language for this paste.
      --user, -u <s>:   Set username.
     --token, -t <s>:   Set token.
          --anon, -a:   Make this paste anonymous, regardless of username and
                        token settings.
       --version, -v:   Print version and exit
          --help, -h:   Show this message
```

If you don't explicitly set `--language`, refh will try to determine it
from the file extension. `--language` must be set to a string that is of
the same format as the language appears in the dropdown box on the
[refheap website](https://refheap.com).

If you don't want to pass your `--user` and `--token` each time, you can
set it in `~/.refh.yml`. The file should look like this:

```yaml
68-245-171-115:refh anthony$ cat ~/.refh.yml 
---
user: Raynes
token: REMOVED
``` 
