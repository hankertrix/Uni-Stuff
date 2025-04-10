# vim: tabstop=4 shiftwidth=4 expandtab
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "marimo",
#     "matplotlib==3.10.1",
#     "numpy==2.2.4",
#     "pandas==2.2.3",
#     "seaborn==0.13.2",
#     "xlrd==2.0.1",
#     "scikit-learn==1.6.1",
# ]
# ///

import marimo

__generated_with = "0.12.4"
app = marimo.App(width="full", layout_file="layouts/main.slides.json")


@app.cell
def _():
    # Import all the required libraries
    import functools
    import re
    from operator import itemgetter

    import marimo as mo
    import matplotlib.pyplot as plt
    import numpy as np
    import pandas as pd
    import seaborn as sb
    from matplotlib.ticker import StrMethodFormatter
    from sklearn.ensemble import ExtraTreesRegressor, RandomForestRegressor
    from sklearn.experimental import enable_iterative_imputer
    from sklearn.gaussian_process import GaussianProcessRegressor
    from sklearn.impute import IterativeImputer
    from sklearn.isotonic import IsotonicRegression
    from sklearn.linear_model import (
        BayesianRidge,
        ElasticNet,
        HuberRegressor,
        Lasso,
        LinearRegression,
        RANSACRegressor,
        Ridge,
        SGDRegressor,
    )
    from sklearn.metrics import mean_squared_error, r2_score
    from sklearn.neighbors import KNeighborsRegressor
    from sklearn.pipeline import make_pipeline
    from sklearn.preprocessing import PolynomialFeatures
    from sklearn.svm import SVR, LinearSVR
    from sklearn.tree import DecisionTreeRegressor

    # Set the seaborn style
    sb.set_theme()
    return (
        BayesianRidge,
        DecisionTreeRegressor,
        ElasticNet,
        ExtraTreesRegressor,
        GaussianProcessRegressor,
        HuberRegressor,
        IsotonicRegression,
        IterativeImputer,
        KNeighborsRegressor,
        Lasso,
        LinearRegression,
        LinearSVR,
        PolynomialFeatures,
        RANSACRegressor,
        RandomForestRegressor,
        Ridge,
        SGDRegressor,
        SVR,
        StrMethodFormatter,
        enable_iterative_imputer,
        functools,
        itemgetter,
        make_pipeline,
        mean_squared_error,
        mo,
        np,
        pd,
        plt,
        r2_score,
        re,
        sb,
    )


@app.cell
def _(np):
    # The constants used in the program

    # The path to the data file
    DATA_FILE = "./data.xls"

    # The minimum and maximum values for the multiplier
    MULTIPLIER_MAX_VALUE = 100
    MULTIPLIER_MIN_VALUE = -100

    # The list of columns to drop
    COLUMNS_TO_DROP = [
        # Drop the country code as we are using the country name
        "Country code",
        # These two columns below are useless
        "SCALE",
        "Decimals",
        # There is no data for 2011, so just drop it
        "2011",
    ]

    # The list of series codes for problem 1
    SERIES_CODES_PROBLEM_1 = [
        # CO2 emissions per capita (metric tons)
        "EN.ATM.CO2E.PC",
        # CO2 emissions per units of GDP (kg/$1,000 of 2005 PPP $)
        "EN.ATM.CO2E.PP.GD.KD",
        # CO2 emissions, total (KtCO2)
        "EN.ATM.CO2E.KT",
        # Methane (CH4) emissions, total (KtCO2e)
        "EN.ATM.METH.KT.CE",
        # Nitrous oxide (N2O) emissions, total (KtCO2e)
        "EN.ATM.NOXE.KT.CE",
        # Other GHG emissions, total (KtCO2e)
        "EN.ATM.GHGO.KT.CE",
        # Energy use per capita (kilograms of oil equivalent)
        "EG.USE.PCAP.KG.OE",
        # Energy use per units of GDP (kg oil eq./$1,000 of 2005 PPP $)
        "EG.USE.COMM.GD.PP.KD",
    ]

    # The map of the series code to its multiplier for problem 2
    SERIES_CODE_TO_MULTIPLIER_MAP = {
        # Access to improved sanitation (% of total pop.)
        "SH.STA.ACSN": 1,
        # Access to improved water source (% of total pop.)
        "SH.H2O.SAFE.ZS": 1,
        # CO2 emissions per capita (metric tons)
        "EN.ATM.CO2E.PC": -1,
        # CO2 emissions per units of GDP (kg/$1,000 of 2005 PPP $)
        "EN.ATM.CO2E.PP.GD.KD": -1,
        # CO2 emissions, total (KtCO2)
        "EN.ATM.CO2E.KT": -1,
        # Cereal yield (kg per hectare)
        "AG.YLD.CREL.KG": 1,
        # Foreign direct investment, net inflows (% of GDP)
        "BX.KLT.DINV.WD.GD.ZS": 1,
        # GDP ($)
        "NY.GDP.MKTP.CD": 1,
        # GNI per capita (Atlas $)
        "NY.GNP.PCAP.CD": 1,
        # Nationally terrestrial protected areas (% of total land area)
        "ER.LND.PTLD.ZS": 1,
        # Paved roads (% of total roads)
        "IS.ROD.PAVE.ZS": 1,
        # Physicians (per 1,000 people)
        "SH.MED.PHYS.ZS": 1,
        # Under-five mortality rate (per 1,000)
        "SH.DYN.MORT": -1,
        # Energy use per capita (kilograms of oil equivalent)
        "EG.USE.PCAP.KG.OE": -1,
        # Energy use per units of GDP (kg oil eq./$1,000 of 2005 PPP $)
        "EG.USE.COMM.GD.PP.KD": -1,
        # Methane (CH4) emissions, total (KtCO2e)
        "EN.ATM.METH.KT.CE": -1,
        # Nitrous oxide (N2O) emissions, total (KtCO2e)
        "EN.ATM.NOXE.KT.CE": -1,
        # Other GHG emissions, total (KtCO2e)
        "EN.ATM.GHGO.KT.CE": -1,
    }

    # The list of all the series codes needed
    SERIES_CODES = [
        #
        # Mostly complete data
        #
        # Cereal yield (kg per hectare)
        "AG.YLD.CREL.KG",
        # Foreign direct investment, net inflows (% of GDP)
        "BX.KLT.DINV.WD.GD.ZS",
        # Energy use per units of GDP (kg oil eq./$1,000 of 2005 PPP $)
        "EG.USE.COMM.GD.PP.KD",
        # Energy use per capita (kilograms of oil equivalent)
        "EG.USE.PCAP.KG.OE",
        # CO2 emissions, total (KtCO2)
        "EN.ATM.CO2E.KT",
        # CO2 emissions per capita (metric tons)
        "EN.ATM.CO2E.PC",
        # CO2 emissions per units of GDP (kg/$1,000 of 2005 PPP $)
        "EN.ATM.CO2E.PP.GD.KD",
        # Nationally terrestrial protected areas (% of total land area)
        "ER.LND.PTLD.ZS",
        # GDP ($)
        "NY.GDP.MKTP.CD",
        # GNI per capita (Atlas $)
        "NY.GNP.PCAP.CD",
        # Under-five mortality rate (per 1,000)
        "SH.DYN.MORT",
        # Population growth (annual %)
        "SP.POP.GROW",
        # Population
        "SP.POP.TOTL",
        # Urban population growth (annual %)
        "SP.URB.GROW",
        # Urban population
        "SP.URB.TOTL",
        #
        # Spotty data
        #
        # Population in urban agglomerations >1million (%)
        "EN.URB.MCTY.TL.ZS",
        # Paved roads (% of total roads)
        "IS.ROD.PAVE.ZS",
        # Ratio of girls to boys in primary & secondary school (%)
        "SE.ENR.PRSC.FM.ZS",
        # Primary completion rate, total (% of relevant age group)
        "SE.PRM.CMPT.ZS",
        # Physicians (per 1,000 people)
        "SH.MED.PHYS.ZS",
        #
        # Data every 5 years from 1990 - 2005
        #
        # Other GHG emissions, total (KtCO2e)
        "EN.ATM.GHGO.KT.CE",
        # Methane (CH4) emissions, total (KtCO2e)
        "EN.ATM.METH.KT.CE",
        # Nitrous oxide (N2O) emissions, total (KtCO2e)
        "EN.ATM.NOXE.KT.CE",
        #
        # Data every 5 years from 1990 - 2005 plus 2008
        #
        # Access to improved water source (% of total pop.)
        "SH.H2O.SAFE.ZS",
        # Access to improved sanitation (% of total pop.)
        "SH.STA.ACSN",
    ]

    # The list of regions for problem 1
    REGIONS_FOR_PROBLEM_1 = [
        "World",
        "Europe & Central Asia",
        "Latin America & Caribbean",
        "East Asia & Pacific",
        "Middle East & North Africa",
        "South Asia",
        "Sub-Saharan Africa",
        "Euro area",
        "Small island developing states",
    ]

    # The list of regions to remove for problem 2
    REGIONS_TO_REMOVE_FOR_PROBLEM_2 = [
        "East Asia & Pacific",
        "Europe & Central Asia",
        "Euro area",
        "High income",
        "Latin America & Caribbean",
        "Low income",
        "Lower middle income",
        "Low & middle income",
        "Middle income",
        "Middle East & North Africa",
        "South Asia",
        "Sub-Saharan Africa",
        "Upper middle income",
        "Small island developing states",
        "World",
    ]

    # The range of years in the data set.
    #
    # There is no data for 2011, so we are skipping it
    YEAR_RANGE = np.array(list(range(1990, 2010 + 1)))

    # The year range as a string for easier indexing into the data frame
    YEAR_RANGE_STR = [str(year) for year in YEAR_RANGE]
    return (
        COLUMNS_TO_DROP,
        DATA_FILE,
        MULTIPLIER_MAX_VALUE,
        MULTIPLIER_MIN_VALUE,
        REGIONS_FOR_PROBLEM_1,
        REGIONS_TO_REMOVE_FOR_PROBLEM_2,
        SERIES_CODES,
        SERIES_CODES_PROBLEM_1,
        SERIES_CODE_TO_MULTIPLIER_MAP,
        YEAR_RANGE,
        YEAR_RANGE_STR,
    )


