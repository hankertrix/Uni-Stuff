# Each function in this file corresponds to each part of the code

# You can safely ignore these imports
# They are here so that I can annotate the return value of the functions
from typing import List, Dict

# Function to retrieve all the genes involved in photosynthesis
def get_genes_involved_in_photosynthesis() -> List[str]:

    # The genes containing the identifier for the genes involved in photosynthesis
    genes_of_interest = []

    # Opens the mapman text file in read mode
    # The "r" stands for read mode
    with open("Sorghum_bicolor_mapman.txt", "r") as file:

        # Get the file as a list of lines with the file.readlines() function
        lines = file.readlines()

        # Remove the first line from the file because it is just the headers for the data, which we don't need
        # The "[1:]" means to take all the items in the list from the second item to the last item
        # So in this case it would be getting the 2nd line until the last line
        # Remember that lists in Python are zero-indexed so you have to add 1 from the index to get the correct item, so the 1st item is index 0, the 2nd item is index 1 and so on
        lines = lines[1:]

        # Iterates the list of lines
        for line in lines:

            # Checks if the line contains the word "Photosynthesis" and "sobic"
            if "Photosynthesis" in line and "sobic" in line:

                # Split the line at the tab character to get the data fields
                fields = line.split("\t")

                # Gets the identifier of the gene from the data fields
                # The identifier is the 3rd item in the list
                # The reason why we don't have to check if the list has 3 items or more is because we already checked if the word "sobic" is in the line, and we know that if the word "sobic" is in the line, we definitely have at least 3 items
                gene = fields[2]

                # If the identifier of the gene is not already in the list of genes involved in photosynthesis
                if gene not in genes_of_interest:

                    # Adds the identifier to the list
                    genes_of_interest.append(gene)

    # Returns the list of genes that are involved in photosynthesis
    # You can ignore this return statement
    return genes_of_interest


# Function to create the dictionary that maps the gene identifier to their expression profiles
def create_id_to_exp_dict(genes_of_interest: List[str]) -> Dict[str, List[float]]:

    # The dictionary that maps the gene identifier to their expression profile
    id_to_exp = {}

    # Opens the expression matrix file in read mode
    with open("Sorghum_bicolor-4558_3.txt", "r") as file:

        # Get all the lines of the file
        lines = file.readlines()

        # Remove the first line of the file as that contains the headers for the data
        # The explanation for [1:] is on line 21 of this file
        lines = lines[1:]

        # Iterates the lines of the file
        for line in lines:

            # Split the line at the tab character
            splittedLine = line.split("\t")

            # Gets the identifier for the gene, which is the first thing on the line
            gene = splittedLine[0]

            # Change the identifier to lowercase
            # The reason for this is that the identifier we got from the Sorghum_bicolor_mapman.txt file is in lowercase but the identifier we get from the Sorghum_bicolor-4558_3.txt file is in uppercase
            gene = gene.lower()

            # If the identifier is in the list of genes that are involved in photosynthesis
            # We don't really care about the other genes so yeah
            if gene in genes_of_interest:

                # Get the expression profile for the current gene
                # Everything after the identifier (which is the first item) for the gene is a number
                # Which means that it is the expression profile for the gene
                # So we pull the rest of the items in the line to get the expression profile
                # The explanation for [1:] is on line 21
                expression_profile = splittedLine[1:]

                # Convert the expression profile to floating point values (decimal values)
                # We need to do this because the numbers are currently a string and we have to convert it to a decimal number
                # We can't use the integer type since the numbers aren't whole numbers, so we must use the floating point type
                expression_profile = [float(number) for number in expression_profile]

                # [float(number) for number in expression_profile] is what is called a list comprehension
                # It is pretty confusing for beginners to get, so I suggest that you don't use it until you really understand what it is doing
                # [float(number) for number in expression_profile] is equivalent to the code below:

                #########################################
                # [float(number) for number in expression_profile] equivalent code

                # The list to store the numbers that have been converted to the floating point type
                # numbers_to_float = []

                # Iterates the list of numbers in the expression profile
                # This line is the same as "for number in expression_profile" in [float(number) for number in expression_profile]
                # for number in expression_profile:

                    # Change the number to a floating point type and adds it to the list of numbers that have been converted to the floating point type
                    # The line is the same as the "float(number)" in [float(number) for number in expression_profile]
                    # numbers_to_float.append(float(number))

                # Reassign the expression profile to the list of numbers that have been converted to the floating point type
                # expression_profile = numbers_to_float

                #########################################

                # Add the identifier for the gene and it's corresponding expression profile to the dictionary
                id_to_exp[gene] = expression_profile

    # Returns the dictionary that maps the gene identifier to its corresponding expression profile
    # You can ignore this return statement
    return id_to_exp


