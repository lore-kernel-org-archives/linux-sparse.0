From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Adding ignored attribute optimize
Date: Mon, 3 Jul 2017 11:23:48 -0700
Message-ID: <CANeU7QndbPf7cGaCYixx=YqJzBxx4DmEiAwMNXNxvCirLRZK8Q@mail.gmail.com>
References: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
 <20170629070437.o6j2bkv6wdbcknwa@ltop.local> <CANeU7QnfvQ5KNFKvGGeJ1u7CDpd5wigosY0BrGNT1H0KouPHuA@mail.gmail.com>
 <20170701092440.egmgcexgwuuybzj7@ltop.local> <CANeU7Q=Zj6LT1--TP-XGouwVZVTgJor8h1+2GZ1r0HCjVa5pmw@mail.gmail.com>
 <20170702195818.2lhotikeq2ozjb2n@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34511 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbdGCSXt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 3 Jul 2017 14:23:49 -0400
Received: by mail-pg0-f46.google.com with SMTP id t186so99038584pgb.1
        for <linux-sparse@vger.kernel.org>; Mon, 03 Jul 2017 11:23:49 -0700 (PDT)
In-Reply-To: <20170702195818.2lhotikeq2ozjb2n@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 2, 2017 at 12:58 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> "should report error" ...
> What error exactly? Is there something that doesn't work on sparse
> or on GCC's side regarding this 'require_context'? What need to be
> fixed exactly?

Have you look at the require_context code causing the warning in the
kernel? That code only issue require_context when compiling with sparse.

The fix should be just either convert to context parsing sparse supported,
implement in sparse, or just remove the require_context in kernel. It is
not doing any thing there right now. What else do you thing it is the
right fix for it?

>
> That's *exactly* why sparse should *not* report. You have no way to
> tell if what you're reporting is legitimate or not. And in most
> cases it's legitimate on GCC's side but you still want to report it.

I don't like sparse warn on the legit gcc attribute either.
I have some patch should make both of us happy.

GCC is open. It is not that hard to get a full list of gcc supported
attribute names.  I add the full list of gcc supported attribute list
into the sparse. Sparse should not warn on any known gcc attributes
any more. Patch on the way.

Let's be done with this.

Chris
