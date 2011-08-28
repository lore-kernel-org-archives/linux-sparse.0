From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] cse: update PHI users when throwing away an instruction
Date: Sun, 28 Aug 2011 09:33:14 +0300
Message-ID: <CAOJsxLGWGL-zn-WxArEDRBKjB-DGmpztsugi176o3JiRC5fnXw@mail.gmail.com>
References: <4E588EB8.80808@garzik.org>
	<4E590F22.6030800@garzik.org>
	<CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
	<201108280139.59217.kdudka@redhat.com>
	<CA+55aFwPLDZZAEfP8xdFwqG2MG_79mbN_TjNTGRvyRq=WPWcSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46790 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab1H1GdP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 02:33:15 -0400
Received: by gxk21 with SMTP id 21so3986987gxk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 23:33:15 -0700 (PDT)
In-Reply-To: <CA+55aFwPLDZZAEfP8xdFwqG2MG_79mbN_TjNTGRvyRq=WPWcSQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Sat, Aug 27, 2011 at 4:39 PM, Kamil Dudka <kdudka@redhat.com> wrote:
>> The attached patch solves the dangling PHI nodes and does not seem t=
o break
>> anything at first glance. =A0It is probably not the most efficient s=
olution,
>> but it might at least show where to look for the problem.

On Sun, Aug 28, 2011 at 3:34 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Hmm. From a quick look, looks fine to me. And checks the kernel, and
> does indeed get rid of the extraneous phi nodes in the test-case.
>
> Ack.

I applied both patches to sparse-llvm.git. Jeff, do they cure all loop
related issues?

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
