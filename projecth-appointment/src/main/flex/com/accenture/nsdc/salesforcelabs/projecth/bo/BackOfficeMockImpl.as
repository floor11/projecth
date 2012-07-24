package com.accenture.nsdc.salesforcelabs.projecth.bo
{
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ArrayUtil;
	
	/**
	 * 
	 * Implémentation du Back Office avec des données mocké (en XML)
	 * 
	 * @author mathieu.humbert
	 * 
	 */
	public class BackOfficeMockImpl implements IBackOffice
	{
		
		/**
		 * Fichiés embarqués 
		 */		
		[Embed(source="shops.xml")]
		private var shopsFile:Class;
		
		[Embed(source="sales-assistants.xml")]
		private var assistantsFile:Class;
		
		
		
		private var shopsList:ArrayCollection;
		private var assistantsList:ArrayCollection;
		
		/**
		 * Constructeur.
		 * Initialisation des listes statiques
		 * 
		 */
		public function BackOfficeMockImpl()
		{
			shopsList = fileToDatastore(shopsFile);
			assistantsList = fileToDatastore(assistantsFile);
		}
		
		/**
		 * @inheritDoc
		 */
		public function retrieveShops():ArrayCollection
		{
			return shopsList;
		}
		
		/**
		 * @inheritDoc
		 */
		public function retrieveAssistants():ArrayCollection
		{
			return assistantsList;
		}
		
		/**
		 * Transforme un fichier xml embarqué (Class) en liste d'objet (ArrayCollection)
		 *  
		 * @param file. fichier embarqué (type Class)
		 * @return un ArrayCollection correspondant
		 * 
		 * 
		 */
		private function fileToDatastore(file:Class):ArrayCollection{
			var dataObject:Object = (new SimpleXMLDecoder()).decodeXML((new XMLDocument(file.data as XML)));
			var dataArray:Array = ArrayUtil.toArray(dataObject.nodes.node);
			
			return new ArrayCollection(dataArray);
		}
	}
}