@app.cell
def _():
    # Constants used for the UI

    # The table page size to use
    TABLE_PAGE_SIZE = 20

    # The hex code for the green colour
    GREEN_COLOUR = "#3CB034"
    return GREEN_COLOUR, TABLE_PAGE_SIZE


@app.cell
def _(TABLE_PAGE_SIZE, functools, mo):
    def html(*args):
        "Function to more easily write HTML."
        return mo.Html(
            "\n".join(
                [arg if isinstance(arg, str) else arg.text for arg in args]
            )
        )

    def md(*args):
        "Function to more easily write markdown."
        return mo.md(
            "\n".join(
                [arg if isinstance(arg, str) else arg.text for arg in args]
            )
        )

    # The function to create a Marimo table UI
    # with the default arguments passed so we
    # don't have to keep writing the same things
    # over and over again
    ui_table = functools.partial(
        mo.ui.table, selection=None, page_size=TABLE_PAGE_SIZE
    )

    def html_heading(heading_level: int, heading: str):
        "Function to more easily create a HTML heading."
        return html(f"<h{heading_level}>", heading, f"</h{heading_level}>")

    def md_heading(heading_level: int, heading: str):
        "Function to more easily create a markdown heading."
        return md(f"{'#' * heading_level} {heading}")

    def html_hyperlink(string: str, link: str):
        "Function to more easily create a HTML hyperlink."
        return html(f"<a href={link}>{string}</a>")

    def md_hyperlink(string: str, link: str):
        "Function to more easily create a markdown hyperlink."
        return md(f"[{string}]({link})")

    def style_inline(string: str, **styles: str):
        """
        Function to style a string with inline styles.

        The first argument is the string to style with an
        inline span element, and the keyword arguments
        are the CSS styles
        """

        # Create the style string for the element
        style_string = ", ".join(
            [
                f"{key.replace('_', '-')}: {value}"
                for key, value in styles.items()
            ]
        )
        return html(f"<span style='{style_string}'>{string}</span>")

    def html_list(list_type: str, *elements):
        """
        Function to create HTML lists more easily.

        The list type can either by an ordered list (ol),
        or an unordered list (ul).
        """
        return html(
            f"<{list_type}>",
            *[f"<li>{element}</li>" for element in elements],
            f"</{list_type}>",
        )

    def html_ordered_list(*elements):
        "Function to create a HTML ordered list more easily."
        return html_list("ol", *elements)

    def html_numbered_list(*elements):
        """
        Function to create a numbered HTML list more easily.

        This function is an alias for the html_ordered_list function.
        """
        return html_ordered_list(*elements)

    def html_unordered_list(*elements):
        "Function to create a HTML unordered list more easily."
        return html_list("ul", *elements)

    def html_unnumbered_list(*elements):
        """
        Function to create a HTML list without numbering more easily.

        This function is an alias for the html_unordered_list function.
        """
        return html_ordered_list(*elements)

    def html_element(element_type: str, *elements):
        "Function to more easily create HTML elements."
        return html(f"<{element_type}>", *elements, f"</{element_type}>")

    def md_ordered_list(*elements):
        "Function to create a markdown ordered list more easily."
        return md(
            *[
                f"{index}. {element}"
                for index, element in enumerate(elements, start=1)
            ]
        )

    def md_numbered_list(*elements):
        """
        Function to create a numbered markdown list more easily.

        This function is an alias for the md_ordered_list function.
        """
        return md_ordered_list(*elements)

    def md_unordered_list(*elements):
        "Function to create a markdown unordered list more easily."
        return md(*[f"- {element}" for element in elements])

    def md_unnumbered_list(*elements):
        """
        Function to create a markdown list without numbering more easily.

        This function is an alias for the md_unordered_list function.
        """
        return md_unordered_list(*elements)

    def centred_slide_title(title: str):
        "Function to return a centred slide title."
        return md(f"## {title}").center().style(padding_bottom="20px")

    return (
        centred_slide_title,
        html,
        html_element,
        html_heading,
        html_hyperlink,
        html_list,
        html_numbered_list,
        html_ordered_list,
        html_unnumbered_list,
        html_unordered_list,
        md,
        md_heading,
        md_hyperlink,
        md_numbered_list,
        md_ordered_list,
        md_unnumbered_list,
        md_unordered_list,
        style_inline,
        ui_table,
    )


