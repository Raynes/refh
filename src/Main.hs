{-# LANGUAGE DeriveDataTypeable #-}
module Main where

import Network.Haskheap
import System.Clippard (paste)
import System.Directory (getHomeDirectory, doesFileExist)
import System.FilePath ((</>), takeExtension)
import Control.Monad (when)
import System.Console.CmdArgs
import Network.URI (URI)

config :: IO (Maybe (String, String))
config = do
  home <- getHomeDirectory
  let name = home </> ".refh"
  exists <- doesFileExist name
  if exists
    then do
      contents <- readFile name
      let [user, token] = lines contents
      return $ Just (user, token)
    else return Nothing

data Args = Args { userName :: String
                 , token    :: String
                 , copy     :: Bool
                 , language :: String
                 , anon     :: Bool
                 , file     :: String
                 , private  :: Bool
                 } deriving (Show, Data, Typeable)

defArgs :: IO Args
defArgs = do
  let a = Args { userName = def   &= help "Refheap username. Overrides configuration in .refh"
               , token    = def   &= help "Refheap token. Overrides configuration in .refh."
               , copy     = True  &= help "True by default. If true, copy resulting link to clipboard."
               , language = def   &= help "Must be exactly as the language name appears on refheap's dropdown."
               , anon     = False &= help "Paste anonymously regardless of username and token settings."
               , file     = def   &= help "Paste from this file instead of stdin. If extension is present, use it to determine language."
               , private  = False &= help "False by default. If true, make paste private."
               } &= summary "refh v0.1.2"
  cfg <- config
  case cfg of
    Just (user, token) -> return a { userName = user
                                   , token    = token
                                   }
    Nothing            -> return a

pickLang :: String -> String -> String
pickLang file language
  | null ext && null language             = "Plain Text"
  | not (null ext) && not (null language) = language
  | null ext                              = language
  | null language                         = ext
  where ext = takeExtension file

readBody :: String -> IO String
readBody ""   = getContents
readBody file = readFile file

auth :: Bool -> String -> String -> Maybe (String, String)
auth True  _ _        = Nothing
auth False "" _       = Nothing
auth False _ ""       = Nothing
auth False user token = Just (user, token)

getUrlStr :: Maybe URI -> String
getUrlStr (Just url) = show url

main :: IO ()
main = do
  defaults   <- defArgs
  parsedArgs <- cmdArgs defaults
  body       <- readBody $ file parsedArgs
  let lang  = pickLang (file parsedArgs) (language parsedArgs)
      creds = auth (anon parsedArgs) (userName parsedArgs) (token parsedArgs)
  pasted <- createPaste body (private parsedArgs) lang creds
  case pasted of
    Left (Error e)  -> putStrLn e
    Right p -> let url = getUrlStr $ getURL p
               in do when (copy parsedArgs) $ paste url
                     putStrLn url
  