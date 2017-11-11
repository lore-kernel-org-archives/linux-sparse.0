From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Sat, 11 Nov 2017 23:59:55 +0100
Message-ID: <20171111225218.m3cqbid6ug7r57jw@ltop.local>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39461 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdKKXAB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 18:00:01 -0500
Received: by mail-wm0-f47.google.com with SMTP id l8so3184923wmg.4
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 15:00:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 01:29:08AM +0800, Christopher Li wrote:
> On Sun, Nov 12, 2017 at 12:24 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This series inhibit the illegal simplification of redundant
> > stores when the stores are volatiles ones.
> >
> > Luc Van Oostenryck (2):
> >   add test case for bogus volatile simplification
> >   fix: volatile stores must not be simplified
> 
> Looks good to me.
> 
> Can I apply those?


If you would do that:
1) it would be equivalent to rebasing one of my branches
2) it make me wonder if I have misunderstood something to the way
   we had, some months ago, agreed to work together.
3) it make me wonder why there is 67 branches in my github
   tree waiting for you to pull them, most having been totally
   ignored by you, a good number of them being 7 or 8 months old
   with a few even older (not talking about the dozens of other
   topic branches that I've never bothered to submit because they
   don't make sense without their parent branches).
4) it make me wonder why this sudden promptitude from your part.


Now, to be honest, I don't care much anymore, I'm just sick and tired of it.

-- Luc
