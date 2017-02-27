From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/4] CSE: improve hashing of non-commutative binops
Date: Mon, 27 Feb 2017 16:03:13 +0800
Message-ID: <CANeU7QkO40CHEzFft=8aK5CtW+DSxDJPc-XJjESzJLy2Te01zw@mail.gmail.com>
References: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
 <20170216231231.5781-5-luc.vanoostenryck@gmail.com> <CANeU7Q=2un=p62S5ToDt8djfhDLVtv=mgYoAcuOFGTQ9D_P+7w@mail.gmail.com>
 <20170223141313.o2vdjzv5y3c4lo5f@macpro.local> <20170223150351.ebdi473jxbm4nkgt@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36776 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbdB0ID6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 03:03:58 -0500
Received: by mail-io0-f171.google.com with SMTP id l7so13516633ioe.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 00:03:13 -0800 (PST)
In-Reply-To: <20170223150351.ebdi473jxbm4nkgt@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 23, 2017 at 11:03 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Feb 23, 2017 at 03:13:14PM +0100, Luc Van Oostenryck wrote:
>>
>> So, I have absolutely no problems if this patch is dropped.
>
> After some more thoughts I'm convinced that this patch was
> a bad idea, please drop it.

OK. Patch dropped in the current sparse-next.

Chris
