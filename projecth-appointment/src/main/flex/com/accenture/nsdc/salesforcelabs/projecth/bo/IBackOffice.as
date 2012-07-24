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
		 * recherche l'ensemble des boutiques disponibles
		 * 
		 * @return un ArrayCollection d'objet boutique
		 * 
		 */
		function retrieveShops():ArrayCollection;
		
		/**
		 * recherche l'ensemble des sales assistants disponibles
		 * 
		 * @return un ArrayCollection d'objet sales assistant
		 * 
		 */
		function retrieveAssistants():ArrayCollection;
	}
}