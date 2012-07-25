import com.accenture.nsdc.salesforcelabs.projecth.bo.BackOfficeFactory;
import com.accenture.nsdc.salesforcelabs.projecth.bo.IBackOffice;

import flash.events.Event;
import flash.events.MouseEvent;
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
	
	assistantsComponent.addEventListener(Event.CHANGE, onAssistantChange);
	
	submit.addEventListener(MouseEvent.CLICK, onSave);
	
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
		
		//fin du curseur "chargement"
		CursorManager.removeBusyCursor();
		
	});
}

/**
 * Callback au changement de valeurs du composant Assistant 
 * @param event
 * 
 */
private function onAssistantChange(event:Event):void{
	
	//reactivation des composants
	subjectComponent.enabled = true;
	dateComponent.enabled = true;
	hourComponent.enabled = true;
	submit.enabled = true;
	
}

/**
 * Action au Click sur envoyer
 *  
 * @param event Clic
 * 
 */
private function onSave(event:Event):void{
	
	CursorManager.setBusyCursor();
	switchUI(false);
	
	var idShop:String = shopsComponent.dataProvider[shopsComponent.selectedIndex].Id;
	var idAssistant:String = assistantsComponent.dataProvider[assistantsComponent.selectedIndex].Id;
	var sujet:String = subjectComponent.text;
	var dateSouhaitee:Date = dateComponent.selectedDate;
	var heureSouhaitee:String = hourComponent.textInput.text;
	
	trace("boutique : "+idShop+"\nassistant : "+idAssistant+"\nsujet : "+sujet+"\ndate souhaitee : "+dateSouhaitee +"\nheure souhaitee : "+heureSouhaitee);
	
	backoffice.saveAppointment(idShop, idAssistant, sujet, dateSouhaitee, heureSouhaitee, function():void{
		switchUI(true);
		
		//fin du curseur "chargement"
		CursorManager.removeBusyCursor();
	});
}

/**
 * active/desactive l'interface Utilisateur
 *  
 * @param on active ou desactive
 * 
 */
private function switchUI(on:Boolean):void{
	shopsComponent.enabled = on;
	assistantsComponent.enabled = on
	subjectComponent.enabled = on;
	dateComponent.enabled = on;
	hourComponent.enabled = on;
	submit.enabled = on;
}
