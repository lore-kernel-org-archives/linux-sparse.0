From: Christopher Li <sparse@chrisli.org>
Subject: Re: Status of sparse-next
Date: Mon, 12 Jun 2017 09:26:45 -0700
Message-ID: <CANeU7Q=P-MbopU3k_gNQEBNMVDLP1C1BYrKEK9n0d3UvAnNpQA@mail.gmail.com>
References: <CACXZuxfeUP6bvDwmYv=O4yR7GXOCDeFPf5Sk-_OdXtE+=uZ1Eg@mail.gmail.com>
 <20170611224629.ak7evynf6lcyorz7@ltop.local> <CACXZuxdqtQY=ak+tNJ64H4hg2CdCxLs_W73tYEQhMKFCmoJ3_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33679 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbdFLQ0r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Jun 2017 12:26:47 -0400
Received: by mail-io0-f179.google.com with SMTP id t87so37863849ioe.0
        for <linux-sparse@vger.kernel.org>; Mon, 12 Jun 2017 09:26:46 -0700 (PDT)
In-Reply-To: <CACXZuxdqtQY=ak+tNJ64H4hg2CdCxLs_W73tYEQhMKFCmoJ3_A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jun 11, 2017 at 3:57 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 11 June 2017 at 23:46, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Sun, Jun 11, 2017 at 11:02:40PM +0100, Dibyendu Majumdar wrote:
>>> I was wondering if the sparse-next branch is going to be stable soon.
>>
>> As far as I know, sparse-next is very stable.
>> Are you aware of any instability?
>>
>
> I don't actively use sparse-next so I don't know of any. Good to know
> that sparse-next is stable.

I want to clarify that, "stable" you mean the code quality is good (no obvious
bugs or crashes), or the git branch will not be roll back.

As for the code quality, I believe that is reasonable stable.

As for change roll back, the sparse-next is created with the goal to
test out some of the newly merge changes. In theory rolling back history
is possible with sparse-next if we find out some thing seriously wrong
with the purposed changes. So it is not a stable point if you want to base
your change on. The master branch will not roll back history,
that is a more stable branch.

>> But yes, all the LLVM patches I suppose you're interested in
>> haven't yet made it and sparse-next itself still need to be
>> promoted to master.
>>
>
> I am interested in merging all the other changes too - but I wanted to
> do this when all of the outstanding changes are included.
>
> Is there a specific goal for the next release of sparse, or will it be
> just a point in time snapshot of sparse-next?

Yes, I will do a very brief release of sparse just to flush out the new
change into a version. Then we are going back to merge Luc's other
changes.

Chris
