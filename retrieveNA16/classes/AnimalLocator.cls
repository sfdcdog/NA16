public class AnimalLocator{

	public static String getAnimalNameById(Integer id){		
		Http http = new Http();
        String animalName = '';
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        system.debug('@@@@'+request);
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('#####'+results);
            // Cast the values in the 'animals' key as a list
            Map<String, Object> animal = (Map<String, Object>) results.get('animal');
            System.debug('Received the following animals:');
            System.debug(animal.get('name'));
            animalName = String.valueof(animal.get('name'));
        }
        return animalName;
	}
}