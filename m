From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] do not ignore attribute 'noreturn'...
Date: Mon, 14 Sep 2009 10:27:40 -0700
Message-ID: <70318cbf0909141027y69ddecc2y591ffb6aca300fca@mail.gmail.com>
References: <200908282330.08332.kdudka@redhat.com>
	 <70318cbf0908281444q735b7b9fm73f0fcbdbaeefa7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:34983 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbZINR1h (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Sep 2009 13:27:37 -0400
Received: by vws33 with SMTP id 33so530308vws.33
        for <linux-sparse@vger.kernel.org>; Mon, 14 Sep 2009 10:27:41 -0700 (PDT)
In-Reply-To: <70318cbf0908281444q735b7b9fm73f0fcbdbaeefa7b@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Aug 28, 2009 at 2:44 PM, Christopher Li <sparse@chrisli.org> wrote:
> Yes, no return is kind of useful. I think we need to do some thing about the
> MOD_XXX eventually. It is very easy to run out of bits there.
>
Ah, the MOD_NORETURN is bigger than size of long in 32 bit systems.
I just get a few warning from GCC.

I just relocate the MOD_NORETURN bits.

Chris

diff --git a/symbol.h b/symbol.h
index 80ef363..9f5a32f 100644
--- a/symbol.h
+++ b/symbol.h
@@ -214,10 +214,10 @@ struct symbol {
 #define MOD_SAFE       0x8000000       // non-null/non-trapping pointer

 #define MOD_USERTYPE   0x10000000
+#define MOD_NORETURN   0x20000000
 #define MOD_EXPLICITLY_SIGNED  0x40000000
 #define MOD_BITWISE    0x80000000

-#define MOD_NORETURN   0x100000000

 #define MOD_NONLOCAL   (MOD_EXTERN | MOD_TOPLEVEL)
 #define MOD_STORAGE    (MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD
