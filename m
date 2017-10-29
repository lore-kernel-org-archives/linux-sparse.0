From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] llvm fixes
Date: Mon, 30 Oct 2017 07:31:28 +0800
Message-ID: <CANeU7QmSeq8x4D3KK4_qkfjzb1T+4J=bJsnKNggBZrh6wC7n8Q@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:49078 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdJ2Xb3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Oct 2017 19:31:29 -0400
Received: by mail-yw0-f176.google.com with SMTP id q1so10042157ywh.5
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 16:31:29 -0700 (PDT)
In-Reply-To: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Sep 18, 2017 at 5:51 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Chris,
>
> Please, pull these patches for master.

Ah, I can't find the exact corresponding patch series in the email.
So I will just comment from the git change.
=========quote===========
commit ae7fd3b06c225fd8faf67c3e20db07b64eca7fc3
 don't output value of anonymous symbol's pointer

    The value of this pointer is of no use unless you're
    using a debugger (or just to see if two things are
    identical or not) and it's presence produces noise
    when comparing the output of two runs for testing.

    Change this by issuing it only if 'verbose' is set.
diff --git a/linearize.c b/linearize.c
index 42d1680..b69f838 100644
--- a/linearize.c
+++ b/linearize.c
@@ -120,7 +120,7 @@ const char *show_pseudo(pseudo_t pseudo)
                        break;
                }
                expr = sym->initializer;
-               snprintf(buf, 64, "<anon symbol:%p>", sym);
+               snprintf(buf, 64, "<anon symbol:%p>", verbose ? sym : NULL);
=======================================================

Very trivial feed back:

I think it is better not print out the %p for NULL.
Just skip the %p if not verbose was set.

BTW, I understand you are reluctant to make trivial change to very
old series of branch. That make sense.

In that case, I can make a topic branch to track the feedback and fix up
as incremental change. Then integrate that branch when all the feedback
settle down. I don't mind writing some feedback patches myself if
you prefer.

Thanks

Chris
