import com.accenture.nsdc.salesforcelabs.projecth.bo.BackOfficeFactory;
import com.accenture.nsdc.salesforcelabs.projecth.bo.IBackOffice;

import flash.utils.ByteArray;
import flash.xml.XMLDocument;

import mx.collections.ArrayCollection;
import mx.collections.XMLListCollection;
import mx.rpc.xml.SimpleXMLDecoder;
import mx.utils.ArrayUtil;

//Implémentation du backoffice (mock ou salesforce en fonction du contexte)
private var backoffice:IBackOffice = BackOfficeFactory.getBackOfficeInstance();

/**
 * Variables bindés aux composants MXML 
 */
[Bindable]
private var shopsDataStore:ArrayCollection;

[Bindable]
private var assistantsDataStore:ArrayCollection;


/**
 * Main : Methode principale appellée au creationComplete
 * 
 */
private function main():void{
	
	//récupération des boutiques
	shopsDataStore = backoffice.retrieveShops();
	
	//récupération des sales assistants
	assistantsDataStore = backoffice.retrieveAssistants();
}


