module Main

import Control.IOExcept
import Control.ST
import Control.ST.File
import Control.ST.ImplicitCall
import IdrisJvm.IO
import IdrisJvm.File

%hide Prelude.File.File
%hide Prelude.File.FileError

testFile : (ConsoleIO m, File m) => ST m () []
testFile = with ST do
              Right _ <- writeFile "writeFileTestFile" "HELLO!!\nWORLD!!\n"
                  | Left ferr => do putStrLn (show ferr)
                                    pure ()
              pure ()


main : JVM_IO ()
main = do putStrLn "--test IO:"
          run testFile
          putStrLn "--test IOExcept:"
          ioe_run (run testFile)
                  (\err => putStrLn err)
                  (\ok  => printLn ok)

-- EOF -------------------------------------------------------------------------
