From: =?UTF-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>
Subject: Re: [PATCH 1/2] compiler/gcc5: Remove quirk for asm_volatile_goto()
Date: Wed, 15 Apr 2015 11:08:43 +0200
Message-ID: <552E2A9B.7030605@suse.cz>
References: <552CDCF0.3050401@suse.cz> <CA+55aFzcyHJfP95EDZxOL7iCXg3HL42XqnMFoHFOSMhyGaKtMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000902010403090201080709"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57649 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbbDOJIq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Apr 2015 05:08:46 -0400
In-Reply-To: <CA+55aFzcyHJfP95EDZxOL7iCXg3HL42XqnMFoHFOSMhyGaKtMg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Chris Li <sparse@chrisli.org>

This is a multi-part message in MIME format.
--------------000902010403090201080709
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/14/2015 07:58 PM, Linus Torvalds wrote:
> On Tue, Apr 14, 2015 at 2:25 AM, Martin Liška <mliska@suse.cz> wrote:
>> Remove comments related to GCC 4.x branch and workaround for
>> asm_volatile_goto which is fixed in GCC 5 release.
>
> How sure are you that it is *really* fixed? Because it wasn't, last we saw.
>
> It was originally claimed to be fixed in 4.8.2, but that turned out to
> be wrong. See commit 5631b8fba640 ("compiler/gcc4+: Remove inaccurate
> comment about 'asm goto' miscompiles"), and
>
>      https://lkml.org/lkml/2014/2/12/817
>
> which shows that the bugzilla you reference is at the very least
> unreliable. Apparently the gcc test-case didn't catch all the
> problems.
>
> IOW, just leave the workaround. It has no actual cost, and the gcc bug
> wasn't obviously fully fixed. There are apparently very few users of
> "asm goto" (probably partly because of the limitations of it,
> particularly the "no outputs").
>
>                             Linus
>

Hello Linus.

Agree with you that a bit more defensive approach is reasonable, mainly because
of the actual cost.

Thus, I send updated version of the patch which just removes unrelated GCC 4.x branch
comments.

Thanks,
Martin


--------------000902010403090201080709
Content-Type: text/x-patch;
 name="0001-compiler-gcc5-Remove-comments-related-to-GCC-4.x-bra.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-compiler-gcc5-Remove-comments-related-to-GCC-4.x-bra.pa";
 filename*1="tch"

From 9db00c78af98a26685d3e0034d26962167441070 Mon Sep 17 00:00:00 2001
From: mliska <mliska@suse.cz>
Date: Wed, 15 Apr 2015 10:55:14 +0200
Subject: [PATCH 1/2] compiler/gcc5: Remove comments related to GCC 4.x branch.

Signed-off-by: Martin Liska  <mliska@suse.cz>
---
 include/linux/compiler-gcc5.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/compiler-gcc5.h b/include/linux/compiler-gcc5.h
index efee493..abb03b8 100644
--- a/include/linux/compiler-gcc5.h
+++ b/include/linux/compiler-gcc5.h
@@ -12,10 +12,6 @@
    like BUG(), printk(), panic() etc. [but let's keep them for now for
    older compilers]
 
-   Early snapshots of gcc 4.3 don't support this and we can't detect this
-   in the preprocessor, but we can live with this because they're unreleased.
-   Maketime probing would be overkill here.
--------------000902010403090201080709--