@app.cell
def _(GREEN_COLOUR, html, style_inline):
    # Constants used in the slides

    # The question for problem 1
    PROBLEM_1_QUESTION = html(
        f"Are we getting {style_inline('greener', color=GREEN_COLOUR)}",
        f"or {style_inline('more sustainable', color=GREEN_COLOUR)}?",
    )

    # The question for problem 2
    PROBLEM_2_QUESTION = html("Which country should I move to in the future?")
    return PROBLEM_1_QUESTION, PROBLEM_2_QUESTION


@app.cell
def _(DATA_FILE, pd):
    # Read the data from the data file
    climate_change_excel_sheet = pd.read_excel(DATA_FILE, sheet_name=None)

    # Get the data from the excel sheet
    data = climate_change_excel_sheet["Data"]
    series_descriptions = climate_change_excel_sheet["Series"]

    # Convert all the column names to string
    data.columns = data.columns.astype(str)
    return climate_change_excel_sheet, data, series_descriptions


@app.cell
def _(series_descriptions):
    # Create the map from the series code to the series name
    SERIES_CODE_TO_NAME_MAP = dict(
        zip(
            series_descriptions["Series code"],
            series_descriptions["Series name"],
        )
    )

    # Create the map from the series name to the series code
    SERIES_NAME_TO_CODE_MAP = dict(
        zip(
            series_descriptions["Series name"],
            series_descriptions["Series code"],
        )
    )
    return SERIES_CODE_TO_NAME_MAP, SERIES_NAME_TO_CODE_MAP


@app.cell
def _(GREEN_COLOUR, html, html_heading, md):
    # Create the title slide
    html(
        md("# MA0218 Mini Project:").center(),
        html_heading(1, "The Climate Forum").center().style(color=GREEN_COLOUR),
        md("By: Nicholas, Haziq, Dylan and Jun Feng")
        .center()
        .style(padding="5em"),
    )
    return


@app.cell
def _(data, html, md, ui_table):
    # The slide for the data set used
    html(
        md("## Data set"),
        html(
            "<p>",
            "The data set used is the climate change data set.",
            "Have a look at the data set in the table below:",
            "</p>",
        ).style(padding="10px 0px"),
        ui_table(data),
    )
    return


@app.cell
def _(
    GREEN_COLOUR,
    PROBLEM_1_QUESTION,
    PROBLEM_2_QUESTION,
    html,
    html_numbered_list,
    md,
    style_inline,
):
    # The slide for the objectives
    md(
        "## Objectives",
        "",
        "The two main objectives of this mini project are:",
        "",
        html_numbered_list(
            html(
                "Find out if we are getting",
                style_inline("greener", color=GREEN_COLOUR),
                "over the years.",
            ),
            "Determine the best country to move to in the future.",
        ),
        "These objectives are formulated as 2 problem statements:",
        html_numbered_list(
            PROBLEM_1_QUESTION,
            PROBLEM_2_QUESTION,
        ),
    )
    return


@app.cell
def _(
    COLUMNS_TO_DROP,
    SERIES_CODES,
    YEAR_RANGE_STR,
    data,
    html,
    mo,
    np,
    pd,
    re,
):
    # Create the function to clean the data
    def clean_data(given_data: pd.DataFrame) -> pd.DataFrame:
        "Function to clean up the data."

        # Make a copy of the data
        cleaned_data = given_data.copy()

        # Convert all the column names to string
        cleaned_data.columns = data.columns.astype(str)

        # Drop the columns that aren't needed
        cleaned_data.drop(COLUMNS_TO_DROP, axis=1, inplace=True)

        # Coerce all the data in the columns for the years to numeric
        cleaned_data[YEAR_RANGE_STR] = cleaned_data[YEAR_RANGE_STR].apply(
            lambda elem: pd.to_numeric(elem, errors="coerce")
        )

        # Replace all infinity values with NaNs
        cleaned_data[YEAR_RANGE_STR] = cleaned_data[YEAR_RANGE_STR].replace(
            [np.inf, -np.inf], np.nan
        )

        # Drop all the rows in the years that have all their values as NaNs
        cleaned_data.drop(
            cleaned_data[cleaned_data[YEAR_RANGE_STR].isna().all(axis=1)].index,
            inplace=True,
        )

        # Drop all the rows with series we don't need
        cleaned_data.drop(
            cleaned_data[~cleaned_data["Series code"].isin(SERIES_CODES)].index,
            inplace=True,
        )

        # Reset the index of the data frame
        cleaned_data.reset_index(drop=True, inplace=True)

        # Return the data
        return cleaned_data

    # Create the function to remove everything after a line of code
    def strip_unnecessary_code(line_of_code: str) -> str:
        return re.sub(
            f"({line_of_code}).*?'", "\\1&quot;'", mo.show_code().text
        )

    # Save the code to clean the data for later
    clean_data_function_code = html(
        strip_unnecessary_code("return cleaned_data")
    )
    return clean_data, clean_data_function_code, strip_unnecessary_code


@app.cell
def _(
    IterativeImputer,
    LinearRegression,
    PolynomialFeatures,
    YEAR_RANGE_STR,
    html,
    make_pipeline,
    pd,
    strip_unnecessary_code,
):
    # Create the function to impute the missing data
    def impute_missing_data(given_data: pd.DataFrame) -> pd.DataFrame:
        "Function to impute the missing data row by row."

        # Initialise the imputer object
        imputer_object = IterativeImputer(
            estimator=make_pipeline(PolynomialFeatures(3), LinearRegression())
        )

        # Make a copy of the data
        imputed_data = given_data.copy()

        # Iterate over the given data
        for index, row in given_data[YEAR_RANGE_STR].iterrows():
            #

            # Impute the data for the row
            imputed_row = imputer_object.fit_transform(
                list(zip(YEAR_RANGE_STR, row))
            )

            # Remove the year from the imputed row
            imputed_row_data = [value for (_, value) in imputed_row]

            # Set the imputed row data to the imputed data
            imputed_data.loc[index, YEAR_RANGE_STR] = imputed_row_data

        # Return the imputed data
        return imputed_data

    # Save the code to impute the data for later
    impute_missing_data_function_code = html(
        strip_unnecessary_code("return imputed_data")
    )
    return impute_missing_data, impute_missing_data_function_code


@app.cell
def _(clean_data, data):
    # Clean the data
    cleaned_data = clean_data(data)
    return (cleaned_data,)


