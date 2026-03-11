# Releasing `mac-mp4-screen-rec`

This tap currently has two tracks:

- Stable: tagged GitHub releases from `arch1904/MacMp4ScreenRec`
- HEAD: the `main` branch of `arch1904/MacMp4ScreenRec`

## Update Stable To A New Release

1. Push the source repo changes to `main`.

```bash
cd ~/Desktop/Repos/MacMp4ScreenRec
git add .
git commit -m "Release v1.2.0"
git push origin main
```

2. Create and push the source tag.

```bash
git tag v1.2.0
git push origin v1.2.0
```

3. Wait until GitHub serves the tag tarball, then compute the real checksum from that URL.

```bash
curl -L https://github.com/arch1904/MacMp4ScreenRec/archive/refs/tags/v1.2.0.tar.gz | shasum -a 256
```

4. Update the tap formula with the new version and checksum.

```bash
cd ~/Desktop/Repos/homebrew-mac-mp4-screen-rec
chmod +x script/update-release-formula.sh
script/update-release-formula.sh 1.2.0 <sha256-from-step-3>
```

5. Commit and push the tap update.

```bash
git add Formula/mac-mp4-screen-rec.rb script/update-release-formula.sh RELEASING.md
git commit -m "Release mac-mp4-screen-rec v1.2.0"
git push origin main
```

6. Verify from Homebrew.

```bash
brew update
brew upgrade mac-mp4-screen-rec
brew info mac-mp4-screen-rec
```

## Notes

- Do not use a locally generated archive checksum. Homebrew stable must match the tarball GitHub actually serves for the tag URL in the formula.
- Until stable is updated, users can install the unreleased version with:

```bash
brew reinstall --HEAD mac-mp4-screen-rec
```
