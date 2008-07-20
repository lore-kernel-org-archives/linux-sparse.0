From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Handling of -specs in cgcc
Date: Sun, 20 Jul 2008 22:28:35 +0400
Message-ID: <f19298770807201128s3688702fm3f8b2f42edb198fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:48209 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYGTS2g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 Jul 2008 14:28:36 -0400
Received: by wa-out-1112.google.com with SMTP id j37so608495waf.23
        for <linux-sparse@vger.kernel.org>; Sun, 20 Jul 2008 11:28:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: welinder@troll.com

Hi.

Looking at cgcc, it seems that this code does not actually work,

26     if (/^-specs=(.*)$/) {
27         $check .= &add_specs ($1);
28         $has_specs = 1;
29         next;
30     }

because add_specs() never expects to see a file name, and
the option is removed from the argument list and never passed
to gcc. As it seems that this feature never worked, probably
we could simply remove it? Morten?

---

    Pass -specs to gcc without trying (and failing) to decompose it.

    Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>

diff --git a/cgcc b/cgcc
index 4fab530..a1d4f66 100755
--- a/cgcc
+++ b/cgcc
@@ -23,12 +23,6 @@ foreach (@ARGV) {
     $m32 = 1 if /^-m32$/;
     $m64 = 1 if /^-m64$/;

-    if (/^-specs=(.*)$/) {
-       $check .= &add_specs ($1);
-       $has_specs = 1;
-       next;
-    }
