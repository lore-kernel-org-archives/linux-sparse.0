From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 1/4] add support for a new flag: -fdump-linearize[=only]
Date: Fri, 7 Apr 2017 01:32:04 +0100
Message-ID: <CACXZuxddGHr6xx7KC93Lw-bVoexwmuFQwuE2qsQ3yO6bGBehXg@mail.gmail.com>
References: <20170406230029.11384-1-luc.vanoostenryck@gmail.com> <20170406230029.11384-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:32887 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbdDGAcF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2017 20:32:05 -0400
Received: by mail-io0-f175.google.com with SMTP id t68so6910237iof.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Apr 2017 17:32:05 -0700 (PDT)
In-Reply-To: <20170406230029.11384-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>

Hi Luc,

On 7 April 2017 at 00:00, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The effect of this flag is to dump the IR just after the
> linearization, before any simplification, and to stop
> further processing if '=only' is given as argument.
>
> The motivation of this flag is of course for debugging,
> to be able to inspect the raw result of the linearization,
> undisturbed by an simplification.
>

In my view it is better to use the existing -O<n> option to control
whether or not simplifications are done. That way sparse-llvm can be
run with/without simplifications.

Of course there is an issue that what should be the default for this
setting if no option is given by the user. I would suggest that -O0
switches off simplifications, any other value or not specifying -O
switches it on.

Thanks and Regards
Dibyendu
