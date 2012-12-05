# refh

This is a sexy little command line client for
[refheap](https://www.refheap.com). It can do amazingly awesome things like
create pastes for you.

## How it works

```
penumbra:refh raynes$ refh -?
refh v0.1.0

args [OPTIONS]

Common flags:
  -u --username=ITEM
  -t --token=ITEM   
  -c --copy           True by default. If true, copy resulting link to
                      clipboard.
  -l --language=ITEM  Must be exactly as the language name appears on
                      refheap's dropdown.
  -a --anon           Paste anonymously regardless of username and token
                      settings.
  -f --file=ITEM      Paste from this file instead of stdin. If extension is
                      present, use it to determine language.
  -p --private        False by default. If true, make paste private.
  -? --help           Display help message
  -V --version        Print version information
```

If a file isn't passed to `-f`, refh expects the body of the paste to be passed
to its stdin. The rest should be pretty straightforward.

## Installing

This is a Haskell program. If you happen to have Haskell and `cabal-install`
installed, you can install it with that

```
cabal install refh
```

If not, I'll put together some binaries for the various platforms. I don't have
access to Windows though, so unless someone contributes it, I can't produce
binaries for that.
