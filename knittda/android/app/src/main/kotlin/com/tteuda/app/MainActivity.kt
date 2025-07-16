package com.tteuda.app

import android.content.Intent
import android.graphics.Bitmap // ✅ 이거 꼭 추가!
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Environment
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.knittda/image_saver"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "saveImage") {
                val byteArray = call.argument<ByteArray>("bytes")
                if (byteArray != null) {
                    val success = saveImage(byteArray)
                    result.success(success)
                } else {
                    result.error("NO_BYTES", "이미지 바이트가 없습니다", null)
                }
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
}
