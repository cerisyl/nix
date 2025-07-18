{ config, pkgMap, theme, getThemeFile, homedir, zmod, lib, myHostname, ... }: let
  # Get commit shortstring
  zmodRev = "zmod_${builtins.substring 0 8 zmod.rev}";
  itgShare = if myHostname == "lux" then "/home/ceri/itg/play/songs-share/" else "";
in if pkgMap ? "itgmania" then {
  home.file = {
    # Load latest zmod
    ".itgmania/Themes/${zmodRev}" = {
      source = zmod;
      recursive = true;
    };
    # Source extra judgment files
    ".itgmania/Themes/${zmodRev}/Graphics/_judgments/NJSRT2 Chroma 2x7 (doubleres).png".source      = ../../../extra/itg/judge.png;
    ".itgmania/Themes/${zmodRev}/Graphics/_HoldJudgments/NJSRT2 Chroma 1x2 (doubleres).png".source  = ../../../extra/itg/holdjudge.png;
    # Default preferences
    ".itgmania/Save/Preferences.ini".text = ''
      [Options]
      AdditionalCourseFoldersReadOnly=
      AdditionalCourseFoldersWritable=
      AdditionalFoldersReadOnly=
      AdditionalFoldersWritable=
      AdditionalSongFoldersReadOnly=${itgShare}
      AdditionalSongFoldersWritable=
      AllowExtraStage=0
      AllowHoldForOptions=1
      AllowMultipleHighScoreWithSameName=1
      AllowMultipleInstances=0
      AllowMultipleToasties=1
      AllowMultitexture=1
      AllowSongDeletion=0
      AllowUnacceleratedRenderer=0
      AllowW1=Everywhere
      AnisotropicFiltering=0
      Announcer=
      ArcadeOptionsNavigation=0
      AttractSoundFrequency=EveryTime
      AutoJoin=0
      AutoMapOnJoyChange=1
      AutoPlay=Human
      AutogenGroupCourses=1
      AutogenSteps=0
      AxisFix=0
      BGBrightness=0.700000
      BackUpAllSongSaves=0
      BackgroundFitMode=CoverPreserve
      BlinkGameplayButtonLightsOnNote=0
      BreakComboToGetItem=0
      CelShadeModels=0
      Center1Player=1
      CenterImageAddHeight=0
      CenterImageAddWidth=0
      CenterImageTranslateX=0
      CenterImageTranslateY=0
      CoinMode=Home
      CoinsPerCredit=1
      ComboContinuesBetweenSongs=0
      ConstantUpdateDeltaSeconds=0.000000
      CourseSortOrder=Songs
      CoursesToShowRanking=
      CurrentGame=dance
      CustomSongsEnable=0
      CustomSongsLoadTimeout=5.000000
      CustomSongsMaxCount=1000
      CustomSongsMaxMegabytes=5.000000
      CustomSongsMaxSeconds=120.000000
      DebounceCoinInputTime=0.000000
      DebugLights=0
      DebugMenuEnabled=1
      DefaultLocalProfileIDP1=00000000
      DefaultLocalProfileIDP2=
      DefaultModifiers=NoHideLights, FailImmediateContinue, Overhead, Peters_cel_vibrant_fa+
      DefaultRecordLength=4.000000
      DefaultSyncOffset=ITG
      DefaultTheme=Simply Love
      DelayedBack=1
      DelayedCreditsReconcile=0
      DelayedModelDelete=0
      DelayedScreenLoad=0
      DelayedTextureDelete=1
      DisableScreenSaver=1
      DisableUploadDir=0
      DisabledSongs=
      DisplayAspectRatio=1.777778
      DisplayColorDepth=32
      DisplayHeight=1440
      DisplayId=DP-0
      DisplayWidth=2560
      Disqualification=0
      EasterEggs=0
      EditClearPromptThreshold=50
      EditRecordModeLeadIn=1.000000
      EditorMemoryCardOsMountPoint=
      EditorNoteSkinP1=peters_cel_vibrant_fa+
      EditorNoteSkinP2=peters_cel_vibrant_fa+
      EditorShowBGChangesPlay=1
      EnableAttackSounds=1
      EnableMineHitSound=1
      EventMode=1
      FailOffForFirstStageEasy=0
      FailOffInBeginner=0
      FastLoad=0
      FastNoteRendering=0
      ForceLogFlush=0
      ForceMipMaps=0
      FrameLimitPercent=0.000000
      FullscreenIsBorderlessWindow=1
      GetRankingName=On
      GlobalOffsetSeconds=-0.054000
      HarshHotLifePenalty=1
      HiddenSongs=0
      HideIncompleteCourses=0
      HighResolutionTextures=ForceOn
      HttpAllowHosts=*.groovestats.com
      HttpEnabled=1
      IgnoredDialogs=FRAME_DIMENSIONS_WARNING
      ImageCache=LowResPreload
      InputDebounceTime=0.030000
      InputDeviceOrder=
      InputDrivers=
      Interlaced=0
      Language=en
      LastSeenInputDevices=
      LastSeenVideoDriver=OpenGL
      LifeDifficultyScale=1.000000
      LightsAheadSeconds=0.050000
      LightsBassParallel=0
      LightsComPort=COM54
      LightsDriver=
      LightsFalloffSeconds=0.100000
      LightsSimplifyBass=0
      LightsStepsDifficulty=hard,medium
      LockCourseDifficulties=0
      LogCheckpoints=0
      LogFPS=1
      LogSkips=0
      LogToDisk=1
      LongVerSongSeconds=150.000000
      MachineName=
      MarathonVerSongSeconds=300.000000
      MaxHighScoresPerListForMachine=10
      MaxHighScoresPerListForPlayer=3
      MaxInputLatencySeconds=0.000000
      MaxNumCredits=20
      MaxRegenComboAfterMiss=10
      MaxSongsInEditCourse=-1
      MaxTextureResolution=2048
      MemoryCardDriver=USB
      MemoryCardOsMountPointP1=
      MemoryCardOsMountPointP2=
      MemoryCardPadmissEnabled=0
      MemoryCardProfileImportSubdirs=StepMania 5.1;StepMania 5;In The Groove 2
      MemoryCardProfileSubdir=ITGmania
      MemoryCardProfiles=1
      MemoryCardUsbBusP1=-1
      MemoryCardUsbBusP2=-1
      MemoryCardUsbLevelP1=-1
      MemoryCardUsbLevelP2=-1
      MemoryCardUsbPortP1=-1
      MemoryCardUsbPortP2=-1
      MemoryCards=0
      MenuTimer=0
      MercifulBeginner=0
      MercifulDrain=0
      MercifulSuperMeter=1
      MinPercentageForMachineCourseHighScore=0.000100
      MinPercentageForMachineSongHighScore=0.000100
      MinTNSToHideNotes=W3
      MinTNSToScoreNotes=W3
      Minimum1FullSongInCourses=0
      MonkeyInput=0
      MoveRandomToEnd=0
      MovieColorDepth=32
      MovieDrivers=
      MovieTextureDirectUpdates=1
      MusicWheelSwitchSpeed=100
      MusicWheelUsesSections=Always
      MuteActions=0
      NeverBoostAppPriority=0
      NeverCacheList=
      NumBackgrounds=10
      OnlyDedicatedMenuButtons=1
      OnlyPreferredDifficulties=0
      PAL=0
      PacDriveLightOrdering=lumenar
      PadStickSeconds=0.000000
      PalettedImageCache=0
      PercentageScoring=1
      PreCacheAllWheelSorts=0
      PreferredSortUsesGroups=1
      Premium=DoubleFor1Credit
      ProductID=1
      ProfileCourseEdits=1
      ProfileDataCompress=0
      ProfileSortOrder=Priority
      ProfileSortOrderAscending=1
      ProfileStepEdits=1
      ProgressiveLifebar=0
      ProgressiveNonstopLifebar=0
      ProgressiveStageLifebar=0
      PseudoLocalize=0
      QuirksMode=0
      RandomBackgroundMode=Off
      RateModPreservesPitch=0
      RateModsAffectFGChanges=0
      RefreshRate=0
      RegenComboAfterMiss=5
      RenderEarlierNotesOnTop=0
      SextetStreamOutputFilename=\\.\pipe\StepMania-Lights-SextetStream
      ShowBanners=1
      ShowBeginnerHelper=0
      ShowCaution=1
      ShowDancingCharacters=Off
      ShowDanger=1
      ShowInstructions=1
      ShowLoadingWindow=1
      ShowLogOutput=0
      ShowLyrics=0
      ShowMasks=0
      ShowMouseCursor=1
      ShowNativeLanguage=1
      ShowSongOptions=No
      ShowStats=0
      ShowThemeErrors=0
      SignProfileData=0
      SmoothLines=1
      SongBackgrounds=1
      SongsPerPlay=3
      SoundDevice=
      SoundDrivers=
      SoundPreferredSampleRate=0
      SoundPreload16bit=1
      SoundPreloadMaxSamples=1048576
      SoundVolume=1.000000
      SoundVolumeAttract=1.000000
      SoundWriteAhead=0
      StretchBackgrounds=0
      SubSortByNumSteps=1
      SuperMeterPercentChangeCheckpointHit=0.050000
      SuperMeterPercentChangeCheckpointMiss=-0.200000
      SuperMeterPercentChangeHeld=0.040000
      SuperMeterPercentChangeHitMine=-0.400000
      SuperMeterPercentChangeLetGo=-0.200000
      SuperMeterPercentChangeMiss=-0.200000
      SuperMeterPercentChangeMissedHold=-0.000000
      SuperMeterPercentChangeW1=0.050000
      SuperMeterPercentChangeW2=0.040000
      SuperMeterPercentChangeW3=0.020000
      SuperMeterPercentChangeW4=0.000000
      SuperMeterPercentChangeW5=0.000000
      TestInitialScreen=
      TextureColorDepth=32
      Theme=${zmodRev}
      ThreadedInput=1
      ThreadedMovieDecode=1
      ThreeKeyNavigation=0
      TimeMeterSecondsChangeCheckpointHit=0.000000
      TimeMeterSecondsChangeCheckpointMiss=-0.000000
      TimeMeterSecondsChangeHeld=-0.000000
      TimeMeterSecondsChangeHitMine=-2.000000
      TimeMeterSecondsChangeLetGo=-4.000000
      TimeMeterSecondsChangeMiss=-4.000000
      TimeMeterSecondsChangeMissedHold=-0.000000
      TimeMeterSecondsChangeW1=0.200000
      TimeMeterSecondsChangeW2=0.000000
      TimeMeterSecondsChangeW3=-0.500000
      TimeMeterSecondsChangeW4=-1.000000
      TimeMeterSecondsChangeW5=-2.000000
      TimingWindowAdd=0.001500
      TimingWindowJump=0.250000
      TimingWindowScale=1.000000
      TimingWindowSecondsAttack=0.135000
      TimingWindowSecondsCheckpoint=0.166400
      TimingWindowSecondsHold=0.320000
      TimingWindowSecondsMine=0.070000
      TimingWindowSecondsRoll=0.350000
      TimingWindowSecondsW1=0.021500
      TimingWindowSecondsW2=0.043000
      TimingWindowSecondsW3=0.102000
      TimingWindowSecondsW4=0.135000
      TimingWindowSecondsW5=0.180000
      TrilinearFiltering=0
      TugMeterPercentChangeCheckpointHit=0.002000
      TugMeterPercentChangeCheckpointMiss=-0.002000
      TugMeterPercentChangeHeld=0.008000
      TugMeterPercentChangeHitMine=-0.040000
      TugMeterPercentChangeLetGo=-0.020000
      TugMeterPercentChangeMiss=-0.020000
      TugMeterPercentChangeMissedHold=0.000000
      TugMeterPercentChangeW1=0.010000
      TugMeterPercentChangeW2=0.008000
      TugMeterPercentChangeW3=0.004000
      TugMeterPercentChangeW4=0.000000
      TugMeterPercentChangeW5=-0.010000
      UseUnlockSystem=0
      VideoRenderers=opengl,d3d
      VisualDelaySeconds=0.000000
      Vsync=1
      Windowed=0

      [Game-dance]
      Announcer=
      DefaultModifiers=NoHideLights, FailImmediateContinue, Overhead, Peters_cel_vibrant_fa+
      Theme=${zmodRev}
    '';
    # Theme-based preferences
    ".itgmania/Save/ThemePrefs.ini".text = ''
      [${zmodRev}]
      AllowDanceSolo=false
      AllowFailingOutOfSet=true
      AllowScreenEvalSummary=true
      AllowScreenGameOver=true
      AllowScreenNameEntry=false
      AllowScreenSelectColor=false
      AllowScreenSelectProfile=false
      AllowThemeVideos=true
      AnimateBanners=true
      AutoDownloadUnlocks=true
      AutoStyle=none
      CasualMaxMeter=10
      CloseFolderCodes=CloseFolder3
      DefaultGameMode=ITG
      EditModeLastSeenDifficulty=
      EditModeLastSeenSong=
      EditModeLastSeenStepsType=
      EditModeLastSeenStyleType=
      EnableBoogieStats=false
      EnableGrooveStats=true
      EnableTournamentMode=false
      EnforceNoCmod=true
      FolderStats=true
      GradeCombo=false
      HideStockNoteSkins=false
      ITGDiffColors=ITG
      KeyboardFeatures=true
      LastActiveEvent=
      MusicWheelGS=Scorebox
      MusicWheelStyle=ITG
      NumberOfContinuesAllowed=0
      OutlineGrade=false
      RainbowMode=false
      RescoreEarlyHits=true
      ResultsBG=false
      SampleMusicLoops=false
      ScoringSystem=EX
      ScreenEvaluationMenuTimer=60
      ScreenEvaluationSummaryMenuTimer=60
      ScreenNameEntryMenuTimer=60
      ScreenPlayerOptionsMenuTimer=90
      ScreenSelectMusicCasualMenuTimer=300
      ScreenSelectMusicMenuTimer=300
      SeparateUnlocksByPlayer=false
      SimplyLoveColor=4
      SongSelectBG=Off
      StepStats=Show
      ThemeFont=Mega
      UseImageCache=false
      VisualStyle=Technique
      WriteCustomScores=false
      nice=2
    '';
    # Keymaps
    # ".itgmania/Save/Keymaps.ini".text = ''
    #   [dance]
    #   1_Back=
    #   1_Coin=
    #   1_Down=:Joy1_B3
    #   1_EffectDown=
    #   1_EffectUp=
    #   1_Left=:Joy1_B2
    #   1_MenuDown=:Key_down
    #   1_MenuLeft=:Key_left
    #   1_MenuRight=:Key_right
    #   1_MenuUp=:Key_up
    #   1_Operator=
    #   1_Restart=
    #   1_Right=:Joy1_B5
    #   1_Select=
    #   1_Start=
    #   1_Up=:Joy1_B4
    #   1_UpLeft=
    #   1_UpRight=
    #   2_Back=
    #   2_Coin=
    #   2_Down=
    #   2_EffectDown=
    #   2_EffectUp=
    #   2_Left=
    #   2_MenuDown=
    #   2_MenuLeft=
    #   2_MenuRight=
    #   2_MenuUp=
    #   2_Operator=
    #   2_Restart=
    #   2_Right=
    #   2_Select=
    #   2_Start=
    #   2_Up=
    #   2_UpLeft=
    #   2_UpRight=
    # '';
  };
  # Load our noteskins
  home.activation.loadNoteskins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${homedir}/.itgmania/NoteSkins/dance"
    ${pkgMap.unzip}/bin/unzip -qq -o "${homedir}/.nix/extra/itg/noteskins.zip" -d "${homedir}/.itgmania/NoteSkins/dance"
  '';
} else {}