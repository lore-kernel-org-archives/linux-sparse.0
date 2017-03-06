From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Possible incorrect linearization of code (master branch)
Date: Mon, 6 Mar 2017 18:47:36 +0000
Message-ID: <CACXZuxd_6YS7cficTeuPayyYCT-0Q==i3hje_Xd-MtoAP6bLyQ@mail.gmail.com>
References: <CACXZuxeNopu3Syg+TCL3TLnhwmA84qkQ1NsN4hjL-VLPi6ASYA@mail.gmail.com>
 <20170306163638.huqjg6my2qhwyyzy@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38368 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932387AbdCFSrn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 13:47:43 -0500
Received: by mail-it0-f52.google.com with SMTP id m27so56399060iti.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 10:47:37 -0800 (PST)
In-Reply-To: <20170306163638.huqjg6my2qhwyyzy@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 6 March 2017 at 16:36, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Mar 06, 2017 at 03:22:19PM +0000, Dibyendu Majumdar wrote:
>> main:
>> .L2:
>>         <entry-point>
>>         call.64     %r10 <- incr, "abcde"
>>         setne.32    %r15 <- %r13, $101
>>         ret.32      %r15
>
>
> This is already fixed in commit
>          https://git.kernel.org/cgit/devel/sparse/sparse.git/commit/?h=sparse-next-20170306&id=b8c268640114d614178d4875fbe0f5e6b53b036b
>

Okay thanks. I had originally started from the release 0.5 version of
Sparse, and applied fixes selectively. Because I have a modified
version of Sparse with all global state removed, merging changes is a
bit painful as it has be done manually. That is why I have not been
tracking sparse-next as I thought it is not yet stable. I have now
merged all changes from master. Should I merge sparse-next now or wait
for it to be merged into master?

Regards
Dibyendu
