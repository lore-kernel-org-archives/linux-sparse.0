From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Re: [PATCH] Updated __nocast vs __bitwise documentation
Date: Tue, 15 May 2012 15:36:36 +0530
Message-ID: <CABG-yt1LHD80A=-oRC7MZf4a__WEn-MeTyzaYTc9kGzWkWcVVQ@mail.gmail.com>
References: <CABG-yt2XiduTbyN+tm++Fw1_s9_QvjFy60=5a--tScMwDT443A@mail.gmail.com>
	<CANeU7QkQtZ9x8xQFWDVPu2tCizWrvmF8EhZE84d6Nok58tnWCQ@mail.gmail.com>
	<CABG-yt2yVwF76vHitm-KzKLV4kQ205hEMTCeRcsJF9-doWvW6w@mail.gmail.com>
	<20120510182440.GA19991@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58013 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757032Ab2EOKGi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 May 2012 06:06:38 -0400
Received: by lahd3 with SMTP id d3so4004310lah.19
        for <linux-sparse@vger.kernel.org>; Tue, 15 May 2012 03:06:36 -0700 (PDT)
In-Reply-To: <20120510182440.GA19991@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

Hi,

I am resending the patch with the reference to Linus' email added to
Documentation/sparse.txt.

Thanks for all your feedback and replies.

Signed-off-by: Shakthi Kannan <shakthimaan@gmail.com>
---
 Documentation/sparse.txt |   45 +++++++++++++++++++++++++++++++++++++++++++++
 sparse.1                 |   14 +++++++++++++-
 2 files changed, 58 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/sparse.txt

diff --git a/Documentation/sparse.txt b/Documentation/sparse.txt
new file mode 100644
index 0000000..1ee3b39
--- /dev/null
+++ b/Documentation/sparse.txt
@@ -0,0 +1,45 @@
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
+
+Reference:
+
+* Linus' e-mail about __nocast vs __bitwise:
+
+  http://article.gmane.org/gmane.linux.kernel.mm/75784
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
