context("Exploratory Factor Analysis -- Verification project")

# does not test
# - error handling
# - orthogonal rotation
# - Eigen values above / manual
# - contents of screeplot (set.seed does not work)

## Testing Questionnaire data 

options <- jaspTools::analysisOptions("ExploratoryFactorAnalysis")
options$factorMethod <- "parallelAnalysis"
options$rotationMethod <- "orthogonal"
options$orthogonalSelector <- "varimax"
options$kmotest <- TRUE
options$bartest <- TRUE
options$incl_screePlot <- TRUE
options$variables <- c(paste("Question", 1:9, sep="_0"), paste("Question", 10:23, sep="_"))
options$eigenValuesBox <- 1
options$fitmethod <- "pa"
options$highlightText <- 0.4
options$obliqueSelector <- "oblimin"


set.seed(1)
results <- jaspTools::runAnalysis("ExploratoryFactorAnalysis", "EFA.csv", options)


# https://jasp-stats.github.io/jasp-verification-project/factor.html#exploratory-factor-analysis
test_that("Kaiser-Meyer-Olkin test match R, SPSS, SAS, MiniTab", {
  resultTable <- results$results$modelContainer$collection$modelContainer_kmotab$data
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list("Overall MSA
", 0.930224499116479, "Question_01", 0.929761029851962,
               "Question_02", 0.87477543869641, "Question_03", 0.951037837608159,
               "Question_04", 0.955340346281847, "Question_05", 0.960089249619342,
               "Question_06", 0.891331391519047, "Question_07", 0.941679983971416,
               "Question_08", 0.871305450734792, "Question_09", 0.833729474658888,
               "Question_10", 0.948685759035385, "Question_11", 0.905933843822659,
               "Question_12", 0.954832379044363, "Question_13", 0.948226989113007,
               "Question_14", 0.967172177880905, "Question_15", 0.940440196823871,
               "Question_16", 0.933643944530183, "Question_17", 0.930620540762248,
               "Question_18", 0.947950840512207, "Question_19", 0.940702074165196,
               "Question_20", 0.889051428926174, "Question_21", 0.929336944448063,
               "Question_22", 0.878450847770398, "Question_23", 0.76639940895877)
  )
})


# https://jasp-stats.github.io/jasp-verification-project/factor.html#exploratory-factor-analysis
test_that("Bartlett's test match R, SPSS, SAS, MiniTab", {
  resultTable <- results$results$modelContainer$collection$modelContainer_bartab$data
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list(19334.4919887839, 253, 0)
  )
})

# https://jasp-stats.github.io/jasp-verification-project/factor.html#exploratory-factor-analysis
test_that("Chi-squared Test table results match R, SPSS, SAS, MiniTab", {
  resultTable <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_goftab"]][["data"]]
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list(1166.49275431232, 167, "Model", 2.05253874626043e-149)
  )
})



# https://jasp-stats.github.io/jasp-verification-project/factor.html#exploratory-factor-analysis
test_that("Factor Loadings table results match R, SPSS, SAS, MiniTab", {
  resultTable <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_loatab"]][["data"]]
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list(0.504443068600037, "", "", "", 0.62706699829401, "Question_01",
               "", "", "", 0.464435993252366, 0.739566273641575, "Question_02",
               -0.504752555500398, "", "", "", 0.527897850195385, "Question_03",
               0.527234647096963, "", "", "", 0.580667195632203, "Question_04",
               0.435703345283996, "", "", "", 0.701443047559466, "Question_05",
               "", 0.752227670605963, "", "", 0.406800622132955, "Question_06",
               "", 0.559109959464811, "", "", 0.511460467477405, "Question_07",
               "", "", 0.758761772699984, "", 0.35443175468058, "Question_08",
               "", "", "", 0.5588079331129, 0.661507864735525, "Question_09",
               "", "", "", "", 0.802836465382577, "Question_10", "", "", 0.687755278680838,
               "", 0.370538941689453, "Question_11", 0.510111383189127, "",
               "", "", 0.546632542253933, "Question_12", "", 0.564234988703368,
               "", "", 0.526185953600992, "Question_13", "", 0.485499971502765,
               "", "", 0.575078150674822, "Question_14", "", "", "", "", 0.678066883985776,
               "Question_15", 0.543183965236721, "", "", "", 0.542301630651373,
               "Question_16", "", "", 0.640921688314853, "", 0.42443552431156,
               "Question_17", "", 0.612049563761631, "", "", 0.456125933778706,
               "Question_18", "", "", "", "", 0.75505210830241, "Question_19",
               0.464661270843535, "", "", "", 0.733931975694471, "Question_20",
               0.594343110473497, "", "", "", 0.532349713500281, "Question_21",
               "", "", "", 0.465060148217776, 0.752705017167598, "Question_22",
               "", "", "", "", 0.883748278190796, "Question_23")
  )
})