# Function to create the co-expression network that contains the list of pairs of genes that are considered co-expressed
def create_list_of_co_expressed_gene_pairs(genes_of_interest: List[str], id_to_exp: Dict[str, List[float]]) -> List[List[str]]:

    # Imports the stats module from scipy
    # For the record, I do not recommend importing modules inside functions
    # This import here is just to follow the Jupyter notebook format that you use
    # Instead, all imports that you use should be at the top of the file
    from scipy import stats

    # The list of pairs of genes that are co-expressed
    # Also called the co-expression network
    list_of_co_expressed_gene_pairs = []

    # The correlation coefficient threshold to get 100 pairs of co-expressed genes
    CORRELATION_COEFFICIENT_THRESHOLD = 0.9237

    # Iterates the list of genes that are involved in photosynthesis
    # The enumerate function takes a list and gives back the index of the item in the list as the first item
    # And the item itself as the second item
    for current_index, current_gene in enumerate(genes_of_interest):

        # Iterates the list of genes that are after the current gene
        # The reason for this is that we need to check every single pair of genes to get the genes that are co-expressed
        # The genes that were before the current gene have already been checked since we were going through every gene after the previous gene, which would have included the current gene
        # So we only need to check the genes that come after the current gene
        # To do that, we get the list of all the genes that come after the current gene
        # The [current_index + 1:] means to take the items in the list that is from the item at "current_index + 1", which is the next item, to the last item
        for other_gene in genes_of_interest[current_index + 1:]:

            # Get the expression profile for the current gene
            current_gene_exp = id_to_exp[current_gene]

            # Get the expression profile for the other gene that is to be compared with the current gene
            other_gene_exp = id_to_exp[other_gene]

            # Gets the pearson correlation coefficient
            # We don't need the p-value, so we just assign it to an underscore, which means we throw it away
            # You can safely ignore the warning given by this line because you are already checking if the correlation coefficient is larger than the threshold, which would filter out any undefined values (in this case it's nan, or not a number)
            correlation_coefficient, _ = stats.pearsonr(current_gene_exp, other_gene_exp)

            # If the correlation coefficient is greater or equal to the correlation coefficient threshold
            if correlation_coefficient >= CORRELATION_COEFFICIENT_THRESHOLD:

                # Add the pair of genes to the list of pairs of genes that are considered co-expressed
                list_of_co_expressed_gene_pairs.append([current_gene, other_gene])


    # Returns the list of pairs of genes that are co-expressed
    # You can ignore this return statement
    return list_of_co_expressed_gene_pairs
    

