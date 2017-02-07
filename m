From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 4/5] simplify '(x / -1)' to '-x' (but only for signed division)
Date: Tue, 07 Feb 2017 20:39:22 +0100
Message-ID: <87mvdx4wph.fsf@rasmusvillemoes.dk>
References: <CANeU7QkOmqZH-X4C3Ma6b94jyx1LnjM=UEH2CjEt0SwgZ4Y2Kw@mail.gmail.com>
        <20170207190028.24343-1-luc.vanoostenryck@gmail.com>
        <20170207190028.24343-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36849 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbdBGTrC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 14:47:02 -0500
Received: by mail-wm0-f52.google.com with SMTP id c85so175601348wmi.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 11:47:02 -0800 (PST)
In-Reply-To: <20170207190028.24343-5-luc.vanoostenryck@gmail.com> (Luc Van
        Oostenryck's message of "Tue, 7 Feb 2017 20:00:27 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Tue, Feb 07 2017, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

>  int smulm1(int a) { return a * -1; }
>  u32 umulm1(u32 a) { return a * (u32) -1; }
> +int sdivm1(int a) { return a * -1; }

You probably meant / rather than *. Also, shouldn't you also add a test that
when a is unsigned, a/-1 does _not_ get transformed to -a?

Rasmus
