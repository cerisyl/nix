{ pkgMap, ... }:
if pkgMap ? "arrowvortex" then {
  home.file.".config/arrowvortex/settings.txt".text = ''
    general {
      useMultithreading = yes
      useVerticalSync = yes
      defaultSaveFormat = sm
    }
    view {
      backgroundStyle = crop
      showTempoHelp = yes
      useTimeBasedView = yes
      useReverseScroll = no
      useChartPreview = yes
      customSnap = 38
      zoomLevel = 8
      scaleLevel = 4
      receptorX = -16
      receptorY = 130
      noteskinPrefs = Simple, Classic, Metal, Bar, Circles
    }
    interface {
      fontPath = assets/NotoSansJP-Medium.ttf
      fontSize = 13
    }
    statusbar {
      showChart = yes
      showSnap = no
      showBpm = yes
      showRow = no
      showBeat = yes
      showMeasure = yes
      showTime = yes
      showTimingMode = yes
    }
    editing {
      useJumpToNextNote = no
      useUndoRedoJumps = yes
      useTimeBasedCopy = no
    }
    waveform {
      bgColor = 0, 0, 0, 1
      waveColor = 0.23, 0.12, 0.45, 1
      filterColor = 0.59, 0.54, 0.8, 1
      luminance = uniform
      waveStyle = rectified
      antiAliasing = 3
    }
    audio {
      musicVolume = 80
      tickOffsetMs = 0
    }
    dialogs {
    }
  '';
} else {}
