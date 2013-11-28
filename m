From: Franz Schrober <franzschrober@gmail.com>
Subject: [PATCHv2 1/5] Revert "Update the information in README about using the library."
Date: Thu, 28 Nov 2013 11:16:18 +0100
Message-ID: <1385633782-775-2-git-send-email-franzschrober@gmail.com>
References: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:50105 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3K1KQx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Nov 2013 05:16:53 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so3680206bkz.39
        for <linux-sparse@vger.kernel.org>; Thu, 28 Nov 2013 02:16:52 -0800 (PST)
In-Reply-To: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: jw+debian@jameswestby.net, sparse@chrisli.org, franzschrober@gmail.com, Franz Schrober <franzschrober@yahoo.de>

From: Franz Schrober <franzschrober@yahoo.de>

James Westby is the only person not reacting when asking him about the MIT
license change over email or social media. So he has to count as not accepting
and reverting his contributions is the only way to to avoid possible legal
problems. The contributions can be re-added later when they are rewritten from
scratch.

This reverts commit 34ac7df96dd9609d684b0c949a52bc07ab1fd8b5.

Cc: James Westby <jw+debian@jameswestby.net>
Signed-off-by: Franz Schrober <franzschrober@yahoo.de>
---
 README | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 63f752b..a731a82 100644
--- a/README
+++ b/README
@@ -47,22 +47,35 @@ requires the information.
 
 This means that a user of the library will literally just need to do
 
-  struct string_list *filelist = NULL;
-  char *file;
+	struct token *token;
+	int fd = open(filename, O_RDONLY);
+	struct symbol_list *list = NULL;
 
-  action(sparse_initialize(argc, argv, filelist));
+	if (fd < 0)
+		exit_with_complaint();
 
-  FOR_EACH_PTR_NOTAG(filelist, file) {
-    action(sparse(file));
-  } END_FOR_EACH_PTR_NOTAG(file);
+	// Initialize parse symbols
+	init_symbols();
+
+	// Tokenize the input stream
+	token = tokenize(filename, fd, NULL);
+
+	// Pre-process the stream
+	token = preprocess(token);
+
+	// Parse the resulting C code
+	translation_unit(token, &list);
+
+	// Evaluate the types now if we want to
+	// Or leave it until later.
+	symbol_iterate(list, evaluate_symbol, NULL);
 
 and he is now done - having a full C parse of the file he opened.  The
 library doesn't need any more setup, and once done does not impose any
 more requirements.  The user is free to do whatever he wants with the
 parse tree that got built up, and needs not worry about the library ever
 again.  There is no extra state, there are no parser callbacks, there is
-only the parse tree that is described by the header files. The action
-function takes a pointer to a symbol_list and does whatever it likes with it.
+only the parse tree that is described by the header files. 
 
 The library also contains (as an example user) a few clients that do the
 preprocessing, parsing and type evaluation and just print out the
-- 
1.8.4.4

