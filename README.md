# Bayesian Modelling of the Well-Made Surprise - Supplemental materials

## Stories

The `stories.csv` file contains a summary of all of the stories used in the study. For each story variant, it includes:
 - The story's title, as presented in the paper.
 - The ID, which is used to reference this variant throughout the material.
 - The story's companion ID, which is the ID of the other variant with the same title.
 - The associated quality this story was used to measure.
 - The expected value of the associated quality, as either high or low. A story variant with a high expected value will have a companion of low expected value, and vice versa.
 - The full text, split into setup, reveal and explanation. Some stories do not have an explanation.

## Survey files

- `survey.qsf`
  The Qualtrics survey file used in this study.

- `results.csv`
  The raw Qualtrics results data, in which each line is one full survey completed by a participant, and each line has an associated participant `id`.
  Any identifying data has been stripped from this file.
  Note that the file is in an unusual CSV format with multiple rows of headers before the data begins on row 7.

- `results-likert.csv`
  A first transformation of the `results.csv` to reduce redundant information and provide clearer headers.
  Each row contains the same `id`, as well as one column for each likert question asked to that participant.

- `results-weights.csv`
  A second transformations of the `results-likert.csv` file, replacing each Likert scale answer with the corresponding value according to the conversion keys described in the paper.

- `results-aggregated.csv`
  A third transformation of the `results-weights.csv` file, in which the weights across each item are averaged together for each quality and comprehension. 

## Inference files

In the `inference` directory, there is one subdirectory per story variant ID.
In each of story subdirectories, the following files are present:

- `d.txt`, `c.txt`
  The list of ground atoms included in the divergence blanket D and certainty blanket C, as described in the paper.

In each subdirectory, there will be a `models` subdirectory, and inside it again two subdirectories, named after the matching model, `flawed` and `truth`.
For instance, `inference/abc/models/truth` is the truth model of the story with ID `abc`, while `inference/def/models/flawed` is the flawed model of the story with ID `def`.

In each model subdirectory, the following files are present:
- `input.mln`
  The input MLN passed to Alchemy, in the format described by Alchemy's documentation.
  At the top of the files are domain definitions, followed by predicate definitions, and finally rules.
  Each rule has a numerical weight preceding it - strong rules are modelled as having a very large weight (999).

- `input.db`
  The input known priors passed to Alchemy (i.e. atoms of a known value).
  Note that in the current implementation, this file is always empty, and we model known values of atoms as strong rules in the `input.mln` file instead, in order to prevent Alchemy from automatically culling parts of the ground MLN graph.

- `query.db`
  The query atom set passed to Alchemy.
  Note that in the current implementation, this simply includes every ground atom in the domain of the model.

- `alchemy.out`, `alchemy.err`
  Any output or error messages returned by Alchemy.

- `output.result`
  The output of Alchemy inference, in the form of a probability for each ground atom.

## Statistical tests files

In the `tests` directory, there is one subdirectory named after each story quality tested.
In each of the subdirectories, there is a directory per story pair tested.
For instance, `tests/consistency/abc` contains the statistical test for consistency of the story pair containing the story with ID abc and its matching variant.

In each test subdirectory, the following files are present:

- `data.csv`
  The processed data used in the statistical test.
  This file has an `id` column matching the `id` in the resulds files, and two other columns containing the aggregated value for that row, story and quality after filtering out rows with comprehension < 0.25, as described in the paper.

- `script.r`
  The R script ran in this directory to obtain the test's result.

- `r.out`, `r.err`
  Any output or error messages returned by R.

- `out.csv`
  The result of the statistical test, as returned by R.
