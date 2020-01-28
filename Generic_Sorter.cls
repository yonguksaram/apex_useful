public with sharing class Generic_Sorter {
    public static List<Object> sortByStringField(List<Object> objectsToSort, String sortingFieldName) {
        List<Object> result = new List<Object>();
        Map<String, List<Object>> fieldNameToObject = new Map<String, List<Object>>();
        List<String> fieldValuesToSort = new List<String>();

        for (Object obj : objectsToSort) {
            String jsonInstance = JSON.serialize(obj);
            Map<String, Object> untypedInstance = (Map<String, Object>)JSON.deserializeUntyped(jsonInstance);
            String fieldValue = untypedInstance.get(sortingFieldName) == null 
                ? null 
                : ((String) untypedInstance.get(sortingFieldName)).toUpperCase();

            if (fieldNameToObject.containsKey(fieldValue)) {
                fieldNameToObject.get(fieldValue).add(obj);
            } else {
                fieldNameToObject.put(fieldValue, new List<Object>{ obj });
            }
            fieldValuesToSort.add(fieldValue);
        }
        fieldValuesToSort.sort();
        
        for (String fieldValueSorted : fieldValuesToSort) {
            result.add(fieldNameToObject.get(fieldValueSorted)[0]);
            if (fieldNameToObject.get(fieldValueSorted).size() == 1) {
                fieldNameToObject.remove(fieldValueSorted);
            } else {
                fieldNameToObject.get(fieldValueSorted).remove(0);
            }
        }

        return result;
    }
}
