import com.accenture.nsdc.salesforcelabs.projecth.bo.BackOfficeFactory;
import com.accenture.nsdc.salesforcelabs.projecth.bo.IBackOffice;

import flash.events.Event;
import flash.utils.ByteArray;
import flash.xml.XMLDocument;

import mx.collections.ArrayCollection;
import mx.collections.XMLListCollection;
import mx.managers.CursorManager;
import mx.rpc.xml.SimpleXMLDecoder;
import mx.utils.ArrayUtil;

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
	
	CursorManager.setBusyCursor();
	
	backoffice.initialise(initialiseUI);
	
}

/**
 * Initialisation des composants et comportement 
 * 
 */
private function initialiseUI():void{
	
	//récupération des boutiques
	backoffice.retrieveShops(function(shops:ArrayCollection):void{
		
		//valorisation de la liste
		shopsDataStore = shops;
		//reactivation du composant
		shopsComponent.enabled = true;
		//fin du curseur "chargement"
		CursorManager.removeBusyCursor();
		
	});
	
	shopsComponent.addEventListener(Event.CHANGE, onShopChange);
	
	//récupération des sales assistants
	//assistantsDataStore = backoffice.retrieveAssistants();
}


/**
 * Callback au changement de valeurs du composant boutique 
 * @param event
 * 
 */
private function onShopChange(event:Event):void{

	CursorManager.setBusyCursor();
	
	var idShop:String = event.currentTarget.dataProvider[event.currentTarget.selectedIndex].Id;
	 
	//récupération des boutiques
	backoffice.retrieveAssistantsByShop(idShop, function(assistants:ArrayCollection):void{
		
		//valorisation de la liste
		assistantsDataStore = assistants;
		//reactivation des composants
		assistantsComponent.enabled = true;
		subjectComponent.enabled = true;
		dateComponent.enabled = true;
		submit.enabled = true;
		
		//fin du curseur "chargement"
		CursorManager.removeBusyCursor();
		
	});
}

