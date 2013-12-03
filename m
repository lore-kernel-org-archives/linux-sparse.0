From: Franz Schrober <franzschrober@gmail.com>
Subject: [PATCH] Update the information in README about using the library.
Date: Tue,  3 Dec 2013 09:26:05 +0100
Message-ID: <1386059165-3812-1-git-send-email-franzschrober@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:46155 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab3LCI0T (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Dec 2013 03:26:19 -0500
Received: by mail-ee0-f45.google.com with SMTP id d49so1247642eek.18
        for <linux-sparse@vger.kernel.org>; Tue, 03 Dec 2013 00:26:18 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, James Westby <james@jameswestby.net>, Franz Schrober <franzschrober@gmail.com>

From: James Westby <james@jameswestby.net>

Changes in the library have left the README giving out of date information
on how to intialise the library and get the symbols out of it. Update the
documentation to match the latest functions.

Signed-off-by: James Westby <james@jameswestby.net>
Signed-off-by: Franz Schrober <franzschrober@gmail.com>
---
This patch was already submitted by James Westby and had to be reverted again
after he didn't responded in the 4 year relicense process. Now he accepted the
change to MIT license and I just resubmit it for him. So it is a revert for the
revert 01b00f59f2a6aba6b623c0a68827938c1f570877 ('Revert "Update the
information in README about using the library."')

Sorry for the inconveniences.

 README | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/README b/README
index a731a82..033ae15 100644
--- a/README
+++ b/README
@@ -47,35 +47,22 @@ requires the information.
 
 This means that a user of the library will literally just need to do
 
-	struct token *token;
-	int fd = open(filename, O_RDONLY);
-	struct symbol_list *list = NULL;
+  struct string_list *filelist = NULL;
+  char *file;
 
-	if (fd < 0)
-		exit_with_complaint();
+  action(sparse_initialize(argc, argv, filelist));
 
-	// Initialize parse symbols
-	init_symbols();
-
-	// Tokenize the input stream
-	token = tokenize(filename, fd, NULL);
-
-	// Pre-process the stream
-	token = preprocess(token);
-
-	// Parse the resulting C code
-	translation_unit(token, &list);
