# furnish for Homebrew

[furnish](https://github.com/furnish-self-service/furnish) is a self-service app catalog for an organization's computers. This tap installs the desktop app and the `furnish` command on Macs with Apple silicon:

```sh
brew install --cask furnish-self-service/tap/furnish
```

`brew upgrade` installs new versions. furnish is in alpha: every change to its main branch is built and published here.

The app isn't signed yet, so macOS blocks it the first time it opens. Open furnish from Applications, then allow it under System Settings → Privacy & Security → Open Anyway. Do this before you use the `furnish` command. macOS asks again after each upgrade until the app is signed.

`brew uninstall --cask furnish` keeps your settings and collections. `brew uninstall --cask --zap furnish` also removes them and the sign-in item.

The cask in `Casks/furnish.rb` is updated by furnish's CI. Make changes to it here; the CI only changes `version` and `sha256`.
