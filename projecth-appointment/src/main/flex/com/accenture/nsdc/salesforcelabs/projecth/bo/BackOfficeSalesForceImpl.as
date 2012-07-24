package com.accenture.nsdc.salesforcelabs.projecth.bo
{
	import com.salesforce.AsyncResponder;
	import com.salesforce.Connection;
	import com.salesforce.objects.LoginRequest;
	import com.salesforce.results.Fault;
	import com.salesforce.results.LoginResult;
	import com.salesforce.results.QueryResult;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Implémentation du Back Office connecté à SalesForce
	 *  
	 * @author mathieu.humbert
	 * 
	 */
	public class BackOfficeSalesForceImpl implements IBackOffice
	{
		
		//Url du webservice Salesforce
		//!\ Attention : TEST.salesforce.com correspond à l'acces à une sandbox
		private static var SERVER_URL:String = "https://login.salesforce.com/services/Soap/u/25.0";
		
		private static var USERNAME:String = "lilian.moncade@accenture.com.fashion";
		private static var PASSWORD:String = "Accenture1";
		private static var TOKEN:String = "psXohm06EL2TZ39sSXAFhMTh";
		
		//Instance de connection Salesforce
		private var sfConnection:Connection = new Connection();
		
		//liste des boutiques
		private var shopsList:ArrayCollection;
		
		/**
		 * Constructeur 
		 * 
		 */
		public function BackOfficeSalesForceImpl(){
		}
		
		/**
		 * @inheritDoc
		 */
		public function initialise(onInitialised:Function):void{
			sfConnection = initSFConnection(USERNAME, PASSWORD+TOKEN, onInitialised);
		}
		
		
		/**
		 * Initialisation de la connection a SALESFORCE
		 *  
		 * @param login Login de connection
		 * @param mdp Mot de passe + token
		 * @param loginSuccess Methode callback en cas de succes
		 * @return 
		 * 
		 */
		private function initSFConnection(login:String, mdp:String, loginSuccess:Function):Connection{
			var loginRequest:LoginRequest = new LoginRequest();
			var connection:Connection = new Connection();
			
			loginRequest.username = login;
			loginRequest.password = mdp;
			
			loginRequest.callback = new AsyncResponder(function(lr:LoginResult):void{loginSuccess();}, function queryError(e:Fault):void {
				trace(e.faultstring);
			});
			connection.serverUrl = SERVER_URL;
			connection.login(loginRequest);
			
			
			return connection;
		}
		
		
		/**
		 * After connection :
		 * Controle l'ensemble des actions une fois la connexion initialisee 
		 * 
		 */
		private function afterConnection():void{
		}
		
		/**
		 * @inheritDoc
		 */
		public function retrieveShops(onResult:Function):void
		{
			if(shopsList != null) onResult(shopsList);
			
			var requete:String= "SELECT Id, Name FROM Shop__c";
			
			executeSalesforceQuery(requete, function(results:QueryResult):void{
				shopsList = new ArrayCollection(results.records.toArray());
				onResult(shopsList);
			});
		}
		
		/**
		 * @inheritDoc
		 */
		public function retrieveAssistantsByShop(idShop:String, onResult:Function):void
		{
			var requete:String= "SELECT Id, FirstName__c, Name FROM Sales_Assistant__c WHERE Shop__r.Id = '"+idShop+"'";
			
			executeSalesforceQuery(requete, function(results:QueryResult):void{
				var assistantList:ArrayCollection = new ArrayCollection(results.records.toArray());
				onResult(assistantList);
			});
		}
		
		/**
		 * Fonction d'execution de Requete
		 */
		private function executeSalesforceQuery(requete:String, queryCallBack:Function):void {
			
			//lancement de la requete
			sfConnection.query(requete, new AsyncResponder(queryCallBack, function queryError(e:Fault):void {
				trace(e.faultstring);
			}));
		}
	}
}