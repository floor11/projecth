package com.accenture.nsdc.salesforcelabs.projecth.bo
{
	/**
	 * Class Factory pour la creation du Back Office (IBackOffice).
	 * 
	 * @exemple BackOfficeFactory.getBackOfficeInstance();
	 *  
	 * @author mathieu.humbert
	 * 
	 */
	public class BackOfficeFactory
	{
		private static var backOfficeFactory:BackOfficeFactory;
		
		private static var backOfficeImpl:IBackOffice;
		
		/**
		 * DEPRACATED Constructeur
		 * 
		 *  @throws Error Systématiquement car depracated
		 * 
		 */
		public function BackOfficeFactory(){
			throw new Error("BackOfficeFactory est un Singleton : passez par BackOfficeFactory.getInstance()");
		}
		

		/**
		 * Retourne l'instance unique de BackOfficeFactory
		 *  
		 * @return the BackOfficeFactory
		 * 
		 */
		public static function getInstance():BackOfficeFactory{
			if(backOfficeFactory == null){
				backOfficeFactory = new BackOfficeFactory();
			}
			
			return backOfficeFactory;
		}
		
		/**
		 * Retourne l'instance unique de l'implémentation du Back Office
		 * (Mock ou Salesforce)
		 *  
		 * @return L'implémentation du Back Office (Mock ou SalesForce)
		 * 
		 */
		public static function getBackOfficeInstance():IBackOffice{
			if(backOfficeImpl == null){
				backOfficeImpl = new BackOfficeMockImpl();
			}
			
			return backOfficeImpl;
		}
	}
}