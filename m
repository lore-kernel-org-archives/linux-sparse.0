From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Tue, 23 Jan 2018 15:38:35 -0800
Message-ID: <CANeU7QkQXoSO+wDDMUfsFuuhavt+YLZXiCCKuqNLTuq3aMc3rQ@mail.gmail.com>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
 <CANeU7QkL3UrbsHRVhwXcAas7cBOTVyzHsGzZSKr0zAiEBFAWpg@mail.gmail.com> <2386463a-5601-78d5-6827-5f03321e4adb@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:42274 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeAWXig (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 23 Jan 2018 18:38:36 -0500
Received: by mail-qt0-f177.google.com with SMTP id c2so5967040qtn.9
        for <linux-sparse@vger.kernel.org>; Tue, 23 Jan 2018 15:38:36 -0800 (PST)
In-Reply-To: <2386463a-5601-78d5-6827-5f03321e4adb@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jan 23, 2018 at 10:20 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I guess that I don't understand the interplay between $V and $quiet and why
> have both of them.
>

It seems that $quiet is just invert of $V, which introduce in
the following two commits by Luc.

commit: ee43fc784e52e3ee9e1b45da1be5193ea3b64334
Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Mon Feb 13 00:29:04 2017 +0100

    testsuite: quieter error reporting for 'known-to-fail'

commit: d2a7009a78effb2a8ac867de9240c4a89d181f5d
Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Mon Feb 13 00:29:03 2017 +0100

    testsuite: allow quieter error reporting


> Are you suggesting that $quiet should be initialized by default like this:
> (just drop the $must_fail part)
>
>> quiet=0
>> [ $V -eq 0 ] && quiet=1


yes, I was thinking some thing like this,
but I haven't give it a lot of test.

>diff --git a/validation/test-suite b/validation/test-suite
index cf151a3..5e10942 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -31,6 +31,7 @@ known_ko_tests=0

 # defaults to not verbose
 [ -z "$V" ] && V=0
+[ $V -eq 0 ] && quiet=1 || quiet=0

 ##

Chris