# The function to get the gene that is most co-expressed with other genes
def get_most_connected_gene(list_of_co_expressed_gene_pairs: List[List[str]]) -> str:

    # The dictionary mapping the gene to the number of times the gene has been co-expressed
    gene_to_number_of_times_gene_is_co_expressed_dict = {}

    # Iterates the list of gene pairs in the list of pairs of genes that are co-expressed
    for gene_pair in list_of_co_expressed_gene_pairs:

        # Iterates the genes in the gene pair
        for gene in gene_pair:

            # If the gene is not inside the dictionary
            if gene not in gene_to_number_of_times_gene_is_co_expressed_dict:

                # Adds the gene to the dictionary with a count of 1
                gene_to_number_of_times_gene_is_co_expressed_dict[gene] = 1

            # Otherwise
            else:

                # Add 1 to the number of times the gene has been co-expressed
                gene_to_number_of_times_gene_is_co_expressed_dict[gene] += 1


    # Gets the gene that is most connected with other gene
    # The max function returns the item with the maximum value among the items given
    # The key being the gene_to_number_of_times_gene_is_co_expressed_dict.get method means that the values of the dictionary, which is the number of times the gene is co-expressed, are the ones that are being compared to get the maximum value
    # It will return the item that corresponds to that key, which is the identifier of the gene that has been co-expressed the highest number of times
    most_connected_gene = max(
        gene_to_number_of_times_gene_is_co_expressed_dict,
        key=gene_to_number_of_times_gene_is_co_expressed_dict.get
    )

    # Returns the most connected gene
    # You can ignore this return statement
    return most_connected_gene


# Function to create the dictionary that maps the gene to its description
def create_gene_to_desc_dict() -> Dict[str, str]:

    # The dictionary that maps the gene to its description
    gene_to_desc_dict = {}

    # Opens the mapman file in read mode
    with open("Sorghum_bicolor_mapman.txt", "r") as file:

        # Gets the lines of the file
        lines = file.readlines()

        # Remove the first line of the file as it is just the header for the data
        # The explanation for [1:] is on line 21
        lines = lines[1:]

        # Iterates the lines of the file
        for line in lines:

            # Split the line at the tab character
            fields = line.split("\t")

            # If the length of the fields is more than or equal to 4
            # We need to check that both the identifier of the gene, which is the 3rd item, and the description of the gene, which is the 4th item, are on the line
            if len(fields) >= 4:

                # Get the identifier of the gene, which is the 3rd item
                gene = fields[2]

                # Get the description of the gene, which is the 4th item
                description = fields[3]

                # Add the identifier and its corresponding description to the dictionary
                gene_to_desc_dict[gene] = description

    # Returns the dictionary that maps the gene identifier to its corresponding description
    # You can ignore this return statement
    return gene_to_desc_dict