@app.cell
def _(cleaned_data, impute_missing_data):
    # Impute the missing data
    imputed_data = impute_missing_data(cleaned_data)
    return (imputed_data,)


@app.cell
def _(pd):
    def format_data_for_problem(
        given_data: pd.DataFrame,
        regions: list[str],
        series_codes: list[str],
    ) -> dict[str, pd.DataFrame]:
        "Function to format the data properly for the problems."

        # Initialise the dictionary to store the data for problem 1
        formatted_data = {}

        # Iterate over all the regions required for problem 1
        for region in regions:
            #

            # Get the region data
            region_data = given_data.loc[given_data["Country name"] == region]

            # Grab the data that is in the series for problem 1
            region_series_data = (
                region_data.loc[region_data["Series code"].isin(series_codes)]
                .drop(columns=["Country name", "Series code"])
                .reset_index(drop=True)
            )

            # Pivot the data so that the series name is at the top
            pivoted_region_data = region_series_data.pivot_table(
                columns="Series name"
            )

            # Add the data to the dictionary
            formatted_data[region] = pivoted_region_data

        # Return the dictionary containing the formatted data
        return formatted_data

    return (format_data_for_problem,)


@app.cell
def _(md):
    md("# Exploratory Analysis").center()
    return


@app.cell
def _(html, md, md_numbered_list):
    md(
        "## Exploratory Analysis: Procedure",
        "Below are the steps we followed to explore the data:",
        md_numbered_list(
            html(
                "Run through the data in Microsoft Excel,",
                "and note that the data",
                "is time series with data of at most 20 years.",
            ),
            html(
                "The data was found to have numerous missing values",
                "across most series, and since the data is time series,",
                "data that is too sparse is unsuitable",
                "for most machine learning models to train on.",
            ),
            html(
                "Most of the sparse data is discarded,",
                "as they are unusable.",
            ),
            html(
                "Additionally, with such a small number of data points,",
                "a list of regression models was collated from",
                "Scikit-Learn to assess the ability of",
                "machine learning models to fit",
                "the data properly.",
            ),
            html(
                "Hence, code was written to evaluate model performance",
                "on one series and the results were compared.",
            ),
        ),
    )
    return


@app.cell
def _(
    BayesianRidge,
    DecisionTreeRegressor,
    ElasticNet,
    ExtraTreesRegressor,
    GaussianProcessRegressor,
    HuberRegressor,
    IsotonicRegression,
    KNeighborsRegressor,
    Lasso,
    LinearRegression,
    LinearSVR,
    PolynomialFeatures,
    RANSACRegressor,
    RandomForestRegressor,
    Ridge,
    SGDRegressor,
    SVR,
    StrMethodFormatter,
    YEAR_RANGE,
    YEAR_RANGE_STR,
    cleaned_data,
    make_pipeline,
    mean_squared_error,
    np,
    pd,
    plt,
    r2_score,
):
    def exploratory_analysis():
        "Exploratory analysis of machine learning models on the data set."

        # The target country and the data set to regress over
        target_country = "Singapore"

        # The target series to regress over, which is
        # GDP ($)
        target_series = "NY.GDP.MKTP.CD"

        # Reshape the years to make it usable for training
        x_train = YEAR_RANGE.reshape(-1, 1)

        # The data to use
        data = cleaned_data[
            (cleaned_data["Country name"] == target_country)
            & (cleaned_data["Series code"] == target_series)
        ]

        # The number of plots in a column
        number_of_plot_columns = 5

        # The training data for the series
        y_train = data[YEAR_RANGE_STR].values.flatten()

        # Regression models
        regression_models = {
            "Linear Regressor": LinearRegression(),
            "Ridge Regressor": Ridge(),
            "Lasso Regressor": Lasso(),
            "Bayesian Ridge": BayesianRidge(),
            "Elastic Net": ElasticNet(),
            "Huber Regressor": HuberRegressor(),
            "RANSAC Regressor": RANSACRegressor(),
            "Random Forest Regressor": RandomForestRegressor(
                n_estimators=100, random_state=42
            ),
            "Extra Trees Regressor": ExtraTreesRegressor(
                n_estimators=100, random_state=42
            ),
            "SVR (RBF Kernel)": SVR(kernel="rbf"),
            "SVR (Linear Kernel)": SVR(kernel="linear"),
            "SVR (Poly Kernel)": SVR(kernel="poly"),
            "SVR (Sigmoid Kernel)": SVR(kernel="sigmoid"),
            "Linear SVR": LinearSVR(),
            "Stochastic Gradient Descent Regressor": SGDRegressor(),
            "Gaussian Process Regressor": GaussianProcessRegressor(),
            "Isotonic Regressor": IsotonicRegression(),
            #
            # Decision Tree Regressors
            "Decision Tree Regressor (max depth 1)": DecisionTreeRegressor(
                max_depth=1
            ),
            "Decision Tree Regressor (max depth 2)": DecisionTreeRegressor(
                max_depth=2
            ),
            "Decision Tree Regressor (max depth 3)": DecisionTreeRegressor(
                max_depth=3
            ),
            "Decision Tree Regressor (max depth 4)": DecisionTreeRegressor(
                max_depth=4
            ),
            "Decision Tree Regressor (max depth 5)": DecisionTreeRegressor(
                max_depth=5
            ),
            "Decision Tree Regressor (max depth 6)": DecisionTreeRegressor(
                max_depth=6
            ),
            "Decision Tree Regressor (max depth 7)": DecisionTreeRegressor(
                max_depth=7
            ),
            "Decision Tree Regressor (max depth 8)": DecisionTreeRegressor(
                max_depth=8
            ),
            "Decision Tree Regressor (max depth 9)": DecisionTreeRegressor(
                max_depth=9
            ),
            "Decision Tree Regressor (max depth 10)": DecisionTreeRegressor(
                max_depth=10
            ),
            #
            # KNN Regressors
            "KNN Regressor (1 neighbour)": KNeighborsRegressor(n_neighbors=1),
            "KNN Regressor (2 neighbours)": KNeighborsRegressor(n_neighbors=2),
            "KNN Regressor (3 neighbours)": KNeighborsRegressor(n_neighbors=3),
            "KNN Regressor (4 neighbours)": KNeighborsRegressor(n_neighbors=4),
            "KNN Regressor (5 neighbours)": KNeighborsRegressor(n_neighbors=5),
            "KNN Regressor (6 neighbours)": KNeighborsRegressor(n_neighbors=6),
            "KNN Regressor (7 neighbours)": KNeighborsRegressor(n_neighbors=7),
            "KNN Regressor (8 neighbours)": KNeighborsRegressor(n_neighbors=8),
            "KNN Regressor (9 neighbours)": KNeighborsRegressor(n_neighbors=9),
            "KNN Regressor (10 neighbours)": KNeighborsRegressor(
                n_neighbors=10
            ),
            #
            # Linear regressor with polynomial features
            "Polynomial Regressor (degree 1)": make_pipeline(
                PolynomialFeatures(1), LinearRegression()
            ),
            "Polynomial Regressor (degree 2)": make_pipeline(
                PolynomialFeatures(2), LinearRegression()
            ),
            "Polynomial Regressor (degree 3)": make_pipeline(
                PolynomialFeatures(3), LinearRegression()
            ),
            "Polynomial Regressor (degree 4)": make_pipeline(
                PolynomialFeatures(4), LinearRegression()
            ),
            "Polynomial Regressor (degree 5)": make_pipeline(
                PolynomialFeatures(5), LinearRegression()
            ),
            "Polynomial Regressor (degree 6)": make_pipeline(
                PolynomialFeatures(6), LinearRegression()
            ),
            "Polynomial Regressor (degree 7)": make_pipeline(
                PolynomialFeatures(7), LinearRegression()
            ),
            "Polynomial Regressor (degree 8)": make_pipeline(
                PolynomialFeatures(8), LinearRegression()
            ),
            "Polynomial Regressor (degree 9)": make_pipeline(
                PolynomialFeatures(9), LinearRegression()
            ),
            "Polynomial Regressor (degree 10)": make_pipeline(
                PolynomialFeatures(10), LinearRegression()
            ),
        }

        # Get the number of plot rows
        number_of_plot_rows = int(
            np.ceil(len(regression_models) / number_of_plot_columns)
        )

        # Create the figure and the subplots
        figure, axes = plt.subplots(
            number_of_plot_rows,
            number_of_plot_columns,
            figsize=[number_of_plot_rows * number_of_plot_columns] * 2,
        )

        # Initialise the results
        results = []

        # Iterate over the regression models
        for index, (name, model) in enumerate(regression_models.items()):
            #

            # Fit the model on the data
            model.fit(x_train, y_train)

            # Get the prediction from the model
            prediction = model.predict(x_train)

            # Get the R squared score
            r_squared = r2_score(y_train, prediction)

            # Get the mean squared error and root mean squared error
            mse = mean_squared_error(y_train, prediction)
            rmse = np.sqrt(mse)

            # Append metrics to the list
            results.append(
                {
                    "Model": name,
                    "R squared score": r_squared,
                    "MSE": mse,
                    "RMSE": rmse,
                }
            )

            # Get the axis of the subplot
            axis = axes.flat[index]

            # Plot the data and the prediction
            axis.plot(x_train, y_train)
            axis.plot(x_train, prediction)

            # Set the title to the model
            axis.set_title(name)

            # Use integers for the x axis
            axis.xaxis.set_major_formatter(StrMethodFormatter("{x:,.0f}"))

        # Put the data into a data frame
        results_dataframe = (
            pd.DataFrame(results)
            .sort_values(by="R squared score", ascending=False)
            .reset_index(drop=True)
        )

        # Return the results dataframe
        return results_dataframe, figure

    # Run the exploratory analysis and save the table and figure
    exploratory_analysis_table, exploratory_analysis_figure = (
        exploratory_analysis()
    )
    return (
        exploratory_analysis,
        exploratory_analysis_figure,
        exploratory_analysis_table,
    )


