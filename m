From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: [PATCH] Updated __nocast vs __bitwise documentation
Date: Thu, 10 May 2012 12:24:28 +0530
Message-ID: <CABG-yt2XiduTbyN+tm++Fw1_s9_QvjFy60=5a--tScMwDT443A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50326 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446Ab2EJGya (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 02:54:30 -0400
Received: by wgbdr13 with SMTP id dr13so995322wgb.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 May 2012 23:54:28 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I have updated the sparse.1 man page including the __bitwise
relevant content, and created Documentation/sparse.txt with the
complete comparison between __nocast vs __bitwise.

Signed-off-by: Shakthi Kannan <shakthimaan@gmail.com>
---
 Documentation/sparse.txt |   39 +++++++++++++++++++++++++++++++++++++++
 sparse.1                 |   14 +++++++++++++-
 2 files changed, 52 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/sparse.txt

diff --git a/Documentation/sparse.txt b/Documentation/sparse.txt
new file mode 100644
index 0000000..37e8916
--- /dev/null
+++ b/Documentation/sparse.txt
@@ -0,0 +1,39 @@
+Sparse
+~~~~~~
+
+__nocast vs __bitwise:
+
+__nocast warns about explicit or implicit casting to different types.
+
+HOWEVER, it doesn't consider two 32-bit integers to be different
+types, so a __nocast 'int' type may be returned as a regular 'int'
+type and then the __nocast is lost.
+
+So "__nocast" on integer types is usually not that powerful. It just
+gets lost too easily. It's more useful for things like pointers. It
+also doesn't warn about the mixing: you can add integers to __nocast
+integer types, and it's not really considered anything wrong.
+
+__bitwise ends up being a "stronger integer separation". That one
+doesn't allow you to mix with non-bitwise integers, so now it's much
+harder to lose the type by mistake.
+
+So the basic rule is:
+
+ - "__nocast" on its own tends to be more useful for *big* integers
+that still need to act like integers, but you want to make it much
+less likely that they get truncated by mistake. So a 64-bit integer
+that you don't want to mistakenly/silently be returned as "int", for
+example. But they mix well with random integer types, so you can add
+to them etc without using anything special. However, that mixing also
+means that the __nocast really gets lost fairly easily.
+
+ - "__bitwise" is for *unique types* that cannot be mixed with other
+types, and that you'd never want to just use as a random integer (the
+integer 0 is special, though, and gets silently accepted iirc - it's
+kind of like "NULL" for pointers). So "gfp_t" or the "safe endianness"
+types would be __bitwise: you can only operate on them by doing
+specific operations that know about *that* particular type.
+
+Generally, you want __bitwise if you are looking for type safety.
+"__nocast" really is pretty weak.
diff --git a/sparse.1 b/sparse.1
index bde6b6d..ae85b54 100644
--- a/sparse.1
+++ b/sparse.1
@@ -53,7 +53,19 @@ arithmetic operations other than bitwise
operations, and on any conversion of
 one restricted type into another, except via a cast that includes
 \fB__attribute__((force))\fR.

-Sparse does not issue these warnings by default.
+__bitwise ends up being a "stronger integer separation". That one
+doesn't allow you to mix with non-bitwise integers, so now it's much
+harder to lose the type by mistake.
+
+__bitwise is for *unique types* that cannot be mixed with other
+types, and that you'd never want to just use as a random integer (the
+integer 0 is special, though, and gets silently accepted iirc - it's
+kind of like "NULL" for pointers). So "gfp_t" or the "safe endianness"
+types would be __bitwise: you can only operate on them by doing
+specific operations that know about *that* particular type.
+
+Generally, you want bitwise if you are looking for type safety. Sparse
+does not issue these warnings by default.
 .
 .TP
 .B \-Wcast\-to\-as
-- 
1.7.7.6
