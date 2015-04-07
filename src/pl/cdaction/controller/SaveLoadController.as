package pl.cdaction.controller
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import org.osflash.signals.Signal;

	public class SaveLoadController
	{
		private var _sigBrowsing : Signal;
		private var _sigDataLoaded : Signal;
		
		private var _currentFile : File;
		private var _docsDir : File;
		private var _fileStream : FileStream;
		
		private var _objToSave : Object;
		
		
		public function SaveLoadController()
		{
			init();
		}
		
		private function init() : void
		{
			_docsDir = File.documentsDirectory;
			
			_sigBrowsing = new Signal(Boolean);
			_sigDataLoaded = new Signal(Object);
		}
		
		
		public function saveFile( objToSave : Object ) : void
		{
			_objToSave = objToSave;
			
			if(_currentFile)
			{
				//Just save
				performSaving();
			}
			else
			{
				//Pick where we should save
				browseForSaving( _objToSave );
			}
		}
		
		public function browseForSaving( objToSave : Object ) : void
		{
			_objToSave = objToSave;
			_sigBrowsing.dispatch(true);
			
			try
			{
				_docsDir.browseForSave("Gdzie zapisac?");
				_docsDir.addEventListener(Event.SELECT, handleFileForSaveSelected);
				_docsDir.addEventListener(Event.CANCEL, handleCancelBrowsing);
			}
			catch (error:Error)
			{
				trace("Cos poszlo nie tak:", error.message);
			}
		}
		
		private function handleFileForSaveSelected(event : Event) : void
		{
			_sigBrowsing.dispatch(false);
			cleanListeners();
			
			_currentFile = new File( (event.target as File).nativePath + ".json" );
			performSaving();
		}
		
		protected function handleCancelBrowsing(event:Event) : void
		{
			_sigBrowsing.dispatch(false);
			cleanListeners();
		}
		
		private function performSaving() : void
		{
			if(_fileStream == null)
				_fileStream = new FileStream();
			
			try
			{
				_fileStream.open(_currentFile, FileMode.WRITE);
				_fileStream.writeUTFBytes( JSON.stringify(_objToSave) );
			}
			catch (e:Error)
			{
				trace(e.message);
			}
			finally
			{
				_fileStream.close();
			}
		}
		
		
		public function browseForOpening() : void
		{
			_sigBrowsing.dispatch(true);
			
			var fileFilter : FileFilter = new FileFilter("JSON data files", "*.json");
			
			if(_currentFile)
			{
				_currentFile.addEventListener(Event.SELECT, handleFileForOpenSelected);
				_currentFile.addEventListener(Event.CANCEL, handleCancelBrowsing);
				_currentFile.browseForOpen("Gdzie ten plik?", [fileFilter] );
			}
			else
			{
				_docsDir.addEventListener(Event.SELECT, handleFileForOpenSelected);
				_docsDir.addEventListener(Event.CANCEL, handleCancelBrowsing);
				_docsDir.browseForOpen("Gdzie ten plik?", [fileFilter] );
			}
		}
		
		private function handleFileForOpenSelected(event : Event) : void
		{
			_sigBrowsing.dispatch(false);
			cleanListeners();
			
			_currentFile = event.target as File;
			
			if(_fileStream == null)
				_fileStream = new FileStream();
			
			try
			{
				_fileStream.open(_currentFile, FileMode.READ);
				var fileDataString : String = _fileStream.readUTFBytes( _fileStream.bytesAvailable );
				var fileDataObj : Object = JSON.parse( fileDataString );
			}
			catch (e:Error)
			{
				trace(e.message);
			}
			finally
			{
				_fileStream.close();
				handleFileDataLoadedAndParsed( fileDataObj );
			}
		}
		
		private function handleFileDataLoadedAndParsed(fileDataObj : Object) : void
		{
			_sigDataLoaded.dispatch( fileDataObj );
		}
		
		
		
		private function cleanListeners() : void
		{
			if(_docsDir)
			{
				_docsDir.removeEventListener(Event.SELECT, handleFileForSaveSelected);
				_docsDir.removeEventListener(Event.SELECT, handleFileForOpenSelected);
				_docsDir.removeEventListener(Event.CANCEL, handleCancelBrowsing);
			}
			if(_currentFile)
			{
				_currentFile.removeEventListener(Event.SELECT, handleFileForOpenSelected);
				_currentFile.removeEventListener(Event.CANCEL, handleCancelBrowsing);
			}
		}
		
		
		
		public function get sigBrowsing() : Signal
		{
			return _sigBrowsing;
		}
		
		public function get sigDataLoaded() : Signal
		{
			return _sigDataLoaded;
		}
	}
}