@app.cell
def _(centred_slide_title, exploratory_analysis_table, html, ui_table):
    # Create the slide for the table
    html(
        centred_slide_title("Exploratory Analysis: Tabulated Results"),
        ui_table(exploratory_analysis_table),
    )
    return


@app.cell
def _(centred_slide_title, exploratory_analysis_figure, mo):
    # Create the slide for the plot of all the models
    mo.output.append(
        centred_slide_title("Exploratory Analysis: Plots of Regression Models")
    )
    mo.output.append(exploratory_analysis_figure)
    return


@app.cell
def _(PROBLEM_1_QUESTION, html, html_heading, md):
    html(
        md("# Problem 1:").center(),
        html_heading(
            1,
            PROBLEM_1_QUESTION,
        ).center(),
    )
    return


@app.cell
def _(
    REGIONS_FOR_PROBLEM_1,
    SERIES_CODES_PROBLEM_1,
    format_data_for_problem,
    imputed_data,
):
    # Create the data for problem 1
    problem_1_data = format_data_for_problem(
        imputed_data, REGIONS_FOR_PROBLEM_1, SERIES_CODES_PROBLEM_1
    )
    return (problem_1_data,)


@app.cell
def _(html, md, md_numbered_list):
    # Display the slide for the procedure to prepare the data for problem 1
    html(
        md(
            "## Problem 1: Data preparation and procedure",
            "",
            "The given climate change data is a bit of a mess,",
            "so the data is prepared following the procedure below:",
            "",
            md_numbered_list(
                html(
                    "Pull out all the data for the series",
                    "that are relevant to sustainability.",
                    "An example is carbon dioxide emissions.",
                ),
                html(
                    "Format the data such that the series are the columns",
                    "and the years are the rows.",
                ),
                html(
                    "Select the data for the regions that we are interested in."
                ),
            ),
            "Once the data has been prepared, a linear regression model",
            "is fitted on to the data to show the trends",
            "and the graph is plotted using Matplotlib subplots.",
        )
    )
    return


@app.cell
def _(html, md, md_unnumbered_list, problem_1_data, ui_table):
    # Display the prepared data
    html(
        md("## Problem 1: Prepared data").center(),
        md_unnumbered_list(
            *[
                html(
                    country_name.title(),
                    ui_table(country_data, selection=None, page_size=5),
                )
                for country_name, country_data in problem_1_data.items()
            ]
        ),
    )
    return


@app.cell
def _(
    LinearRegression,
    StrMethodFormatter,
    YEAR_RANGE,
    np,
    plt,
    problem_1_data,
):
    def solve_problem_1():
        "Function to solve problem 1."

        # Initialise the list of figures and axes
        all_figures = []

        # Get the list of years for training
        years = YEAR_RANGE.reshape(-1, 1)

        # Initialise the model to show the trend
        model = LinearRegression()

        # Create the sub plots
        figure, axes = plt.subplots(
            len(problem_1_data),
            np.max([len(data.columns) for data in problem_1_data.values()]),
            figsize=(64, 64),
        )

        # Iterate over all the countries
        for country_index, (country, data) in enumerate(problem_1_data.items()):
            #

            # Iterate over all the columns in the data
            for column_index, column in enumerate(data):
                #

                # Get the column data
                column_data = data[column]

                # Fit the models on the data
                model.fit(years, column_data)

                # Predict the values for the data
                prediction = model.predict(years)

                # Get the axis
                axis = axes[country_index, column_index]

                # Plot the data and the prediction
                axis.scatter(years, column_data)
                axis.plot(years, column_data)
                axis.plot(years, prediction)
                axis.set_title(country.title())
                axis.set_xlabel("Year")
                axis.set_ylabel(column)

                # Set the x axis format to integers
                axis.xaxis.set_major_formatter(StrMethodFormatter("{x:,.0f}"))

                # Add the figure to the lists
                all_figures.append(figure)

        # Return the figure
        return figure

    # Save the graph plots for problem 1
    problem_1_graph_plots = solve_problem_1()
    return problem_1_graph_plots, solve_problem_1


