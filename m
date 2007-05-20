From: Damien Lespiau <damien.lespiau@gmail.com>
Subject: [PATCH] Change sparse homepage in ctags headers.
Date: Sun, 20 May 2007 23:59:06 +0200
Message-ID: <1179698346505-git-send-email-damien.lespiau@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp20.orange.fr ([80.12.242.26]:18824 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757024AbXETV7J (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 17:59:09 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Damien Lespiau <damien.lespiau@gmail.com>


Yup, sparse homepage changed.

Signed-off-by: Damien Lespiau <damien.lespiau@gmail.com>
---
 ctags.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ctags.c b/ctags.c
index bdddcf7..cccee0a 100644
--- a/ctags.c
+++ b/ctags.c
@@ -45,7 +45,7 @@ static void show_tag_header(FILE *fp)
 	fprintf(fp, "!_TAG_FILE_SORTED\t0\t/0=unsorted, 1=sorted, 2=foldcase/\n");
 	fprintf(fp, "!_TAG_PROGRAM_AUTHOR\tChristopher Li\t/sparse@chrisli.org/\n");
 	fprintf(fp, "!_TAG_PROGRAM_NAME\tSparse Ctags\t//\n");
-	fprintf(fp, "!_TAG_PROGRAM_URL\thttp://kernel.org/pub/linux/kernel/people/josh/sparse/\t/official site/\n");
+	fprintf(fp, "!_TAG_PROGRAM_URL\thttp://www.kernel.org/pub/software/devel/sparse/\t/official site/\n");
 	fprintf(fp, "!_TAG_PROGRAM_VERSION\t0.01\t//\n");
 }
 
-- 
1.5.2.rc3.87.g404fd
