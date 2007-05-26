From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [RFC] infinite loop in free_preprocessor_line()
Date: Sat, 26 May 2007 04:24:38 +0400
Message-ID: <20070526002437.GB5786@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:38682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbXEZAUe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 20:20:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1240542ugf
        for <linux-sparse@vger.kernel.org>; Fri, 25 May 2007 17:20:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

While running if-2.c from gcc testsuite sparse goes into infinite loop in
free_preprocessor_line().

Trimmed down test-case is

	#if 1
	#if

(two lines)

--- a/pre-process.c
+++ b/pre-process.c
@@ -763,11 +763,11 @@ out:
 
 static int free_preprocessor_line(struct token *token)
 {
-	do {
+	while (token_type(token) != TOKEN_EOF) {
 		struct token *free = token;
 		token = token->next;
 		__free_token(free);
-	} while (token_type(token) != TOKEN_EOF);
+	};
 	return 1;
 }
 
