From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] let "compile" not crash on bools
Date: Mon, 21 Nov 2016 04:49:33 +0100
Message-ID: <20161121034933.34194-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35338 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbcKUDtq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Nov 2016 22:49:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so23432059wme.2
        for <linux-sparse@vger.kernel.org>; Sun, 20 Nov 2016 19:49:45 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Jeff Layton <jlayton@redhat.com>

"compile" & "compile-i386" have never been adapted to use
bits_to_bytes() and crash when processing a bool because
it doesn't find a suffix for 1-bit instructions ('b', 'w', 'l', 'q').

Sprinkling a dozen "bit_to_bytes()" and adjusting a few shifts
would fix it but letting bits_in_bool be equal to 8 is much simpler.

Note: with this patch, "compile" crashes 'only' 25 times when used
on the testsuite files, instead of 27 without it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC: Jeff Layton <jlayton@redhat.com>
---
 compile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compile.c b/compile.c
index 48f9c700..eeb996ab 100644
--- a/compile.c
+++ b/compile.c
@@ -56,6 +56,8 @@ int main(int argc, char **argv)
 	char *file;
 	struct string_list *filelist = NULL;
 
+	bits_in_bool = 8;
+
 	clean_up_symbols(sparse_initialize(argc, argv, &filelist));
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		struct symbol_list *list;
-- 
2.10.2

