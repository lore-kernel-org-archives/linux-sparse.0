From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sindex: avoid a warning with 'case -1:'
Date: Sun,  5 Jul 2020 01:54:53 +0200
Message-ID: <20200704235453.7756-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGDXzA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 19:55:00 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3D1C061794
        for <linux-sparse@vger.kernel.org>; Sat,  4 Jul 2020 16:55:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so24736349edz.12
        for <linux-sparse@vger.kernel.org>; Sat, 04 Jul 2020 16:55:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When parsing the format, there is a 'case -1:' which:
* seems to be there only for the following label (but mixing
  labels with cases, like here, is OK).
* on architectures where chars are unsigned, the compiler complains:
	warning: case label value is less than minimum value for type

So, remove the unneeded 'case -1:' and use an explicit 'default:'
to catch invalid formats. Also, align the label with the cases,
it looks nicer so.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sindex.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sindex.c b/sindex.c
index ea092a4a434b..22836a957213 100644
--- a/sindex.c
+++ b/sindex.c
@@ -970,8 +970,8 @@ static int search_query_callback(void *data, int argc, char **argv, char **colna
 					print_file_line(argv[0], atoi(argv[1]));
 					fmt++;
 					break;
-				case -1:
-print_string:
+
+				print_string:
 					if (n) {
 						printf("%.*s", n, buf);
 						n = 0;
@@ -979,6 +979,9 @@ print_string:
 					printf("%s", argv[colnum]);
 					fmt++;
 					break;
+				default:
+					break;
+
 			}
 
 			if (pos == fmt)
-- 
2.27.0
