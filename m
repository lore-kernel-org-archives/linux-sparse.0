From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Thu, 9 Mar 2017 14:42:08 +0000
Message-ID: <CACXZuxctddtv9VKSK7_cfC=vBAu04hXxvSa02BmTF_Y8mDqPEg@mail.gmail.com>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <20170307064436.qtcscbwbjsrjoyko@macpro.local> <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
 <20170308065337.vwrebdlo4poc4da4@macpro.local> <CACXZuxcbDJAeRBN_wpTRPRk7efOM2vLytke=k_0f4=C0dOQtrA@mail.gmail.com>
 <CACXZuxeQO4p+J5MyggZhWJF9FfwnXHdG_wxx34jF3NFXqgd4Yg@mail.gmail.com> <20170309143513.pe7y5kuclabndyzu@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36578 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754955AbdCIOmg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Mar 2017 09:42:36 -0500
Received: by mail-it0-f41.google.com with SMTP id h10so129557421ith.1
        for <linux-sparse@vger.kernel.org>; Thu, 09 Mar 2017 06:42:09 -0800 (PST)
In-Reply-To: <20170309143513.pe7y5kuclabndyzu@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 9 March 2017 at 14:35, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Mar 09, 2017 at 01:50:16AM +0000, Dibyendu Majumdar wrote:
>>
>> I think by combining the symbol's identifier and address a unique
>> reference can be created - thus whenever we encounter a symbol that is
>> not extern or toplevel we should create a local object using the
>> symbol's name + address as the LLVM identifier.
>
> That's more or less the idea, of course.
> And you need to consider all objects that you don't need to
> allocate because they are always in a (pseudo-) register.
>

Ok thank you. I will try to implement a fix and get back when I have
something that works or if I get stuck.

Regards
Dibyendu
