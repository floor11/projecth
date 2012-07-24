package com.accenture.nsdc.salesforcelabs.projecth.bo
{
	import mx.collections.ArrayCollection;

	/**
	 * Interface de définition du Back Office
	 *  
	 * @author mathieu.humbert
	 * 
	 */
	public interface IBackOffice
	{
		
		/**
		 * Initialise le Back Office. 
		 * Fonctionne en asynchrone, il faut passer par la methode callback pour attendre la fin de l'init.
		 * 
		 * @param onInitialised methode callback
		 * 
		 */
		function initialise(onInitialised:Function):void;
		
		/**
		 * recherche l'ensemble des boutiques disponibles
		 * 
		 * @param onResult methode callback qui obtient le resultat en parametre (type ArrayCollection)
		 * 
		 */
		function retrieveShops(onResult:Function):void;
		
		/**
		 * recherche l'ensemble des sales assistants disponibles par boutique
		 * 
		 * @param idShop Id Salesforce de l'objet Shop pour lequel on cherche les assistants
		 * @param onResult methode callback qui obtient le resultat en parametre (type ArrayCollection)
		 * 
		 */
		function retrieveAssistantsByShop(idShop:String, onResult:Function):void;
	}
}