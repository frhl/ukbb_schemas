#!/bin/bash

# Define the output directory for downloaded schema files
readonly out_dir="/Users/flassen/Projects/26_ukbb_schemas/ukbb_schemas/data/schemas"  # Default directory "./schemas" if not provided as an argument


# Create the output directory if it does not exist
mkdir -p "$out_dir"


# Function to download schema and copy with a new name
download_schema() {
    id=$1
    name=$2
    # Format filename: replace spaces with underscores, remove special characters, and convert to lowercase
    filename=$(echo "$name" | sed 's/ /_/g' | sed 's/[^a-zA-Z0-9_]//g' | tr '[:upper:]' '[:lower:]').txt
    # Download file
    wget -nd -O "$out_dir/$filename" "biobank.ndph.ox.ac.uk/ukb/scdown.cgi?fmt=txt&id=$id"
    # Copy the file with a generic name schema<ID>.txt
    cp "$out_dir/$filename" "$out_dir/schema$id.txt"
}

# Schema IDs and descriptions
declare -a schemas=(
    "3	Categories_used_to_group_data_fields_and_other_objects_on_Showcase_interface"
    "13	Category_browse_tree_structure"
    "18	Columns_of_data_in_Record_tables"
    "1	Data_field_properties"
    "14	Data_field_recommendations"
    "16	Data_field_summary"
    "2	Encoding_dictionaries"
    "15	Genotyped_SNPs"
    "9	Instancing_dictionaries"
    "19	Publications"
    "17	Record_tables_available_via_data_portal"
    "21	Related_data_field_linkages"
    "4	Returned_datasets_from_Applications"
    "999	Schema_provided_for_the_Showcase_service"
    "11	Values_for_hierarchical_integer_encodings"
    "12	Values_for_hierarchical_string_encodings"
    "10	Values_for_instances"
    "8	Values_for_simple_date_encodings"
    "5	Values_for_simple_integer_encodings"
    "7	Values_for_simple_real_floating-point_encodings"
    "6	Values_for_simple_string_encodings"
    "20	Values_for_simple_time_encodings"
)

# Loop through schema list and download each one
for item in "${schemas[@]}"; do
    id=$(echo "$item" | cut -f1)
    name=$(echo "$item" | cut -f2-)
    download_schema "$id" "$name"
done

echo "Download complete. Files are saved in $out_dir."