@app.cell
def _(centred_slide_title, mo, problem_1_graph_plots):
    # Create the slide to display the graph plots for problem 1
    mo.output.append(centred_slide_title("Problem 1: Trend plots"))
    mo.output.append(problem_1_graph_plots)
    return


@app.cell
def _(html, md, md_numbered_list):
    # Create the slide to show the insights for problem 1
    md(
        "## Problem 1: Insights",
        "From the trend plots in the previous slide,",
        "we have gathered these insights:",
        md_numbered_list(
            html(
                "In general, we are not becoming greener or more sustainable.",
                "Globally, carbon dioxide emissions are increasing",
                "across the board, except for Europe and Central Asia.",
            ),
            html(
                "Methane emissions have also been increasing across the board,",
                "with only the Euro area and the small islands decreasing in",
                "methane emissions.",
            ),
            html(
                "These trends are expected, as total energy use",
                "has increased across the board,",
                "save for Europe and Central Asia",
                "which decreased their energy use.",
            ),
            html(
                "However, there is some hope, as we are generally",
                "growing in an increasingly sustainable manner,",
                "except for the Middle East and North Africa,",
                "as carbon dioxide emissions and energy use per unit of GDP",
                "has been falling.",
            ),
        ),
    )
    return


@app.cell
def _(PROBLEM_2_QUESTION, html, html_heading, md):
    # Display the title slide for problem 2
    html(
        md("# Problem 2:").center(),
        html_heading(1, PROBLEM_2_QUESTION).center(),
    )
    return


@app.cell
def _(
    REGIONS_TO_REMOVE_FOR_PROBLEM_2,
    SERIES_CODES,
    format_data_for_problem,
    imputed_data,
):
    # Create the data for problem 2
    problem_2_data = format_data_for_problem(
        imputed_data,
        imputed_data[
            ~imputed_data["Country name"].isin(REGIONS_TO_REMOVE_FOR_PROBLEM_2)
        ]["Country name"].unique(),
        SERIES_CODES,
    )
    return (problem_2_data,)


@app.cell
def _(html, md, md_numbered_list):
    # Create the slide to describe the data preparation
    # for problem 2
    md(
        "## Problem 2: Data preparation",
        "The data preparation for problem 2 is quite similar",
        "to that of problem 1, and the steps are:",
        md_numbered_list(
            html(
                "Pull out all the data for the series",
                "that are significant in our decision to",
                "live in the country in the future.",
                "An example is access to improved sanitation.",
            ),
            html(
                "Format the data such that the series are the columns",
                "and the years are the rows.",
            ),
            html(
                "Select the data for all countries,",
                "leaving out the regions.",
            ),
        ),
    )
    return


@app.cell
def _(centred_slide_title, html, md_unnumbered_list, problem_2_data, ui_table):
    # Show the prepared data
    html(
        centred_slide_title("Problem 2: Prepared data"),
        md_unnumbered_list(
            *[
                html(country_name.title(), ui_table(country_data, page_size=5))
                for (country_name, country_data) in list(
                    problem_2_data.items()
                )[:5]
            ]
        ),
    )
    return


@app.cell
def _(html, md, md_numbered_list, md_unnumbered_list):
    # Create the slide to show the procedure to
    # get the quality of life scores
    md(
        "## Problem 2: Procedure",
        "After the data has been prepared,",
        "the procedure below is followed to obtain a score,",
        "which we call the quality of life score,",
        "to rank the countries:",
        md_numbered_list(
            html(
                "For each country, a cubic regressor",
                "(a polynomial regressor of degree 3)",
                "was fitted on every single series,",
                "and the model is used to predict the value",
                "for 2025.",
                md_unnumbered_list(
                    html(
                        "For example, the model is trained on",
                        "the series for GDP for Singapore,",
                        "and the model is used to predict the",
                        "GDP value for Singapore in 2025.",
                    )
                ),
            ),
            html(
                "The predicted values for 2025 for each country",
                "is then normalised using z-score normalisation",
                "so that the data for each series for all countries",
                "has a mean of 0 and a standard deviation of 1.",
                md_unnumbered_list(
                    html(
                        "For example, the series for GDP for all countries",
                        "is normalised using z-score normalisation,",
                        "so the GDP values for all countries has",
                        "a mean value of 0 and a standard deviation of 1.",
                    )
                ),
            ),
            html(
                "With the z-score normalisation in place,",
                "the values for every series",
                "for a country is then multiplied by a multiplier",
                "and then added together to create",
                "the quality of life score.",
                md_unnumbered_list(
                    html(
                        "For example, the values for every series",
                        "for Singapore is multiplied by a multiplier,",
                        "and then added together",
                        "to create a quality of life score for Singapore.",
                    ),
                    html(
                        "This multiplier represents the preference",
                        "for a certain aspect, so this multiplier",
                        "can be edited to get a country that",
                        "maximises the preferred aspects",
                        "while minimising the undesirable aspects.",
                    ),
                ),
            ),
        ),
    )
    return


@app.cell
def _(html, md, md_unnumbered_list):
    # Create the slide for the formula.
    md(
        "## Problem 2: Formula",
        "In short, the procedure in the previous slide can be expressed",
        "using the formula below:",
        md(
            r"\[",
            r"QoL = \sum_{i = 1}^{N} (Z(v_i) \cdot w_i)",
            r"\]",
        ),
        "Where:",
        md_unnumbered_list(
            r"\(QoL\) is the quality of life score.",
            html(
                r"\(N\) is the total number of aspects",
                "(columns in the prepared data).",
            ),
            html(
                r"\(Z\) is the z-score normalisation function,",
                r"defined as \(Z = \frac{x - \mu}{\sigma}\),",
                r"where \(x\) is the value, \(\mu\) is the mean,",
                r"and \(\sigma\) is the standard deviation.",
            ),
            html(
                r"\(v\) is the value of the aspect",
                "(column value in the prepared data).",
            ),
            html(
                r"\(w\) is the weight assigned to that aspect by the user.",
            ),
        ),
    )
    return


@app.cell
def _(
    LinearRegression,
    PolynomialFeatures,
    YEAR_RANGE,
    make_pipeline,
    np,
    pd,
    problem_2_data,
):
    def get_predictions_for_problem_2():
        "Function to get the predictions for 2025 for problem 2."

        # Create the dictionary of predictions
        predictions = {}

        # Initialise the model to do the predictions
        model = make_pipeline(PolynomialFeatures(3), LinearRegression())

        # Fix the year range for training
        years = YEAR_RANGE.reshape(-1, 1)

        # Iterate over the countries in the problem 2 data set
        for country, country_data in problem_2_data.items():
            #

            # Create the dictionary to store the predictions
            # for each of the series for the country
            country_predictions = {}

            # Iterate over the series in the country data
            for series, series_data in country_data.items():
                #

                # Fit the model
                model.fit(years, series_data)

                # Get the predicted value for 2025
                predicted_value = model.predict(np.array(2025).reshape(-1, 1))

                # Store the prediction
                country_predictions[series] = predicted_value[0]

            # Append the country predictions to the list
            predictions[country] = country_predictions

        # Convert the predictions to a dataframe
        predictions_dataframe = pd.DataFrame(predictions)

        # Normalise the predictions
        normalised_predictions = (
            predictions_dataframe - predictions_dataframe.mean()
        ) / predictions_dataframe.std()

        # Transpose the predictions
        transposed_predictions = normalised_predictions.transpose()

        # Fill all the NaNs with zeros
        transposed_predictions.fillna(0, inplace=True)

        return transposed_predictions, predictions_dataframe.transpose()

    normalised_predictions_problem_2, raw_predictions_problem_2 = (
        get_predictions_for_problem_2()
    )
    return (
        get_predictions_for_problem_2,
        normalised_predictions_problem_2,
        raw_predictions_problem_2,
    )


