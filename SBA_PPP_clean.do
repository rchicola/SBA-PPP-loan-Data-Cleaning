
***********************************************
*SBA PPP LOAN DATA CLEANING
***********************************************

*Set Working Directory
cd "C:\Users\Randall\Desktop\GA Harris\SBA_clean_03-03-21 Paycheck Protection Program Data"



*Need to convert files from csv to dta "Stata" files
ssc install xls2dta
ssc install filelist
filelist
*Found all files, make sure all excel windows closed or filelist gives error

*Convert to .dta files for stata (I first resaved the original csv as .xlsx )
xls2dta : import excel using "C:\Users\Randall\Desktop\GA Harris\SBA_clean_03-03-21 Paycheck Protection Program Data" , firstrow

local allfiles: dir . files "public_up_to_150k_*.dta", respectcase

forvalues f=1/8 {
	*local w = substr(`"`f'"',1,1)
	use "public_up_to_150k_`f'.dta", clear
	drop if missing(BorrowerZip) & missing(BorrowerState)
	tostring NAICSCode, gen(strNAICSCode)
	drop if length(strNAICSCode) < 6
	*gettoken filename : ith_file , parse(".")
	save "public_up_to_150k_`f'_cleaned.dta" , replace
	
}


