# Prescription Manual
  A web app project to replace the original prescription manual at a local hospital in Taiwan, with enhanced features including searching, filtering and modifying of medication information.
  This is the 1.0 version of the system. Minor changes including user authentification and .NET version were made to adapt to the hospital's development system before being officially adopted by the hospital. The modified version of this website is currently in use at the hospital.

## Dynamic Pages and features
### View.aspx
The page withf tree-view that allows users to browse through all medicines arranged in categories and subcategories. Accepts an optional GET parameter `expand` that accepts the ID of a category or subcategory and expands the corresponding part of the tree-view.
![Image](https://i.imgur.com/nvW8dP5.png)

### Search.aspx
The page containing the filter and search bar to search for a specific medicine based on any of its names.
![Image](https://i.imgur.com/z4EE089.png)

### ViewMedicine.aspx
The page showing the medication information of a specific medicine, based on the medicine ID passed in as the GET parameter `id`.
![Image](https://i.imgur.com/MoIPO3O.png)

### NewMedicine.aspx
The "new medicine" page allowing users to add new medicine to the system. Contains the feature of the auto-assigning of IDs and auto-detecting of missing IDs. Calls the `verifyID()` function in Scripts/custom-scripts.js, which sends a XMLHttpRequest to IDVerification.aspx and returns the auto-assigned ID.
![Image](https://i.imgur.com/bt5IPQb.png)
Missing IDs are detected and reported to the user by a message box:
![Image](https://i.imgur.com/pa2JCGG.png)

### UpdateMedicine.aspx
The "update medicine" page allowing users to edit existing medicine.
![Image](https://i.imgur.com/41NK66V.png)

### UpdateCategory.aspx
An auto-generated page that corresponds to the "Category" data table, allowing users to add, delete or modify category numbers and names.
![Image](https://i.imgur.com/guKrifN.png)

### UpdateSubCategory.aspx
An auto-generated page that corresponds to the "SubCategory" data table, allowing users to add, delete or modify sub-category numbers and names.
![Image](https://i.imgur.com/woBiz5v.png)

### IDVerification.aspx
Checks if the medication ID is out of range (of its chosen category) and if an ID is already used. This serves as the backend server of the `verifyID()` function in Scripts/custom-scripts.js, communicated using a XMLHttpRequest.

## Static (Display-only) Pages
The following pages show information from the preface of the original prescription manual document. No backend functions are utilized in these pages.
### Default.aspx (Homepage)
![Image](https://i.imgur.com/KAHERKx.png)

### CodeRules.aspx
### Instructions.aspx
### References.aspx
### Regulations.aspx