@app.cell
def _(centred_slide_title, html, raw_predictions_problem_2, ui_table):
    # Show the raw predicted values for problem 2
    html(
        centred_slide_title("Problem 2: Raw predictions for 2025"),
        ui_table(raw_predictions_problem_2),
    )
    return


@app.cell
def _(centred_slide_title, html, normalised_predictions_problem_2, ui_table):
    # Show the normalised predicted values for problem 2
    html(
        centred_slide_title("Problem 2: Normalised predictions for 2025"),
        ui_table(normalised_predictions_problem_2),
    )
    return


@app.cell
def _(
    SERIES_CODE_TO_MULTIPLIER_MAP,
    SERIES_NAME_TO_CODE_MAP,
    itemgetter,
    mo,
    normalised_predictions_problem_2,
    pd,
):
    def get_quality_of_life_score_for_problem_2(
        series_code_to_multiplier_map: dict[str, mo.ui.slider],
    ):
        "Function to get the quality of life score for problem 2."

        # Initialise the dictionary with the quality of life scores
        # for each country
        quality_of_life_scores = {}

        # Get the list of series codes that are wanted
        wanted_series_codes = list(SERIES_CODE_TO_MULTIPLIER_MAP.keys())

        # Make a copy of the normalised predictions
        normalised_predictions = normalised_predictions_problem_2.copy()

        # Convert all the series names to a series code
        normalised_predictions.columns = [
            SERIES_NAME_TO_CODE_MAP[series_name]
            for series_name in normalised_predictions.columns
        ]

        # Get only the wanted series
        wanted_predictions = normalised_predictions[wanted_series_codes]

        # Iterate over each country
        for country, country_data in wanted_predictions.iterrows():
            #

            # Initialise the quality of life score
            qol_score = 0

            # Iterate over all the columns in the country data
            for index, value in enumerate(country_data):
                #

                # Get the series code for the column
                series_code = wanted_predictions.columns[index]

                # Get the multiplier object
                multiplier_object = series_code_to_multiplier_map[series_code]

                # If the multiplier object is an integer or float,
                # then set the multiplier to it directly
                if isinstance(multiplier_object, (int, float)):
                    multiplier = multiplier_object

                # Otherwise, the multiplier object is a slider,
                # so get the value from it
                else:
                    multiplier = multiplier_object.value

                # Multiply the value by the multiplier
                # and add the result to the score
                qol_score += value * multiplier

            # Add the quality of life score for the country to the dictionary
            quality_of_life_scores[country] = qol_score

        # Sort the dictionary to have the countries
        # with the highest scores appear first
        sorted_quality_of_life_scores = dict(
            sorted(
                quality_of_life_scores.items(), key=itemgetter(1), reverse=True
            )
        )

        # Get the data frame for the quality of life scores
        quality_of_life_scores_data_frame = pd.DataFrame(
            sorted_quality_of_life_scores, index=["Quality of life score"]
        ).transpose()

        # Reset the index
        quality_of_life_scores_data_frame.reset_index(
            drop=False, inplace=True, names="Country"
        )

        # Set the index for the dataframe to be from
        # 1 to the length of the dataframe
        quality_of_life_scores_data_frame.index = range(
            1, len(quality_of_life_scores_data_frame) + 1
        )

        # Reset the the index once more to get the rankings
        # to show up in the dataframe
        quality_of_life_scores_data_frame.reset_index(
            drop=False, inplace=True, names="Rank"
        )

        # Return the quality of life score data frame
        return quality_of_life_scores_data_frame

    return (get_quality_of_life_score_for_problem_2,)


@app.cell
def _(
    MULTIPLIER_MAX_VALUE,
    MULTIPLIER_MIN_VALUE,
    SERIES_CODE_TO_MULTIPLIER_MAP,
    mo,
):
    # Create the dictionary of sliders
    multiplier_sliders_for_problem_2 = mo.ui.dictionary(
        {
            series_code: mo.ui.slider(
                start=MULTIPLIER_MIN_VALUE,
                stop=MULTIPLIER_MAX_VALUE,
                value=default_value,
                show_value=True,
            )
            for (
                series_code,
                default_value,
            ) in SERIES_CODE_TO_MULTIPLIER_MAP.items()
        }
    )
    return (multiplier_sliders_for_problem_2,)


@app.cell
def _(
    SERIES_CODE_TO_MULTIPLIER_MAP,
    SERIES_CODE_TO_NAME_MAP,
    centred_slide_title,
    get_quality_of_life_score_for_problem_2,
    html,
    multiplier_sliders_for_problem_2,
    ui_table,
):
    def quality_of_life_slide(slider_dictionary):
        "Function to create the slide for the quality of life scores."

        # Create the list for the slider segment
        slider_segment = []

        # Iterate over the series codes
        for series_code in SERIES_CODE_TO_MULTIPLIER_MAP.keys():
            #

            # Get the slider from the slider dictionary
            slider = slider_dictionary[series_code]

            # Get the series name from the series code
            series_name = SERIES_CODE_TO_NAME_MAP[series_code]

            # Create the html element
            html_element = html(html(series_name), html(slider)).style(
                display="flex",
                flex_direction="column",
                align_items="center",
                justify_content="center",
                text_align="center",
                padding="10px",
                gap="5px",
                box_shadow="0 4px 8px 0 rgba(0, 0, 0, 0.2),"
                + "0 3px 10px 0 rgba(0, 0, 0, 0.19)",
                width="100%",
                height="100%",
                font_size="15px",
            )

            # Add the html element to the slider segment
            slider_segment.append(html_element)

        # Get the dataframe of the quality of life scores
        quality_of_life_scores_data_frame = (
            get_quality_of_life_score_for_problem_2(slider_dictionary)
        )

        # Create the html for the slide
        return html(
            centred_slide_title("Problem 2: Quality of life scores"),
            html(*slider_segment).style(
                display="grid",
                grid_template_columns="repeat(6, 1fr)",
                grid_auto_rows="1fr",
                align_items="center",
                justify_content="center",
                gap="20px",
                padding_bottom="20px",
            ),
            ui_table(quality_of_life_scores_data_frame, page_size=10),
        )

    # Create the slide
    quality_of_life_slide(multiplier_sliders_for_problem_2)
    return (quality_of_life_slide,)


