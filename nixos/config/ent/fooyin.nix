{ pkgMap, theme, getThemeFile, homedir, lib, ... }:
if pkgMap ? "fooyin" then {
  home.file.".config/fooyin/layouts/${theme}.fyi".source = (getThemeFile "fooyin.fyi");
  home.file.".config/fooyin/fooyin.conf".text = ''
    [General]
    LogLevel=4

    [Artwork]
    Paths="@Variant(\0\0\0\x7f\0\0\0\vCoverPaths\0\xbc\xb0\xa9\xb0\0\0\0\x1\0\0\0\x4\0\0\0\x1e\0%\0p\0\x61\0t\0h\0%\0/\0\x66\0o\0l\0\x64\0\x65\0r\0.\0*\0\0\0\x1c\0%\0p\0\x61\0t\0h\0%\0/\0\x63\0o\0v\0\x65\0r\0.\0*\0\0\0\x1c\0%\0p\0\x61\0t\0h\0%\0/\0\x66\0r\0o\0n\0t\0.\0*\0\0\0\x34\0%\0p\0\x61\0t\0h\0%\0/\0.\0.\0/\0\x41\0r\0t\0w\0o\0r\0k\0/\0\x66\0o\0l\0\x64\0\x65\0r\0.\0*\0\0\0\x1\0\0\0\x1a\0%\0p\0\x61\0t\0h\0%\0/\0\x62\0\x61\0\x63\0k\0.\0*\0\0\0\x2\0\0\0\x1e\0%\0p\0\x61\0t\0h\0%\0/\0\x61\0r\0t\0i\0s\0t\0.\0*\0\0\0,\0%\0p\0\x61\0t\0h\0%\0/\0%\0\x61\0l\0\x62\0u\0m\0\x61\0r\0t\0i\0s\0t\0%\0.\0*\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff)"
    SaveMethods=@Variant(\0\0\0\x7f\0\0\0\x1b\x46ooyin::ArtworkSaveMethods\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\xff\xff\xff\xff\0\0\0Z)
    SourceState=@ByteArray(\0\0\0\0\0\0\0\x3\0\0\0>\0M\0u\0s\0i\0\x63\0\x42\0r\0\x61\0i\0n\0z\0 \0(\0\x43\0o\0v\0\x65\0r\0 \0\x41\0r\0t\0 \0\x41\0r\0\x63\0h\0i\0v\0\x65\0)\0\0\0\0\x1\0\0\0\f\0L\0\x61\0s\0t\0\x46\0M\0\0\0\x1\x1\0\0\0\xe\0\x44\0i\0s\0\x63\0o\0g\0s\0\0\0\x2\x1)

    [Controls]
    VolumeStep=1

    [DSP]
    ActiveChain=@ByteArray(\0\0\0Xx\xda\x63```d\x80\0\x10\xad\xc3\x90\xc6\x90\xf\x84\x95\f\x99\fy\fz\f)\f\xc5\f\x5@\xba\x98!\x1b(R\0\xa4\x33\x19r\x18R\x81r\xc9\f\xa9\x8c\x30\x9d\xcc@\xcc\a1\x81{\xc2\xff\xff\xff\x8f\x30\x30\x2\0\xdc\xbb\rq)

    [DirectoryBrowser]
    Mode=1
    Path=/home/ceri

    [Encoding]
    PreferredFallbackEncoding=

    [Engine]
    AudioOutput=ALSA|default
    CrossfadingValues="@Variant(\0\0\0\x7f\0\0\0\x12\x43rossfadingValues\0\0\0\x1,\0\0\x1,\0\x1\0\0\x2\xbc\0\0\x2\xbc\0\x1\0\0\0x\0\0\0x\0\x1)"
    DecoderState=@ByteArray(\0\0\0\0\0\0\0\x6\0\0\0\xe\0\x41\0r\0\x63\0h\0i\0v\0\x65\0\0\0\0\x1\0\0\0\f\0\x46\0\x46\0m\0p\0\x65\0g\0\0\0\x1\x1\0\0\0\xe\0S\0n\0\x64\0\x66\0i\0l\0\x65\0\0\0\x2\x1\0\0\0\xe\0O\0p\0\x65\0n\0M\0p\0t\0\0\0\x3\x1\0\0\0\x1c\0G\0\x61\0m\0\x65\0 \0M\0u\0s\0i\0\x63\0 \0\x45\0m\0u\0\0\0\x4\x1\0\0\0\x10\0R\0\x61\0w\0\x41\0u\0\x64\0i\0o\0\0\0\x5\x1)
    FFmpegAllExtensions=false
    FadingIntervals=@Invalid()
    FadingValues="@Variant(\0\0\0\x7f\0\0\0\rFadingValues\0\0\0\0x\0\0\0x\0\x1\0\0\0x\0\0\x1,\0\x1\0\0\x2\xbc\0\0\x2\xbc\0\0)"
    OutputVolume=0.3981071705534972
    ReaderProbeAllExtensions=m4a, m4b, mp4, mka, mkv
    ReaderState=@ByteArray(\0\0\0\0\0\0\0\a\0\0\0\xe\0\x41\0r\0\x63\0h\0i\0v\0\x65\0\0\0\0\x1\0\0\0\f\0T\0\x61\0g\0L\0i\0\x62\0\0\0\x1\x1\0\0\0\f\0\x46\0\x46\0m\0p\0\x65\0g\0\0\0\x2\x1\0\0\0\xe\0S\0n\0\x64\0\x66\0i\0l\0\x65\0\0\0\x3\x1\0\0\0\xe\0O\0p\0\x65\0n\0M\0p\0t\0\0\0\x4\x1\0\0\0\x1c\0G\0\x61\0m\0\x65\0 \0M\0u\0s\0i\0\x63\0 \0\x45\0m\0u\0\0\0\x5\x1\0\0\0\x10\0R\0\x61\0w\0\x41\0u\0\x64\0i\0o\0\0\0\x6\x1)

    [FileOps]
    ConfirmDelete=true
    DeleteEmptyFolders=false
    ImmediateDelete=false

    [Interface]
    ContextMenuTrackDisabledSections=Tracks.CopyDirectoryPath, Tracks.CopyLocation
    ContextMenuTrackLayout=Tracks.OpenFolder, Tracks.CopyLocation, Tracks.CopyDirectoryPath, Fooyin.Menu.Artwork, Fooyin.Menu.Tagging, FileOperations, Fooyin.Menu.Lyrics, Fooyin.Menu.Utilities, Fooyin.Menu.ReplayGain, Fooyin.Menu.Track.FinalSeparator, Tracks.OpenProperties
    LockSplitterHandles=false
    ShowTrayIcon=false
    SplitterHandles=false
    Style=

    [LastFM]
    IsEnabled=true
    SessionKey=
    Username=

    [Library]
    ExcludeTypes=cue
    ExternalExcludeTypes=@Invalid()
    ExternalRestrictTypes=@Invalid()
    MarkUnavailable=false
    MarkUnavailableOnStartup=false
    RestrictTypes=@Invalid()

    [LibraryTree]
    LibraryTreeGroupOverrides=@ByteArray(\0\0\0\x34x\xda\x63```d@`.\x6G\x86\x1c\x86$\x86R\x86\\ O\x88!\x9a\x41\x95!\x11.\xa2\xca\x10\xfb\x1f\b\0p\xd3\t )
    RowHeight=0

    [LibreFM]
    IsEnabled=true
    SessionKey=
    Username=

    [ListenBrainz]
    IsEnabled=true
    UserToken=

    [Lyrics]
    SourceState=@ByteArray(\0\0\0\0\0\0\0\a\0\0\0\x16\0L\0o\0\x63\0\x61\0l\0 \0\x46\0i\0l\0\x65\0s\0\0\0\0\x1\0\0\0\x1a\0M\0\x65\0t\0\x61\0\x64\0\x61\0t\0\x61\0 \0T\0\x61\0g\0s\0\0\0\x1\x1\0\0\0\f\0L\0R\0\x43\0L\0I\0\x42\0\0\0\x2\x1\0\0\0&\0N\0\x65\0t\0\x45\0\x61\0s\0\x65\0 \0\x43\0l\0o\0u\0\x64\0 \0M\0u\0s\0i\0\x63\0\0\0\x3\x1\0\0\0\x10\0Q\0Q\0 \0M\0u\0s\0i\0\x63\0\0\0\x4\x1\0\0\0\x16\0K\0u\0g\0o\0u\0 \0M\0u\0s\0i\0\x63\0\0\0\x5\x1\0\0\0\x14\0\x44\0\x61\0r\0k\0L\0y\0r\0i\0\x63\0s\0\0\0\x6\0)

    [NowPlayingOutput]
    Enabled=false

    [Playback]
    ShuffleAlbumsGroupScript=%album%

    [PlaybackQueue]
    AlternatingColours=false

    [Player]
    PlayMode=32
    SavePlaybackState=false

    [Playlist]
    AutoExport=false
    AutoExportPath=/home/ceri/.local/share/fooyin/playlists
    AutoExportRemove=true
    AutoExportSaveRemoved=false
    AutoExportType=m3u8
    CursorFollowsPlayback=false
    SaveActivePlaylistState=false
    SaveMetadata=false
    SavePathType=0
    SkipUnavailable=true

    [PlaylistOrganiser]
    Model=@ByteArray(\0\0\0$x\xda\x63`\x80\x3\x66 f\x2\x62\x46(\xad\f\xa5U\0\x2-\0R)
    State=@ByteArray(\0\0\0\0)

    [PlaylistTabs]
    ExpandToFill=false
    ShowAddButton=false

    [PlaylistWidget]
    AlternatingColours=false
    CurrentPreset=4
    Header=true
    PlaylistColumns=@ByteArray(\0\0\0Tx\xda\x63```d``\x10\x83\x62\x19\x6G\x86\"\x86\x12\x86L\x86\x62 \xa9\xc0\xa0\v\xc4!@^\tC\xe\x43*P^\x85\x41\x95!\x11I\x85*T\x8d*X\x4\xa2J\x15\0\x8b\x80\v\xe)
    Presets="@ByteArray(\0\0\x2\x18x\xda\x45\x91MN\xc3\x30\x14\x84\xa7\x82\x33\xb0\xce\"\x96\x8aT\xa1\xa6\b\xc4\xa2\x45\x62\xd7\x5\x62\x3\xacZ\x84\xdc\xa6?\x11%\r\x89\xc3\xdf)8\aG\xe3\x12\xf0\xd9I\x8b\xa3\xe7\x9f\xe7\x99y\xe3\x17I\x9d_\x86\xa4\x3\xe2\xb0\x8d#]i\xa3\x99j=+\xd2\x9d\x32\x39\xce\vn\xbe\x34\xd4R[\xe5\x64\x46\x1a\x93\xdb\xe8\x95\xd9\x81\x99\xcb\x82\xbe\xe1T\x13\x91\xae\x61\x46\xba\xe5.\xd5%\xbc\n\xcc'7)\xccs21\xdc\xad\xde\xc8\x94\xear\xcaP\x1e\xb0\x33\xe8\xec\xaa\x1b\xf5tO\xb5'\xc2\x63s\x14\xff\xbd\x1d\xf3\x35\x63\x8c~\xa9\x15\xf9\x91.\x94\xc0\x8a\xf6k\xa2\xbeN\xa9gT\xc0\xb4\xfa`\xcep\xe3\xf4\x88\x97\x1a\x9e\r\xfe\xfd\xab\x8cv\xa3\xd3\xae?(\xc4\x30-\xd8\x12\xd4Jk\xd0]\x94\x63\x1c\xd4hy\xef\x15\xbbY\xf0\x9e\xf2\x9e\x2\xc4:xOp\xd8\xd3Yp:\xd1\x94\x30z\t\xfd\xf1\x91Q\xd1\xe3\xdf\x89\x8a\x9b\xa9\x1e\xa8\x16\x31O\xd0\xcc\xc3\x1b\xbd\xa6\v\x1e\xe7t\xc1k\xe\xd0:iq&8o\xfe\x8e\x81\x35\f\xbd+\xa8n\xe9\x44\x42\xf\xfa\xbc\x1c\xac\xf9\xe\f\x83\x66\xe\xa3\xf1`\xd1um/\fj\xfb\xf1\a\xdb\xb7S,)"
    Scrollbar=true

    [RGScanner]
    AlbumGroupScript=%albumartist% - %date% - %album%
    Scanner=libebur128
    TruePeak=false

    [Scrobbling]
    ServicesData=@ByteArray(\0\0\0\x3\0\0\0\f\0L\0\x61\0s\0t\0\x46\0M\0\0\0\0\xe\0L\0i\0\x62\0r\0\x65\0\x46\0M\0\0\0\0\x18\0L\0i\0s\0t\0\x65\0n\0\x42\0r\0\x61\0i\0n\0z\0)

    [Searching]
    AutoSelect=false
    LibraryState="@ByteArray(eyJDb2x1bW5zIjoiODoxMzJ8M3wwOjJ8MXw3OjIiLCJHZW9tZXRyeSI6IkFkblF5d0FEQUFBQUFBTnNBQUFCaEFBQUJvOEFBQU9IQUFBRGJnQUFBYVlBQUFhTkFBQURoUUFBQUFBQUFBQUFDZ0FBQUFOdUFBQUJwZ0FBQm8wQUFBT0YiLCJIZWFkZXJTdGF0ZSI6IkFBQUFaWGphWTJCZ1lHVmdZTkJuWUdEVUJOSjJVTnFQQVNJT0FveEF6QVRFekVETUFoSzNYN2NqOEhXcjNBNzdHMkFxeUg1TDFVUDNkU0xWY1A3T21TQXdDNlNSNFQ4UUFBREd3Qm5EIiwiUHJlc2V0IjowLCJTaW5nbGVNb2RlIjpmYWxzZX0=)"
    PlaylistState="@ByteArray(eyJDb2x1bW5zIjoiODoxMzJ8M3wwOjJ8MXw3OjIiLCJHZW9tZXRyeSI6IkFkblF5d0FEQUFBQUFBRUpBQUFDa1FBQUJDd0FBQVNVQUFBQkN3QUFBck1BQUFRcUFBQUVrZ0FBQUFBQUFBQUFDZ0FBQUFFTEFBQUNzd0FBQkNvQUFBU1MiLCJIZWFkZXJTdGF0ZSI6IkFBQUFaWGphWTJCZ1lHVmdZTkJuWUdBRVlnWjdLTzNQQUJFSEFVWWdaZ0ppWmlCbUFZbmJyOXNSK0xwVmJvZjlEVEFWWkwrbDZxSDdPcEZxT0gvblRCQ1lCZExJOEI4SUFNdHNHZEU9IiwiUHJlc2V0IjowLCJTaW5nbGVNb2RlIjpmYWxzZX0=)"
    SearchMode=0
    SearchScript=[%artist%] [%title%] [%album%] [%albumartist%] [%performer%] [%composer%] [%genre%] [%comment%] [%filepath%]
    ShowAll=false

    [TagEditor]
    DontAskAgain=true
    State=@ByteArray(\0\0\0\xff\0\0\0\0\0\0\0\x1\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x2z\0\0\0\x2\0\0\x1\x1\0\0\0\0\0\0\0\0\0\0\0\0\x64\xff\xff\xff\xff\0\0\0\x84\0\0\0\0\0\0\0\x2\0\0\0\xe9\0\0\0\x1\0\0\0\0\0\0\x1\x91\0\0\0\x1\0\0\0\0\0\0\x3\xe8\0\0\0\0\x64\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1)

    [Tagging]
    SplitId3v23SemicolonSeparatedTags=true

    [Theme]
    CustomTheme=@Variant(\0\0\0\x7f\0\0\0\bFyTheme\0\0\0\0\x1\0\0\0\v\0\0\0\v\0\0\0\n\0\x43\0\x65\0r\0\x65\0s\0\0\0\0\x2\0\0\0\x5\0\0\0\t\x1\xff\xff\x1a\x1a\x1a\x1a\x1f\x1f\0\0\0\0\0\x5\0\0\0\n\x1\xff\xff\x1a\x1a\x1a\x1a\x1f\x1f\0\0\0\0\0\0)
    SavedThemes=@ByteArray(\0\0\0Mx\xda\x63```d\x80`n(\xe6\x62pfHe(\x2\xe2\x62 \x8f\x81\t\x88Y\x81\x98\x93\xf1\xff\x7f) \x90\x97\a\x89\x82\x85\xb8P\x85\x18\0\xe4\xb2\a~)

    [WaveBar]
    BarGap=0
    BarWidth=1
    CentreGap=0
    Colours=@Variant(\0\0\0\x7f\0\0\0\x19\x46ooyin::WaveBar::Colours\0\x1\0\0\0\0)
    CursorWidth=2
    Downmix=2
    MaxScale=1
    Mode=7
    NumSamples=4096
    ShowCursor=true
  '';
} else {}
