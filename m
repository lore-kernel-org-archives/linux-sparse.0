From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Thu, 9 Feb 2017 00:45:12 +0100
Message-ID: <20170208234511.xqitikuftzuhgvo3@macpro.local>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
 <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
 <20170208165055.ibu47j2axwi2j53f@macpro.local>
 <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
 <20170208213544.ahkbsgvikwdb7nsu@macpro.local>
 <CANeU7Qn9CqWmQ-VUY928xm2fogqMGpfEbaBw+LrtfDbOrLTNfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32773 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbdBHXyN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 18:54:13 -0500
Received: by mail-wr0-f195.google.com with SMTP id i10so10257899wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 15:54:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn9CqWmQ-VUY928xm2fogqMGpfEbaBw+LrtfDbOrLTNfQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 09, 2017 at 06:13:46AM +0800, Christopher Li wrote:
> 
> Any way, your new version of patch is applied in sparse-next.
> 
> Chris

Thanks.
I've just finished to test everything again and everything is
fine. Linux's kernel x86 allyesconfig output give exactly the
same output as two days ago as it was expected.

Luc
