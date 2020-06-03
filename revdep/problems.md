# xROI

<details>

* Version: 0.9.16
* Source code: https://github.com/cran/xROI
* BugReports: https://github.com/bnasr/xROI/issues
* Date/Publication: 2020-05-24 15:20:02 UTC
* Number of recursive dependencies: 103

Run `revdep_details(,"xROI")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### Title: Plot or add a mask
    > ### Aliases: addMask
    > ### Keywords: mask plot raster
    > 
    > ### ** Examples
    > 
    > 
    > #read a mask file in TIFF format
    > m <- tiff::readTIFF(system.file(package = 'xROI', 'dukehw-mask.tif'))
    > str(m)
     num [1:320, 1:432] 1 1 1 1 1 1 1 1 1 1 ...
    > 
    > #plot the mask in black color
    > addMask(m, add = FALSE)
    [1] 0
    > 
    > #add the same mask in the red color to the existing plot
    > addMask(m, add = TRUE, col = 'red')
    Error in .local(.Object, ...) : 
    Calls: addMask ... <Anonymous> -> new -> initialize -> initialize -> .local
    Execution halted
    ```

