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
      Get.find<ResultController>().convertedText.value = result.value;
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
You are an AI summarizer. 
Summarize the following text in the same language as the input. 
Do NOT rephrase or rewrite the whole text. 
Only extract and compress the main points. 
The summary length must be around 30% of the original text length. 
If the input is long, write in 2-4 short sentences or bullet points. 
Always format the output in proper Markdown:
- Use "-" for bullet points
- Use **word** for bold emphasis
- No special symbols like "•"
Keep it concise and clear, no extra explanations. 

Text:  $text
""";
      case 1:
        return """
You are a paraphrasing tool.  
Take the input text and return the paraphrased version in the same language as the input.  
If the paraphrased text naturally requires **bold text** or bullet points, output it in proper Markdown format (so it can be rendered in Flutter Markdown).  
Keep the response concise and human-friendly, not mechanical.  
Do not remove or add formatting unless necessary.


Input text:
$text
""";
      case 2:
        return """
You are an AI Humanizer.  
Rewrite the following text in the same language as the input so it sounds naturally written by a human, not by AI.  

⚠️ Important Instructions:  
- Keep the original meaning fully intact.  
- Avoid robotic or repetitive wording.  
- Add natural flow, variation in sentence length, and casual readability.  
- Do not add phrases like "Here is the humanized text".  
- If the text has formatting (bullet points, bold, etc.), keep it in the output.  
- The output must look like genuine human writing, not AI-generated.  

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
