From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] patches for -rc2
Date: Fri, 16 Jun 2017 10:27:44 -0700
Message-ID: <CANeU7Q=4Uu-64ZX+q2=gchz3owTwkGM85Zchi=jHgEFC22EW5A@mail.gmail.com>
References: <20170615043455.3ke55dyo6v4vpebo@ltop.local> <CANeU7QmtKh5LxJVvaFVGy7KApXTtzW+-G19LogbEZH=kTNLHAQ@mail.gmail.com>
 <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:35225 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFPR1p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 13:27:45 -0400
Received: by mail-it0-f46.google.com with SMTP id m62so38688122itc.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 10:27:45 -0700 (PDT)
In-Reply-To: <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 15, 2017 at 1:20 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Please, drop what you have already pulled and take the
> following instead.

Here is the feed back for "finer control over error vs. warnings"


+#define        ERROR_CURR_PHASE        (1 << 0)
+#define        ERROR_PREV_PHASE        (1 << 1)
+extern int has_error;

The current phase vs previous phase define is a bit messy to
maintain when you advance to next phase. Currently your
patch does:

+
+       if (has_error & ERROR_CURR_PHASE)
+               has_error = ERROR_PREV_PHASE;

I purpose each different phase/stage we have a dedicate bits.
#define PHASE_PARSING (1 << 0)
#define PHASE_EVALUATE (1<<1)

Have one variable to track which phase we are currently in,
initialized to parsing.

int current_phase = PHASE_PARSING;

When move to evaluation:

current_phase = PHASE_EVALUATE;

The following code:
-       max_warnings = 0;
+       has_error |= ERROR_CURR_PHASE;

will change to:
        has_error |= current_phase;

Then you don't need to move bits between different phase:

+
+       if (has_error & ERROR_CURR_PHASE)
+               has_error = ERROR_PREV_PHASE;

That will be gone. The rest of the patch should be very similar.

This has the advantage of:
- The code clearly show which stage it is in.
- No need to move error bits from current phase to previous phase.
- more friendly if we have more than two phase.

Chris
