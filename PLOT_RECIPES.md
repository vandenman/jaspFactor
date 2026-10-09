# Plot recipes

## Migrated

- PCA and EFA scree plots share `.factorScreePlot`. Recipes contain realized eigenvalues, series labels and axis settings. Parallel-analysis simulation remains in the analysis; redraw does not resimulate.
- CFA misfit heatmaps contain reshaped residual correlations and labels. Grouped and ungrouped callers share `.factorMisfitPlot`; recipes never contain the lavaan fit.
- Latent-class item-response probability bars contain prepared probabilities, factor levels, legend labels and settings. `.lcaDrawItemProbsPlot` builds mappings, legend expressions and palettes during drawing; fit objects stay out of the recipe.

## Postponed

- PCA/EFA qgraph path diagrams: separate graph preparation from layout/rendering. Store edge weights, node labels, groups, realized layout coordinates, colors and other plain drawing options; use a private renderer with device suppression. Preserve sign conventions, node ordering and graphical output under fixed seeds. Do not wrap fitted psych model objects or a populated qgraph object in a recipe.
- CFA semPlot path diagrams, including multigroup output: extract manifest/latent names, parameter tables, thresholds and fixed layout from the semPlot model. Reconstruct the minimal semPlot drawing input during rendering. Inspect S4 slots for environments rather than storing the fitted lavaan/semPlot model wholesale. Validate grouped layouts, labels and standardized parameters before migrating.

These postponed plots retain their existing implementation. This pass does not claim that all module plot state is environment-free.

## Validation

Use R-4.5.2. The lockfile pins recipe-capable jaspBase, jaspGraphs and jaspTools; other existing pins stay unchanged. Validation used an isolated installation and copies of the existing tests so snapshot cleanup could not affect the repository.

- Eleven producer cases passed exact SVG comparisons with the original drawing code, plain-argument inspection, serialization round trips, repeated rendering, RNG preservation and axis-title editing. Cases cover both scree plots, CFA heatmaps and all eight combinations of shared/different LCA categories, visible/hidden legends and rotated/unrotated labels.
- Four additional LCA decoder-path comparisons with encoded Unicode/spaced variable names preserved all text labels, legend mappings and bar colors. Text spacing can differ from legacy output: recipes decode names before measuring layout, while the old decoder replaces labels after grob construction. Exact SVG equivalence above concerns direct drawings with already readable names.
- Baseline and migrated full suites both returned 117 passes, one failure, five errors, no warnings and four skips. The same PCA G Factor scree snapshot failed in both; the same existing EFA/PCA table and estimation tests errored. These failures were reproduced before migration and were not accepted as new snapshots.
- Existing human-owned test files and reference snapshots were preserved. The focused comparison script ran outside the repository at `/tmp/factor-plot-recipes/validate.R` during this migration.

The pre-existing local `later` lockfile update remains in the working tree and is excluded from the migration commit.