# https://jasp-stats.github.io/jasp-verification-project/factor.html#exploratory-factor-analysis
test_that("Factor Characteristics table results match R, SPSS, SAS, MiniTab", {
  resultTable <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_eigtab"]][["data"]]
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list("Factor 1", 0.131897550845727, 3.03364366945173, 0.131897550845727,
               "Factor 2", 0.256005905753789, 2.85449216288541, 0.124108354908062,
               "Factor 3", 0.342351093761207, 1.98593932417061, 0.0863451880074181,
               "Factor 4", 0.404746469846354, 1.43509364995838, 0.0623953760851471
    )
  )
})


# test_that("Scree plot matches", {
#   skip("Scree plot check does not work because some data is simulated (non-deterministic).")
#   # plotName <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_scree"]][["data"]]
#   # testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
#   # jaspTools::expect_equal_plots(testPlot, "scree-plot", dir = "ExploratoryFactorAnalysis")
# })

options <- jaspTools::analysisOptions("ExploratoryFactorAnalysis")
options$factorMethod <- "manual"
options$fitmethod <- "minres"
options$highlightText <- 0.4
options$incl_correlations <- TRUE
options$incl_fitIndices <- TRUE
options$incl_pathDiagram <- TRUE
options$incl_screePlot <- TRUE
options$incl_structure <- TRUE
options$numberOfFactors <- 2
options$obliqueSelector <- "geominQ"
options$rotationMethod <- "oblique"
options$variables <- list("contWide", "contcor1", "contcor2", "facFifty", "contExpon", 
                          "debCollin1", "debEqual1")
set.seed(1)
results <- jaspTools::runAnalysis("ExploratoryFactorAnalysis", "debug.csv", options)



test_that("Factor Correlations table results match", {
  table <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_cortab"]][["data"]]
  jaspTools::expect_equal_tables(table,
                      list(1, -0.0849326, "Factor 1", -0.0849326, 1, "Factor 2"))
})

test_that("Factor Characteristics table results match", {
  table <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_eigtab"]][["data"]]
  jaspTools::expect_equal_tables(table,
                      list("Factor 1", 0.211560139236826, 1.48092097465778, 0.211560139236826,
                           "Factor 2", 0.36610038604766, 1.08178172767584, 0.154540246810834
                      ))
})

test_that("Additional fit indices table results match", {
  table <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_fittab"]][["data"]]
  jaspTools::expect_equal_tables(table,
                      list(-32.7898349546892, 0, "0 - 0.065", 1.20127892716016))
})

test_that("Chi-squared Test table results match", {
  table <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_goftab"]][["data"]]
  jaspTools::expect_equal_tables(table,
                      list(4.05152653321549, 8, "Model", 0.85244487039262))
})

test_that("Factor Loadings table results match", {
  table <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_loatab"]][["data"]]
  jaspTools::expect_equal_tables(table,
                      list("", "", 0.951432334368898, "contWide", 0.654092561077089, "",
                           0.57413710933047, "contcor1", 1.00020594814694, "", -0.00255707470903843,
                           "contcor2", "", "", 0.953108905280117, "facFifty", "", 0.997800455330077,
                           0.00428892032601724, "contExpon", "", "", 0.998135387367175,
                           "debCollin1", "", "", 0.958751715702742, "debEqual1"))
})

test_that("Path Diagram plot matches", {
  plotName <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_path"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
  jaspTools::expect_equal_plots(testPlot, "path-diagram", dir = "ExploratoryFactorAnalysis")
})

test_that("Scree plot matches", {
  skip("Scree plot check does not work because some data is simulated (non-deterministic).")
  plotName <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_scree"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
  jaspTools::expect_equal_plots(testPlot, "scree-plot", dir = "ExploratoryFactorAnalysis")
})

test_that("Factor Loadings (Structure Matrix) table results match", {
  table <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_strtab"]][["data"]]
  jaspTools::expect_equal_tables(table,
                      list("", "", "contWide", 0.651914307711847, "", "contcor1", 1.00118914256335,
                           "", "contcor2", "", "", "facFifty", "", 0.997852981864278, "contExpon",
                           "", "", "debCollin1", "", "", "debEqual1"))
})

test_that("Missing values works", {
  options <- jaspTools::analysisOptions("ExploratoryFactorAnalysis")
  options$variables <- list("contNormal", "contGamma", "contcor1", "debMiss30")
  options$incl_correlations <- TRUE
  
  options$missingValues <- "pairwise"
  results <- jaspTools::runAnalysis("ExploratoryFactorAnalysis", "test.csv", options)
  table <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_goftab"]][["data"]]
  jaspTools::expect_equal_tables(table, list("Model", 1.42781053334818, 2L, 0.489727939944839), label = "pairwise")
  
  options$missingValues <- "listwise"
  results <- jaspTools::runAnalysis("ExploratoryFactorAnalysis", "test.csv", options)
  table <- results[["results"]][["modelContainer"]][["collection"]][["modelContainer_goftab"]][["data"]]
  jaspTools::expect_equal_tables(table, list("Model", 0.491396758561133, 2L, 0.782158104440787), label = "listwise")
})

