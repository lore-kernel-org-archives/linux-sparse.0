From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: sparse preprocessing confused
Date: Wed, 25 Apr 2007 19:52:12 -0400
Message-ID: <118833cc0704251652r28f2431cs145a993e783a58bc@mail.gmail.com>
References: <20070425164355.2c250388.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:28620 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423402AbXDYXwN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Apr 2007 19:52:13 -0400
Received: by wr-out-0506.google.com with SMTP id 76so433106wra
        for <linux-sparse@vger.kernel.org>; Wed, 25 Apr 2007 16:52:13 -0700 (PDT)
In-Reply-To: <20070425164355.2c250388.rdunlap@xenotime.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

On 4/25/07, Randy Dunlap <rdunlap@xenotime.net> wrote:
> Although this may just be a case of "it's fugly, kill it".
>
> In net/core/skbuff.c (2.6.21-rc7-mm1), we have:
>
>         memcpy(data + nhead, skb->head,
> #ifdef NET_SKBUFF_DATA_USES_OFFSET
>                 skb->tail);
> #else
>                 skb->tail - skb->head);
> #endif

If memcpy happens to be a macro, that is not valid C.

M.