@app.cell
def _(md):
    # Create the title slide for data cleaning
    md("# Data cleaning and preparation").center()
    return


@app.cell
def _(md, md_numbered_list):
    # Create the slide for the data cleaning
    md(
        "## Data cleaning",
        "The data provided was poorly formatted and organised",
        "with a lot of missing values across all columns.",
        "",
        "The data cleaning procedure we used are as follows:",
        md_numbered_list(
            "Select all the rows containing the series that we have chosen.",
            "Coerce all the data to be numeric.",
            "Drop the unnecessary columns, such as SCALE and Decimals.",
            "Drop the column for 2011, as it doesn't have any data.",
            "Drop all rows that have empty values in the year columns.",
        ),
    )
    return


@app.cell
def _(centred_slide_title, clean_data_function_code, html):
    # Show the code for cleaning the data
    html(
        centred_slide_title("Data cleaning: Implementation"),
        clean_data_function_code,
    )
    return


@app.cell
def _(html, md, md_unnumbered_list):
    # Create the slide for data imputation
    md(
        "## Data imputation: Reasoning",
        md_unnumbered_list(
            html(
                "After the data has been cleaned,",
                "the numerous missing values need to be filled in",
                "through a process called imputation",
                "before the machine learning model can be trained",
                "on the data.",
            ),
            html(
                "Using the results of the exploratory analysis,",
                "we picked the cubic regressor",
                "(polynomial regressor of degree 3)",
                "to impute the missing values row by row,",
                "following the time series.",
                "Using the imputer on the entire data frame",
                "created ridiculous values in some series,",
                "so the imputer applied to each row individually.",
            ),
            html(
                "Linear regression models did not make the cut,",
                "as they were poor at interpolating between",
                "the values in the data set,",
                "causing the missing values to not match",
                "up with the actual values.",
            ),
            html(
                "Decision tree regression models were also a poor choice,",
                "as a significant amount of the data",
                "needed to be extrapolated from the available data.",
                "Decision tree regression models were good at interpolating",
                "within the available data, but were terrible at extrapolating",
                "as the values outside of the available data were just",
                "constant values and did not fit the time series.",
            ),
        ),
    )
    return


@app.cell
def _(centred_slide_title, html, impute_missing_data_function_code):
    # Create the slide for the implementation the imputer
    html(
        centred_slide_title("Data imputation: Implementation"),
        impute_missing_data_function_code,
    )
    return


@app.cell
def _(html, md, md_unnumbered_list):
    # Create the slide for the outcome and conclusion
    md(
        "## Outcome and conclusion",
        md_unnumbered_list(
            html(
                "Overall, we have managed to meet our objectives and",
                "have answered our problem statements in a satisfying manner,",
                "and have already presented our findings",
                "in the previous slides.",
            ),
            html(
                "We have found that the time series data that",
                "we chose presented quite a lot of challenges",
                "for data analysis and imputation,",
                "due to the small amount of data",
                "for machine learning models to train on.",
            ),
            html(
                "The data that we chose gave us an appreciation",
                "for less complex models like linear models",
                "and decision trees, as a lot of the more advanced",
                "models that we tried to use did not fair well on",
                "the tiny data set we had.",
            ),
            html(
                "Even machine learning models that usually work well",
                "with small amounts of data, like support vector machines,",
                "failed to produce good results, and",
                "more complex decision trees overfitted the data.",
            ),
            html(
                "More complex linear models that have regularisation",
                "like Ridge regression, Elastic-Net regression,",
                "and Bayesian regression, also failed to surpass",
                "the basic ordinary least squares linear regression model",
                "in performance.",
            ),
        ),
    )
    return


@app.cell
def _(html, md, md_unnumbered_list):
    # Create the slide for the out of course content
    md(
        "## Out of course content",
        "The out of course content that we explored included the following:",
        md_unnumbered_list(
            html(
                "We made use of an alternative to Jupyter notebooks,",
                "called Marimo, to visualise and present our data.",
                "This entire presentation is created in, and presented",
                "from Marimo.",
                "We learnt about the various Marimo UI elements and",
                "how to use them to create the interactive calculator",
                "for quality of life scores on our slides.",
                "These slides were also made using web technologies,",
                "namely HTML, CSS and JavaScript, as well as Markdown,",
                "which we had to learn to create these slides.",
            ),
            html(
                "We also explored data imputation techniques,",
                "which is not covered in the course at all,",
                "due to our data being a time series with",
                "lots of missing values, making data imputation",
                "vital for our analysis.",
                "Improper data imputation could result in vastly",
                "different results and conclusions,",
                "thanks to our data set having so much missing data.",
            ),
            html(
                "As for machine learning models,",
                "we made use of the PolynomialFeatures preprocessor",
                "to create the cubic polynomial regressor that we",
                "used to impute the missing values,",
                "as well as to predict the 2025 values for each series.",
                "Although we could not demonstrate the more advanced machine",
                "learning models we explored due to their inefficacies",
                "and failure to meet our needs for prediction and imputation,",
                "we realised that increasing model complexity",
                "does not necessarily improve performance,",
                "and on such a tiny data set, it usually reduces performance.",
                "These findings are part of our exploratory analysis.",
            ),
            html(
                "We also made use of z-score normalisation,",
                "which is the same function as the StandardScaler",
                "preprocessor found in Scikit-Learn,",
                "to create our quality of life score.",
            ),
        ),
    )
    return


@app.cell
def _(html, md, md_unnumbered_list):
    # Create the slide for the roles and responsibilities
    md(
        "## Roles and responsibilities",
        md_unnumbered_list(
            html(
                "Haziq was in charge of the exploratory analysis section",
                "and looked up all the regressors in Scikit-Learn to train",
                "and evaluate the models' performance on the data set.",
            ),
            html(
                "Nicholas handled data cleaning and imputation,",
                "as well as data preparation for each of the problems,",
                "making use of Haziq's results to select an applicable imputer",
                "to be used to fill in missing values.",
            ),
            html(
                "Jun Feng was responsible for solving problem 1,",
                "making use of the imputed data to draw regression lines",
                "to show the trend, and interpreting the resulting trends",
                "to draw our conclusions.",
            ),
            html(
                "Dylan was in charge of problem 2,",
                "also making use of Haziq's results to determine",
                "a suitable regression model to predict a value for 2025,",
                "and to come up with a suitable algorithm to turn the",
                "predicted values into scores, and ranking the countries",
                "based on those scores.",
            ),
        ),
    )
    return


@app.cell
def _(html, html_heading):
    # Create the thank you slide
    html(
        html_heading(1, "Thank You!")
        .center()
        .style(
            background_image="linear-gradient(to right, violet, indigo, blue,"
            + "green, yellow, orange, red)",
            color="transparent",
            background_clip="text",
            **{"-webkit-background-clip": "text"},
        )
    ).style(
        display="flex",
        align_items="center",
        justify_content="center",
    )
    return


if __name__ == "__main__":
    app.run()
