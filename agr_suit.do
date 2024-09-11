*importing CSV/Excel files into Stata

*setting WD
clear all
cd "E:\sem 6\Thesis\MainWork"

*calling in the CSV file containg data on societies and agricultural suitability for barley
import delimited eth_brl_suit, clear
drop if v33=="missing data"
gen stat_hir = 1 if v33 =="Three levels" | v33=="Two levels"
replace stat_hir=0 if stat_hir != 1
ren dn brl_suit
collapse (mean) avg_brl_suit = brl_suit [aw=area_1], by(id)

save "E:\sem 6\Thesis\MainWork\eth_brl"

clear all
*calling in the CSV file containg data on societies and agricultural suitability for barley
import delimited eth_fml_suit, clear
drop if v33=="missing data"
gen stat_hir = 1 if v33 =="Three levels" | v33=="Two levels"
replace stat_hir=0 if stat_hir != 1
ren dnfml fml_suit
collapse (mean) avg_fml_suit = fml_suit [aw=area_1], by(id)

save "E:\sem 6\Thesis\MainWork\eth_fml"

clear all
*calling in the CSV file containg data on societies and agricultural suitability for barley
import delimited eth_mze_suit, clear
drop if v33=="missing data"
gen stat_hir = 1 if v33 =="Three levels" | v33=="Two levels"
replace stat_hir=0 if stat_hir != 1
ren dnmze mze_suit
collapse (mean) avg_mze_suit = mze_suit [aw=area_1], by(id)

save "E:\sem 6\Thesis\MainWork\eth_mze"

clear all
*calling in the CSV file containg data on societies and agricultural suitability for barley
import delimited eth_pml_suit, clear
drop if v33=="missing data"
gen stat_hir = 1 if v33 =="Three levels" | v33=="Two levels"
replace stat_hir=0 if stat_hir != 1
ren dnpml pml_suit
collapse (mean) avg_pml_suit = pml_suit [aw=area_1], by(id)

save "E:\sem 6\Thesis\MainWork\eth_pml"

clear all
*calling in the CSV file containg data on societies and agricultural suitability for barley
import delimited eth_rce_suit, clear
drop if v33=="missing data"
gen stat_hir = 1 if v33 =="Three levels" | v33=="Two levels"
replace stat_hir=0 if stat_hir != 1
ren dnrce rce_suit
collapse (mean) avg_rce_suit = rce_suit [aw=area_1], by(id)

save "E:\sem 6\Thesis\MainWork\eth_rce"

clear all
*calling in the CSV file containg data on societies and agricultural suitability for barley
import delimited eth_srg_suit, clear
drop if v33=="missing data"
gen stat_hir = 1 if v33 =="Three levels" | v33=="Two levels"
replace stat_hir=0 if stat_hir != 1
ren dnsrg srg_suit
collapse (mean) avg_srg_suit = srg_suit [aw=area_1], by(id)

save "E:\sem 6\Thesis\MainWork\eth_srg"

clear all
*calling in the CSV file containg data on societies and agricultural suitability for barley
import delimited eth_whe_suit, clear
drop if v33=="missing data"
gen stat_hir = 1 if v33 =="Three levels" | v33=="Two levels"
replace stat_hir=0 if stat_hir != 1
ren dnwhe whe_suit
collapse (mean) avg_whe_suit = whe_suit [aw=area], by(id)

save "E:\sem 6\Thesis\MainWork\eth_whe"

merge 1:1 id using eth_srg.dta
drop _merge
merge 1:1 id using eth_rce.dta
drop _merge
merge 1:1 id using eth_pml.dta
drop _merge
merge 1:1 id using eth_mze.dta
drop _merge
merge 1:1 id using eth_fml.dta
drop _merge
merge 1:1 id using eth_brl.dta
drop _merge

gen tot_suit = (cond(avg_whe_suit != ., avg_whe_suit, 0) + ///
                         cond(avg_srg_suit != ., avg_srg_suit, 0) + ///
                         cond(avg_rce_suit != ., avg_rce_suit, 0)+ ///
                         cond(avg_pml_suit != ., avg_pml_suit, 0)+ ///
                         cond(avg_mze_suit != ., avg_mze_suit, 0)+ ///
                         cond(avg_fml_suit != ., avg_fml_suit, 0)+ ///
                         cond(avg_brl_suit != ., avg_brl_suit, 0))

gen count_nonmissing = (avg_whe_suit != .) + (avg_srg_suit != .) + (avg_rce_suit != .) + (avg_pml_suit != .) + (avg_mze_suit != .) + (avg_fml_suit != .) + (avg_brl_suit != .)

gen avg_suit = tot_suit / count_nonmissing

save "E:\sem 6\Thesis\MainWork\eth_tot"
