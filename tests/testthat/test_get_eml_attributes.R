context("Get EML attributes")

cn <- dataone::CNode("PROD")
mn <- dataone::getMNode(cn,"urn:node:ARCTIC")
eml <- EML::read_eml(rawToChar(dataone::getObject(mn, "doi:10.18739/A23W02")))

# loads the correct output .rdata object for get_eml_attributes unit tests
path <- system.file("get_eml_attributes_output.Rdata", package = "datamgmt")
load(path)

test_that("error checks function correctly", {
    expect_error(get_eml_attributes(5))
    expect_error(get_eml_attributes("dummy eml"))
})

test_that("get_eml_attributes 'eml' argument outputs the correct .RData object", {
    results <- get_eml_attributes(eml)
    expect_equal(results, get_eml_attributes_output)
})

test_that("get_eml_attributes_url outputs the correct .RData object", {
    results <- get_eml_attributes_url(mn, "https://arcticdata.io/catalog/#view/doi:10.18739/A23W02")
    expect_equal(results, get_eml_attributes_output)
})

test_that("download_eml_attributes functions correctly", {
    download_eml_attributes(eml, tempdir(), TRUE) # this isn't working

    file_path <- file.path(tempdir(),
                           "doi1018739A23W02_2013_2014_winter_N2_dissoxy_attributes.csv")
    expect_true(file.exists(file_path))

    att <- read.csv(file_path, stringsAsFactors = FALSE)
    expect_equivalent(dim(att), c(5,13))

    expect_equal(att$attributeName[2], "3.3")
})

# test_that("get_eml_attributes can switch to a different node", {
#     cn <- dataone::CNode('PROD')
#     knb <- dataone::getMNode(cn,"urn:node:KNB")
#     attributes <- get_eml_attributes(knb, "https://knb.ecoinformatics.org/#view/doi:10.5063/F1639MWV")
#
#     expect_length(attributes, 2)
#
#     expect_equal(dim(attributes$DataTeam_BOF_Proposal_Coding0131.csv[[1]]), 19)
#     expect_equal(dim(attributes$DataTeam_BOF_Proposal_Coding0131.csv[[1]])[2], 17)
#
# })
