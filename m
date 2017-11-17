From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] add __builtin functions for isinf_sign, isfinite and isnan
Date: Sat, 18 Nov 2017 00:28:59 +0100
Message-ID: <CAExDi1QA-NV0JYKnOzxxnkLfimzr9Bw6Q0irKxmmnByfP5XeWA@mail.gmail.com>
References: <20171116230817.10011-1-logang@deltatee.com> <20171117081348.5cdzuctwi6i3ltu6@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:42806 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759270AbdKQX3A (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Nov 2017 18:29:00 -0500
Received: by mail-it0-f67.google.com with SMTP id n134so5977746itg.1
        for <linux-sparse@vger.kernel.org>; Fri, 17 Nov 2017 15:29:00 -0800 (PST)
In-Reply-To: <20171117081348.5cdzuctwi6i3ltu6@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Fri, Nov 17, 2017 at 9:13 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Nov 16, 2017 at 04:08:17PM -0700, Logan Gunthorpe wrote:
>> These bultins are defined by in gcc since 4.4. They are also now
>> used by the isinf, isfinite and isnan macros. So using them with a
>> newer gcc causes 'undefined identifier' errors.
>>
>> Add the builtin definitions and some validation checks for these
>> functions.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>
> Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hmmm, looking at this closer, I only notice now that those builtins
are of the type-generic kind. Declaring them with a prototype as if
taking a float won't play nicely once you use them with a double or
a long double. Alas, there is not yet real support for type-generic
builtins. One solution would be:
        extern int __builtin_isfinite(long double);
Another one would be to use:
        extern int __builtin_isfinite(...);
but that is not C99 compliant (not sure if sparse complain).

Note, that there is also a few more builtins of the same family.

-- Luc Van Oostenryck
