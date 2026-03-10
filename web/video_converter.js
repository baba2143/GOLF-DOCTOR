// FFmpeg WASM Video Converter (Local Version)
console.log('=== video_converter.js loading ===');

let ffmpeg = null;
let ffmpegLoaded = false;
let conversionProgress = 0;
let lastLoggedProgress = -1;

// Initialize FFmpeg with local files
window.initFFmpegForDart = async function() {
  console.log('initFFmpegForDart called');
  if (ffmpegLoaded) {
    console.log('FFmpeg already loaded');
    return true;
  }

  try {
    console.log('Checking FFmpeg globals...');
    console.log('window.FFmpegWASM:', typeof window.FFmpegWASM);
    console.log('window.FFmpegUtil:', typeof window.FFmpegUtil);

    if (typeof FFmpegWASM === 'undefined' || !FFmpegWASM.FFmpeg) {
      console.error('FFmpegWASM.FFmpeg not available');
      return false;
    }

    const { FFmpeg } = FFmpegWASM;
    ffmpeg = new FFmpeg();
    console.log('FFmpeg instance created');

    ffmpeg.on('progress', ({ progress }) => {
      conversionProgress = Math.round(progress * 100);
      // Only log every 10%
      const tenPercent = Math.floor(conversionProgress / 10) * 10;
      if (tenPercent > lastLoggedProgress) {
        lastLoggedProgress = tenPercent;
        console.log('Conversion progress: ' + conversionProgress + '%');
      }
    });

    // Disable verbose FFmpeg logs
    ffmpeg.on('log', ({ message }) => {
      // Only log important messages
      if (message.includes('error') || message.includes('Error')) {
        console.log('FFmpeg: ' + message);
      }
    });

    // Load FFmpeg core from LOCAL files (same origin)
    console.log('Loading FFmpeg core from local files...');
    await ffmpeg.load({
      coreURL: '/ffmpeg/ffmpeg-core.js',
      wasmURL: '/ffmpeg/ffmpeg-core.wasm',
    });

    ffmpegLoaded = true;
    console.log('FFmpeg loaded successfully!');
    return true;
  } catch (error) {
    console.error('Failed to load FFmpeg:', error);
    return false;
  }
};

// Convert video to MP4
window.convertVideoForDart = async function(videoBlob, fileName) {
  console.log('convertVideoForDart called, fileName:', fileName);

  try {
    if (!ffmpegLoaded) {
      console.log('FFmpeg not loaded, initializing...');
      const loaded = await window.initFFmpegForDart();
      if (!loaded) {
        throw new Error('FFmpeg not available');
      }
    }

    if (typeof FFmpegUtil === 'undefined' || !FFmpegUtil.fetchFile) {
      throw new Error('FFmpegUtil.fetchFile not available');
    }

    const { fetchFile } = FFmpegUtil;

    console.log('Writing input file...');
    const inputData = await fetchFile(videoBlob);
    await ffmpeg.writeFile(fileName, inputData);

    console.log('Starting conversion to MP4...');
    await ffmpeg.exec([
      '-i', fileName,
      '-vcodec', 'libx264',
      '-pix_fmt', 'yuv420p',
      '-acodec', 'aac',
      '-movflags', '+faststart',
      '-preset', 'fast',
      '-crf', '23',
      'output.mp4'
    ]);

    console.log('Reading output...');
    const data = await ffmpeg.readFile('output.mp4');

    // Cleanup
    await ffmpeg.deleteFile(fileName);
    await ffmpeg.deleteFile('output.mp4');

    console.log('Conversion completed! Output size:', data.length);
    return data;
  } catch (error) {
    console.error('Conversion error:', error);
    throw error;
  }
};

window.getConversionProgressForDart = function() {
  return conversionProgress;
};

window.resetConversionProgressForDart = function() {
  conversionProgress = 0;
  lastLoggedProgress = -1;
};

// Legacy API
window.VideoConverter = {
  initFFmpeg: window.initFFmpegForDart,
  convertToMp4: window.convertVideoForDart,
  getConversionProgress: window.getConversionProgressForDart,
  resetConversionProgress: window.resetConversionProgressForDart
};

console.log('VideoConverter ready (local mode)');
