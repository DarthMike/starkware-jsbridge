To avoid having to compose several required libraries together, it's simpler to use a single bundled JS file.

Use this package:
https://github.com/pedrouid/starkware-crypto

Then either build locally and build the bundled file, or install through npm:
`npm install -g starkware-crypto`

Go to the installed library directory, (default `/usr/local/lib/node_modules/starkware-crypto`), then grab the single bundled JS file under `dist/umd`, so it's easier to inject into a `JSContext`

The file 'index.min.js' is here copied directly in project.
