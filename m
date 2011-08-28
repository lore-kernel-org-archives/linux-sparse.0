From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] cse: update PHI users when throwing away an instruction
Date: Sat, 27 Aug 2011 23:32:17 -0700
Message-ID: <CANeU7QmyL0Y5jj=nH8VE3XTcFFpDzx1P8Ry6Hp2MrB41y1YYgw@mail.gmail.com>
References: <4E588EB8.80808@garzik.org>
	<4E590F22.6030800@garzik.org>
	<CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
	<201108280139.59217.kdudka@redhat.com>
	<CA+55aFwPLDZZAEfP8xdFwqG2MG_79mbN_TjNTGRvyRq=WPWcSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36157 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1H1GcS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 02:32:18 -0400
Received: by qyk34 with SMTP id 34so3073790qyk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 23:32:17 -0700 (PDT)
In-Reply-To: <CA+55aFwPLDZZAEfP8xdFwqG2MG_79mbN_TjNTGRvyRq=WPWcSQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

On Sat, Aug 27, 2011 at 5:34 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Aug 27, 2011 at 4:39 PM, Kamil Dudka <kdudka@redhat.com> wrot=
e:
>>
>> The attached patch solves the dangling PHI nodes and does not seem t=
o break
>> anything at first glance. =A0It is probably not the most efficient s=
olution,
>> but it might at least show where to look for the problem.
>
> Hmm. From a quick look, looks fine to me. And checks the kernel, and
> does indeed get rid of the extraneous phi nodes in the test-case.

Applied.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
