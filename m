From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/4] CSE: improve hashing of non-commutative binops
Date: Thu, 23 Feb 2017 16:03:52 +0100
Message-ID: <20170223150351.ebdi473jxbm4nkgt@macpro.local>
References: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
 <20170216231231.5781-5-luc.vanoostenryck@gmail.com>
 <CANeU7Q=2un=p62S5ToDt8djfhDLVtv=mgYoAcuOFGTQ9D_P+7w@mail.gmail.com>
 <20170223141313.o2vdjzv5y3c4lo5f@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:32775 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBWPFK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Feb 2017 10:05:10 -0500
Received: by mail-wr0-f170.google.com with SMTP id 97so23476656wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 23 Feb 2017 07:03:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170223141313.o2vdjzv5y3c4lo5f@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 23, 2017 at 03:13:14PM +0100, Luc Van Oostenryck wrote:
> 
> So, I have absolutely no problems if this patch is dropped.

After some more thoughts I'm convinced that this patch was
a bad idea, please drop it.

The rationale being that even if there is a lot of pair of
dual instructions ('Xi - Yi' / 'Yi - Xi'), their hashing
will still be spreaded relatively evenly because there
will be a lot of Xi & Yi but with the patch *every*
instruction like 'Xi - Xi' will give the same hash
indenpendently of the Xi.

Luc
