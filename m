From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] cse: update PHI users when throwing away an instruction
Date: Sat, 27 Aug 2011 17:34:21 -0700
Message-ID: <CA+55aFwPLDZZAEfP8xdFwqG2MG_79mbN_TjNTGRvyRq=WPWcSQ@mail.gmail.com>
References: <4E588EB8.80808@garzik.org> <4E590F22.6030800@garzik.org>
 <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com> <201108280139.59217.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49065 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751249Ab1H1AmS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 20:42:18 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7S0gGrK012005
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 17:42:17 -0700
Received: by wwf5 with SMTP id 5so4631635wwf.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 17:42:16 -0700 (PDT)
In-Reply-To: <201108280139.59217.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

On Sat, Aug 27, 2011 at 4:39 PM, Kamil Dudka <kdudka@redhat.com> wrote:
>
> The attached patch solves the dangling PHI nodes and does not seem to=
 break
> anything at first glance. =A0It is probably not the most efficient so=
lution,
> but it might at least show where to look for the problem.

Hmm. From a quick look, looks fine to me. And checks the kernel, and
does indeed get rid of the extraneous phi nodes in the test-case.

Ack.

                       Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
