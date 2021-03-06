% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qa_package.R
\name{qa_attributes}
\alias{qa_attributes}
\title{Check congruence of data and metadata attributes for a tabular data object}
\usage{
qa_attributes(entity, data, eml = NULL, check_attribute_classes, skip)
}
\arguments{
\item{entity}{(eml) An EML \code{dataTable}, \code{otherEntity}, or \code{spatialVector} associated with the data object.}

\item{data}{(data.frame) A data frame of the data object.}

\item{eml}{(S4) The entire EML object. This is necessary if attributes with references are being checked.}

\item{check_attribute_classes}{(logical) Check if column types match attribute measurementscale.  For example "ratio"
measurementScale should contain integer or numeric data.  These checks often fail, for example read.table will often read
in dateTime formats as character values - which triggers a warning.  Set \code{check_attribute_classes = FALSE} to skip
these checks.}

\item{skip}{(integer) If \code{qa_package} has a \code{skip} argument that does not equal zero we need to pass it into
this function. This function will check the "numHeaderLines" slot to find out how many lines to skip before it finds the
header row.  However, if we use \code{skip} to read in data, this will be the incorrect line.  Therefore if skip != 0 we
need to ignore the code block that checks "numHeaderLines" in the \code{entity} physical.}
}
\value{
\code{NULL}
}
\description{
This function checks the congruence of data and metadata attributes
for a tabular data object. Supported objects include \code{dataTable}, \code{otherEntity},
and \code{spatialVector} entities. It can be used on its own but is also
called by \code{\link[=qa_package]{qa_package()}} to check all tabular data objects in a data package.
}
\details{
This function checks the following:
\itemize{
\item Names: Check that column names in attributes match column names in data frame. Possible conditions to check for:
\itemize{
\item attributeList does not exist for data frame
\item Some of the attributes that exist in the data do not exist in the attributeList
\item Some of the attributes that exist in the attributeList do not exist in the data
\item Typos in attribute or column names resulting in nonmatches
}
\item Domains: Check that attribute types in EML match attribute types in data frame. Possible conditions to check for:
\itemize{
\item nominal, ordinal, integer, ratio, dateTime
\item If domain is enumerated domain, enumerated values in the data are accounted for in the enumerated definition
\item If domain is enumerated domain, enumerated values in the enumerated definition are all represented in the data
\item Type of data does not match attribute type
}
\item Values: Check that values in data are reasonable. Possible conditions to check for:
\itemize{
\item Accidental characters in the data (e.g., one character in a column of integers)
\item If missing values are present, missing value codes are also present
}
}
}
\examples{
\dontrun{
# Checking a .csv file
dataTable <- eml@dataset@dataTable[[1]]
data <- readr::read_csv("https://cn.dataone.org/cn/v2/resolve/urn:uuid:...")

qa_attributes(dataTable, data)
}
}
\seealso{
\code{\link[=qa_package]{qa_package()}}
}
