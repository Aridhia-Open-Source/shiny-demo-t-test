# t-TEST

**t-test** is a type of inferential statistic used to determine if there is a significant difference between the means of two groups.
If we are comparing the mean of two different groups, this is called a **two-sample t-test**. 
We can also use a t-test to compare the mean of a group against a known value, this is a **one-sample t-test**.


## About the t-test test app

Has three tabs:
1. Data View, where you can select the data and see a summary of it
2. T-test, here you can perform the t-test
3. Help, gives an overview of the app and how to use it

### Checkout and run

You can clone this repository by using the command:

```
git clone https://github.com/aridhia/demo-t-test
```

Open the .Rproj file in RStudio, source the script `dependencies.R` to install all the packages required by the app, and run `runApp()` to start the app.

### Deploying to the workspace

1. Create a new mini-app in the workspace called "t-test"" and delete the folder created for it
2. Download this GitHub repo as a .ZIP file, or clone the repository and zip all the files
3. Upload the .ZIP file to the workspace and upzip it inside a folder called t-test"
4. Run the `dependencies.R` script to install all the packages that the app requires
5. Run the app in your workspace

For more information visit https://knowledgebase.aridhia.io/article/how-to-upload-your-mini-app/
