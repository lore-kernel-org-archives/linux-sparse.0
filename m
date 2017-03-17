From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Fri, 17 Mar 2017 14:06:36 +0000
Message-ID: <CACXZuxdUJkxWpBo0G_QC=gbjhbE4hzM+KTRmPi-qeOzjc7G2pw@mail.gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnij2q3hDETDsHTK8jtfu5pPabyX-xLRb7NGvsd8T4oBQ@mail.gmail.com> <20170316164147.u5qozn6yk2hwhp4x@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:37413 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdCQOH2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Mar 2017 10:07:28 -0400
Received: by mail-it0-f45.google.com with SMTP id g138so27029236itb.0
        for <linux-sparse@vger.kernel.org>; Fri, 17 Mar 2017 07:07:27 -0700 (PDT)
In-Reply-To: <20170316164147.u5qozn6yk2hwhp4x@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

Hi Luc,

On 16 March 2017 at 16:41, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 14, 2017 at 02:18:30PM +0800, Christopher Li wrote:
>> On Sat, Mar 11, 2017 at 5:06 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> > This series solves a number of issues in sparse-llvm,
>> > mainly about wrong or missing type information as needed
>> > to build LLVM IR.
>> > These issues have been reported and investigated by
>> > Dibyendu Majumdar.
>>
>> I am on a trip again. I will apply the patch towards the end of this week.
>>
>> Looking forward to it.
>
> OK. No hurry anyway as I have to update the serie anyway.
>

I have reported a bunch of issues and fixes in the past few days.
Please let me know how we should proceed with those. I can submit
patches if that would help - I will wait for the current set of
patches to be updated before submitting any. Alternatively the changes
are all reflected in my repository - and if you prefer you can rework
them if necessary and submit.

Thanks and Regards
Dibyendu