# Function to create the top 50 genes in the genome that is most co-expressed with the most connected gene
def create_top_50_most_co_expressed_gene(genes_of_interest: List[str], id_to_exp: Dict[str, List[float]], gene_to_desc_dict: Dict[str, str], most_connected_gene: str) -> str:

    # The most connected gene, which is the ID of the gene from week 10
    most_connected_gene = "sobic.003g378600"

    # Import the stats module from scipy
    # Once again, I do not recommend importing modules within functions
    # All imports that you use should be at the top of the file
    # But this is done so that it works in the Jupyter notebook format
    from scipy import stats

    # The dictionary that maps the identifier of the gene to the correlation coefficient
    gene_to_correlation_coefficient_dict = {}

    # Gets the expression profile for the most connected gene
    most_connected_gene_expression_profile = id_to_exp[most_connected_gene]

    # Iterates all the genes in the genome, which we have in the id_to_exp dictionary
    # The id_to_exp.items() method gives the key of the dictionary, which is the identifier of the gene in this case, and the key's corresponding value, which is the expression profile for the gene in this case
    for gene, expression_profile in id_to_exp.items():

        # Calculate the correlation coefficient for the gene in the id_to_exp dictionary and the most connected gene
        # Once again, we have no use for the p-value so we assign it to an underscore, which means to throw it away
        # Don't worry about the warning, we will handle it in the next line of code
        correlation_coefficient, _ = stats.pearsonr(
            expression_profile,
            most_connected_gene_expression_profile
        )

        # Check if the correlation coefficient is not an undefined value, which is nan, or not a number, in this case
        if str(correlation_coefficient) != "nan":

            # Adds the gene and its corresponding correlation coefficient to the gene_to_correlation_coefficient_dict if the correlation coefficient is not nan
            # We don't need to make the identifier of the gene lowercase as we have already made it lowercase when we created the id_to_exp dictionary, so all the gene identifiers are already lowercase
            gene_to_correlation_coefficient_dict[gene] = correlation_coefficient

    # Now that we have the dictionary mapping the gene to its correlation coefficient with the most connected gene, we can start displaying the top 50 genes that are most co-expressed with the most connected gene

    # Sort the dictionary mapping the gene to its correlation coefficient in descending order, based on the gene's correlation coefficient and return all the keys (which are the genes in this case) in a list
    # The sorted function returns a list of all the items, sorted according to its key in ascending order
    # The reverse=True means that the list returned by the sorted function is now in descending order
    # So to put this in context, the sorted function below will return the list of all the genes in the gene_to_correlation_coefficient_dict, sorted by its correlation coefficient (which are the values of the gene_to_correlation_coefficient_dict as gene_to_correlation_coefficient_dict.get will get the value [the correlation coefficient in this case] corresponding to the key [the gene in this case] in the dictionary), in descending order
    genes = sorted(
        gene_to_correlation_coefficient_dict,
        key=gene_to_correlation_coefficient_dict.get,
        reverse=True
    )

    # The list of strings that we will use to display the top 50 genes that are most co-expressed with the most connected gene
    top_50_genes = []

    # Adds the header for the top 50 genes
    top_50_genes.append("Correlation coefficient\tGene ID\tDescription")

    # Iterates the genes in the list
    for gene in genes:

        # If the number of genes in the list is greater or equal to 50
        if len(top_50_genes) >= 50:

            # Breaks out of the loop, which means to immediately stop the iteration and go the the line of code after the loop as we only need 50 genes
            break

        # Get the correlation coefficient for the gene
        gene_correlation_coefficient = gene_to_correlation_coefficient_dict[gene]

        # Get the description for the gene
        description = gene_to_desc_dict[gene]

        # Add the correlation coefficient, gene and the gene description to the top 50 genes that are most co-expressed with the most connected gene
        # The f before the double quotes of the string means that the string is a format string
        # What this means is that everything that is inside curly brackets {} is a variable in your code that is automatically converted to a string
        # Everything else that isn't inside the curly brackets will be treated as a normal character in the string and will be displayed as is
        top_50_genes.append(f"{gene_correlation_coefficient}\t{gene}\t{description}")

    # To display the top 50 genes that are most co-expressed with the most connected gene, we join the list using the newline character "\n" and print it out
    print("\n".join(top_50_genes))

    # Return the top 50 genes that are most co-expressed with the most connected gene, joined with the new line character
    # You can ignore this return statement
    return "\n".join(top_50_genes)


# The main function to run
def main() -> None:

    # Get all the genes involved in photosynthesis
    genes_of_interest = get_genes_involved_in_photosynthesis()

    # Gets the dictionary that maps the gene identifier to its corresponding expression profile
    id_to_exp = create_id_to_exp_dict(genes_of_interest)

    # Gets the list of pairs of genes that are co-expressed
    # Which is also called a co-expression network
    list_of_co_expressed_gene_pairs = create_list_of_co_expressed_gene_pairs(genes_of_interest, id_to_exp)

    # Gets the gene that is most connected to the other genes
    most_connected_gene = get_most_connected_gene(list_of_co_expressed_gene_pairs)

    print(most_connected_gene)

    # Gets the dictionary that maps the identifier of the gene to its corresponding description
    gene_to_desc_dict = create_gene_to_desc_dict()

    # Create the list of the top 50 genes that are most co-expressed with the most connected gene
    create_top_50_most_co_expressed_gene(genes_of_interest, id_to_exp, gene_to_desc_dict, most_connected_gene)


# Name safeguard
if __name__ == "__main__":
    main()
