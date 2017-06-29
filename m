From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Adding ignored attribute optimize
Date: Thu, 29 Jun 2017 14:46:09 -0700
Message-ID: <CANeU7QnfvQ5KNFKvGGeJ1u7CDpd5wigosY0BrGNT1H0KouPHuA@mail.gmail.com>
References: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
 <20170629070437.o6j2bkv6wdbcknwa@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33701 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753826AbdF2VqL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 17:46:11 -0400
Received: by mail-io0-f172.google.com with SMTP id h64so14731305iod.0
        for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2017 14:46:11 -0700 (PDT)
In-Reply-To: <20170629070437.o6j2bkv6wdbcknwa@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 29, 2017 at 12:04 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> There is also a long time 'require_context' in drivers/block/drbd,/
> a failed attempt to fix or extend sparse's handling of lock context.
> Why is it still there after all those years, I have no idea.

Yes, I notice that one too. But that one require to fix in the kernel side.
Sparse does not support that kind of syntax.

>
> Anyway, my position about these unknown attributes is still the same
> of course: we should simply ignore them instead of annoying people
> with useless warnings.

I have carefully consider your idea. It will have other unwanted behavior.
That is why I did not apply your patch to change the default as no warning.

Let say some one typo the sparse specific attribute "__contxt__" instead
of "__context__". Sparse will not give warning about those typo. The statement
become an no-op. It will be very hard for developer to find out what
is going on.
In this case, we do want to give out warning on unknown sparse
specific attributes.

Does it make sense?

Chris
