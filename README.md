# t-TEST

**t-test** is a type of inferential statistic used to determine if there is a significant difference between the means of two groups.
If we are comparing the mean of two different groups, this is called a **two-sample t-test**. 
We can also use a t-test to compare the mean of a group against a known value, this is a **one-sample t-test**.


## About the t-test test app

Has three tabs:
1. Data View, where you can select the data and see a summary of it
2. t-test, here you can perform the t-test
3. Help, gives an overview of the app and how to use it

### Checkout and run

You can clone this repository by using the command:

```
git clone https://github.com/aridhia/demo-t-test
```

Open the .Rproj file in RStudio, source the script `dependencies.R` to install all the packages required by the app, and run `runApp()` to start the app.

### Deploying to the workspace

1. Download this GitHub repo as a .zip file.
2. Create a new blank Shiny app in your workspace called "t-test".
3. Navigate to the `t-test` folder under "files".
4. Delete the `app.R` file from the `t-test` folder. Make sure you keep the `.version` file!
5. Upload the .zip file to the `t-test` folder.
6. Extract the .zip file. Make sure "Folder name" is blank and "Remove compressed file after extracting" is ticked.
7. Navigate into the unzipped folder.
8. Select all content of the unzipped folder, and move it to the `t-test` folder (so, one level up).
9. Delete the now empty unzipped folder.
10. Start the R console and run the `dependencies.R` script to install all R packages that the app requires.
11. Run the app in your workspace.

For more information visit https://knowledgebase.aridhia.io/article/how-to-upload-your-mini-app/
