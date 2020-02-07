From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Fri, 7 Feb 2020 13:43:05 +0100
Message-ID: <20200207124305.islfnt5kissyv6b6@ltop.local>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
 <20200206200610.7ktqp2yzriw7zurx@ltop.local>
 <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
 <b6d24fd2-e5b8-7010-86b5-c46f65536eef@kleine-koenig.org>
 <20200207082954.majgsx5trepwb46n@kafai-mbp>
 <f41aa7cb-399d-277b-eda8-4173f45d7123@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35241 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGMnJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 07:43:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so2654990wmb.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Feb 2020 04:43:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f41aa7cb-399d-277b-eda8-4173f45d7123@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Martin KaFai Lau <kafai@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Arthur Fabre <afabre@cloudflare.com>

On Fri, Feb 07, 2020 at 12:34:02PM +0100, Uwe Kleine-König wrote:
> On 2/7/20 9:29 AM, Martin KaFai Lau wrote:
> > I believe x == 1 needs an extra case since ilog2(0) won't work.
> > 
> > Since this function (map creation) is not on the fast path,
> > I currently opt for Linus's suggestion which its code is more
> > self-explanatory.
> 
> If you put my suggestion in a macro that is called for example
> 
> 	ilog2_roundup()
> 
> you might have both: easier code and self-explanation.

This is, essentially, the same as the existing order_base_2().

Best regards,
-- Luc
