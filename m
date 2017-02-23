From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/4] CSE: improve hashing of non-commutative binops
Date: Thu, 23 Feb 2017 20:39:17 +0800
Message-ID: <CANeU7Q=2un=p62S5ToDt8djfhDLVtv=mgYoAcuOFGTQ9D_P+7w@mail.gmail.com>
References: <20170216231231.5781-1-luc.vanoostenryck@gmail.com> <20170216231231.5781-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36211 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdBWMjT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Feb 2017 07:39:19 -0500
Received: by mail-it0-f53.google.com with SMTP id h10so164565479ith.1
        for <linux-sparse@vger.kernel.org>; Thu, 23 Feb 2017 04:39:18 -0800 (PST)
In-Reply-To: <20170216231231.5781-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Feb 17, 2017 at 7:12 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> During CSE equivalent instructions should hash to the same value
> but we should also try to *not* hash to the same value instructions
> that cannot be equivalent.
> For commutative ops this means that the hash function should itself
> be commutative/symmetrical regarding the exchange of its operands.
> This is already the case but the current hash function is symmetrical
> for all binops, not only the commutative ones. Thus expressions like
> 'a - b' and 'b - a' hash to the same value while it should be the case
> only when 'a == b'.
>
> Fix this by changing the hashing of non-commutative binops so that it
> is anti-symmetrical regarding the exchange of operands while keeping
> commutative ones symmetrical.
>
> This change have no functional effects (in the sense that it shoudl
> CSE exactly the same instructiosn as before), it should only improve
> the efficiency of the hashing+comparing.
>
> Note: on the 5000+ test set I'm using, I can't see any significant
>   speedup which is quite normal since most of the functions therein
>   have (much) less instructions than the size of the hash table.
>   The effect of this patch should only be on much bigger functions.

I apply and push this series to sparse-next.

Just curious if there is test case can show the performance increase.
As far as I can tell, this patch has down side as well, it hash the non
commutative operation *twice*. If for most of the case this actually
is the higher cost we might want to keep the old behavior.

Chris
