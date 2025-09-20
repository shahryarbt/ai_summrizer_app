import 'dart:developer';

import 'package:ai_text_summrizer/view/result_view/result_view_screen.dart';
import 'package:ai_text_summrizer/view_model/result_controller/result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_ai/firebase_ai.dart';

class ApiToolController extends GetxController {
  var result = "".obs;
  var isLoading = false.obs;

  final TextEditingController inputTextcontroller = TextEditingController();

  // 🔹 Summarize function
  Future<void> summarize(String text, int index) async {
    if (text.isEmpty) return;

    try {
      isLoading.value = true;
      result.value = "";
      log('Requesting to Gemini');

      final model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash',
      );

      // Get prompt from separate function
      String prompt = getPrompt(text, index);

      final response = await model.generateContent([Content.text(prompt)]);
      result.value = response.text ?? "No response!";

      Get.find<ResultController>().originalText.value = text;
      Get.find<ResultController>().tabIndex.value = 0;
      Get.find<ResultController>().humanizedText.value = result.value;
      inputTextcontroller.text = '';

      Get.off(() => ResultScreenView(index: index));
      log('Result generated');
    } catch (e) {
      result.value = "Error: $e";
      log('Error');
    } finally {
      isLoading.value = false;
    }
  }

  // 🔹 Separate function for index-based prompt
  String getPrompt(String text, int index) {
    switch (index) {
      case 0:
        return """
   You are a text humanizer tool. 
Your job is to take the input text, detect its language, and rewrite it in a natural, human-like style without changing the meaning. 

Rules:
1. Keep the response in the same language as the input.
2. Preserve or improve formatting using Markdown (headings, bullet points, bold, italics) if it improves readability.
3. Do not add any explanations or meta text like "Here’s the result". Only return the final rewritten text.

Input text:
 
$text
""";
      case 1:
        return """
You are an AI paraphraser.
Rephrase the input text creatively while keeping the original message intact.

Input text:
$text
""";
      case 2:
        return """
You are a professional editor.
Improve the clarity, flow, and grammar of the text without changing meaning.

Input text:
$text
""";
      default:
        return """
You are a text humanizer tool. 
Rewrite the input text naturally.

Input text:
$text
""";
    }
  }
}
