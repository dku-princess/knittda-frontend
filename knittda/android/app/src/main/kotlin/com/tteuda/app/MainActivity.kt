package com.tteuda.app

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Environment
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.knittda/image_saver"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "saveImage" -> {
                    val byteArray = call.argument<ByteArray>("bytes")
                    if (byteArray != null) {
                        val success = saveImage(byteArray)
                        result.success(success)
                    } else {
                        result.error("NO_BYTES", "이미지 바이트가 없습니다", null)
                    }
                }

                "shareKakao" -> {
                    val resultBool = shareToKakao()
                    result.success(resultBool)
                }

                "shareImage" -> {
                    val path = call.argument<String>("path")
                    if (path != null) {
                        shareImage(File(path))
                        result.success(true)
                    } else {
                        result.error("NO_PATH", "이미지 경로가 없습니다", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun saveImage(bytes: ByteArray): Boolean {
        return try {
            val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
            val dir = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), "knittda")
            if (!dir.exists()) dir.mkdirs()

            val file = File(dir, "report_${System.currentTimeMillis()}.png")
            val out = FileOutputStream(file)
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, out)
            out.flush()
            out.close()

            sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(file)))
            true
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }

    private fun shareToKakao(): Boolean {
        return try {
            val dir = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), "knittda")
            val files = dir.listFiles()?.filter { it.name.startsWith("report_") } ?: return false
            val latestFile = files.maxByOrNull { it.lastModified() } ?: return false

            val uri = FileProvider.getUriForFile(this, "$packageName.fileprovider", latestFile)

            val shareIntent = Intent(Intent.ACTION_SEND).apply {
                type = "image/png"
                putExtra(Intent.EXTRA_STREAM, uri)
                `package` = "com.kakao.talk"
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }

            startActivity(shareIntent)
            true
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }

    private fun shareImage(file: File) {
        val uri: Uri = FileProvider.getUriForFile(this, "$packageName.fileprovider", file)
        val shareIntent = Intent(Intent.ACTION_SEND).apply {
            type = "image/*"
            putExtra(Intent.EXTRA_STREAM, uri)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        startActivity(Intent.createChooser(shareIntent, "이미지 공유"))
    }
}