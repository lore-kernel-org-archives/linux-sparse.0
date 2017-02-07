From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 4/5] simplify '(x / -1)' to '-x' (but only for signed division)
Date: Wed, 8 Feb 2017 04:33:30 +0800
Message-ID: <CANeU7Q=67iWdgssXLEQyX0Saoe8iCf17jDCh7PWwwpeAuEhVAQ@mail.gmail.com>
References: <CANeU7QkOmqZH-X4C3Ma6b94jyx1LnjM=UEH2CjEt0SwgZ4Y2Kw@mail.gmail.com>
 <20170207190028.24343-1-luc.vanoostenryck@gmail.com> <20170207190028.24343-5-luc.vanoostenryck@gmail.com>
 <87mvdx4wph.fsf@rasmusvillemoes.dk> <20170207202805.vtpnn3w5nyt4xwp7@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34912 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932273AbdBGUkW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:40:22 -0500
Received: by mail-io0-f196.google.com with SMTP id m98so13977986iod.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:40:21 -0800 (PST)
In-Reply-To: <20170207202805.vtpnn3w5nyt4xwp7@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 8, 2017 at 4:28 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

>
>> Also, shouldn't you also add a test that
>> when a is unsigned, a/-1 does _not_ get transformed to -a?
> Hummm , yes but ... well, I'll see what I can do.

Let me know if there is a V3 coming then.

Chris
