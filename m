From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] cse: update PHI users when throwing away an instruction
Date: Sun, 28 Aug 2011 04:53:48 -0400
Message-ID: <4E5A021C.4000406@garzik.org>
References: <4E588EB8.80808@garzik.org> <4E590F22.6030800@garzik.org> <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com> <201108280139.59217.kdudka@redhat.com> <CA+55aFwPLDZZAEfP8xdFwqG2MG_79mbN_TjNTGRvyRq=WPWcSQ@mail.gmail.com> <CAOJsxLGWGL-zn-WxArEDRBKjB-DGmpztsugi176o3JiRC5fnXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59841 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab1H1Ixv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 04:53:51 -0400
Received: by qwk3 with SMTP id 3so2752047qwk.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 01:53:50 -0700 (PDT)
In-Reply-To: <CAOJsxLGWGL-zn-WxArEDRBKjB-DGmpztsugi176o3JiRC5fnXw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kamil Dudka <kdudka@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On 08/28/2011 02:33 AM, Pekka Enberg wrote:
> On Sat, Aug 27, 2011 at 4:39 PM, Kamil Dudka<kdudka@redhat.com>  wrote:
>>> The attached patch solves the dangling PHI nodes and does not seem to break
>>> anything at first glance.  It is probably not the most efficient solution,
>>> but it might at least show where to look for the problem.
>
> On Sun, Aug 28, 2011 at 3:34 AM, Linus Torvalds
> <torvalds@linux-foundation.org>  wrote:
>> Hmm. From a quick look, looks fine to me. And checks the kernel, and
>> does indeed get rid of the extraneous phi nodes in the test-case.
>>
>> Ack.
>
> I applied both patches to sparse-llvm.git. Jeff, do they cure all loop
> related issues?

They look promising...  Currently loops are stuck due to issues 
unrelated to core sparse:  OP_PHI does not show successor phi's due to 
->priv==NULL.  Loops definitely will not work without both predecessors 
and successors both having a correct ->priv pointing to LLVM data.

	Jeff




