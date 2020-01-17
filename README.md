Hakyll + Tex Live docker image.

## How To

```bash
docker run --rm -p 8000:8000 -it -v $(pwd):/site docker.pkg.github.com/qjqqyy/hakyll-latex/hakyll-latex
```

Will build `$PWD/site.hs` and run `./site watch --host=0.0.0.0`.
