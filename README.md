# alfred-imgur-tor

Alfred workflow to upload image files from your Finder to [Imgur](https://imgur.com).

## Installation

### Pre-reqs

* install [JSON Helper](http://www.appstore.com/mac/jsonhelperforapplescript)

* install [torsocks](https://github.com/dgoulet/torsocks) using `brew install torsocks` (get [Homebrew — The missing package manager for OS X](http://brew.sh/))

1. Download the latest release:  
  <http://www.packal.org/workflow/imgur-uploader>
2. **Open Tor**, [to create your API keys on Imgur from your anonymous accout](http://api.imgur.com/oauth2/addclient)
 1. Set *Authorization type* to `Anonymous usage without user authorization`
 2. Set *Authorization callback URL* to any valid URL you want (because we don't need that callback but Imgur wants you to set one), for example: `https://imgur.com`
3. Add your client ID in `~/.alfred-imgur-tor.conf`:  
  `echo "{{KEY}}" > ~/.alfred-imgur-tor.conf`

## Usage

* Select a image file in your Finder
* Upload using
 * the `torimgur` Alfred keyword

## Version

1.0.0

## License

[MIT](LICENSE)
