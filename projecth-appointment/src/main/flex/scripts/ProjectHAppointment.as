import flash.utils.ByteArray;
import mx.collections.XMLListCollection;

[Bindable]
private var shopsDataStore:XMLListCollection;

private function main():void{
	shopsDataStore = new XMLListCollection(shopsXml.root);
}