#!/bin/sh

compare_option=$1
result_file=result.txt

compare () {
    comm -23 $1 $2
}

find_missing_lines () {
    compare $1 $2 >> $result_file
    echo $(compare $1 $2 | wc -l) differences found >> $result_file
}

printf '' > $result_file

cat actual.txt | sort | uniq > actual_sorted
cat expected.txt | sort | uniq > expected_sorted

printf "Missing lines:\n" >> $result_file
find_missing_lines expected_sorted actual_sorted

printf "\nExtra lines:\n" >> $result_file
find_missing_lines actual_sorted expected_sorted

if [ $compare_option == "wc" ] 
then
	printf "\nCommon lines\n" >> $result_file
	comm -12 expected_sorted actual_sorted >> $result_file
fi

cat $result_file
