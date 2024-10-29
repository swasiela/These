This is the working repository for my PhD thesis.

PDFs of the latest version can be found as artifacts for [final versions](https://gitlab.laas.fr/swasiela/thesis/-/jobs/artifacts/master/browse?job=build-finals) and [work versions](https://gitlab.laas.fr/swasiela/thesis/-/jobs/artifacts/master/browse?job=build-workdocs).

Direct links to latest built versions:
- [digital version](https://gitlab.laas.fr/swasiela/thesis/-/jobs/artifacts/master/raw/thesis-digital.pdf?job=build-finals)
- [print-optimized version](https://gitlab.laas.fr/swasiela/thesis/-/jobs/artifacts/master/raw/thesis-print.pdf?job=build-finals) versions)
- [normal work version](https://gitlab.laas.fr/swasiela/thesis/-/jobs/artifacts/master/raw/thesis-workdoc.pdf?job=build-workdocs)
- [annotable work version](https://gitlab.laas.fr/swasiela/thesis/-/jobs/artifacts/master/raw/thesis-workdoc-print-annotate.pdf?job=build-workdocs)

# Building the document

The [Makefile](./Makefile) provides several recipes, both for everyday use and for the CI pipelines.

The main ones are:
- `pdf`: Build the thesis work document and compress it using Ghostscript.
- `pdf-annotate`: Build the thesis work document with very wide margins, mainly for printing and annotating during the review process.
- `pdf-final`: Build the thesis without notes and compress it using Ghostscript (for screen viewing).
- `pdf-final-print`: Build the thesis without notes and compress it using Ghostscript (for printing).
- `clean`: Cleans the intermediate files but not the figures.
- `cleanall`: Same, but also cleans the figures' directory.

# Required Environment

The [Dockerfile](./utils/Dockerfile) can be used to obtain a suitable environment for building the document.
This image can also be found in the repository container: `gitlab.laas.fr:4567/swasiela/thesis`
