# script-engine
Run python scripts automatically every minute, half hour, hour or day on linux.

## Table of content

- [Motivation](#motivation)
- [Installation & Usage](#installation--usage)
    - [Installation](#installation)
    - [Usage](#usage)
- [Contributing](#contributing)
- [History](#history)
- [Credits](#credits)
- [License](#license)

## Motivation
I needed a simple way to run some python scripts on my Raspbery Pi to collect home automation data at regular intervals.

## Installation & Usage

### Installation
1. Download the files in this project
2. scp the entire contents of the src folder to /jffs (scp -rp src/* zain@192.168.2.1:/jffs/scripts)
3. Make all files executable (chmod -R a+rx /jffs/scripts/*)
4. Reboot your router

### Usage
Write your bash script and simply drop it into the appropriate folder. For example if i wanted the scrip to run every minute i would need to drop it into <user home folder>/script-engine/minute

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History
v0.1: Beta

## Credits
- Template for this README is <a href="https://github.com/gitzain/template-README">Template-README</a> created by <a href="https://iamzain.com">Zain Khan</a>

## License
See the LICENSE file in this project's directory.
