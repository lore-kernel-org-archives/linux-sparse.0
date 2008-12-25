From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Wed, 24 Dec 2008 16:15:20 -0800
Message-ID: <70318cbf0812241615m22b9597coc68a5b3ceb9e09a5@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
	 <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>
	 <4950A8A2.5090702@knosof.co.uk>
	 <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>
	 <495181C0.7070803@knosof.co.uk>
	 <f19298770812231839n1aaaf84fla96dda04b11e0944@mail.gmail.com>
	 <4952B0AD.7040007@cowlark.com>
	 <70318cbf0812241510o2318f701w938840b9123fb9e4@mail.gmail.com>
	 <4952C758.8070605@numba-tu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:58976 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYLYAPV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 19:15:21 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3049180rvb.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 16:15:20 -0800 (PST)
In-Reply-To: <4952C758.8070605@numba-tu.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tommy Thorn <tommy@numba-tu.com>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

On Wed, Dec 24, 2008 at 3:35 PM, Tommy Thorn <tommy@numba-tu.com> wrote:
>
> You can't have one without the other as you will break identities like
>
>  (uintptr_t) (x + k) === (uintptr_t) x + sizeof (typeof (x)) * k
>
> which could appear in a macro.

Right. That is exactly the place I actuall want to know. We should
consider fix that in the source to have proper type. I expect there is
not much place in the kernel use that.

I can write some code to find out how many place in the kernel
actually need to evaluate sizeof(void).

What do you think?

>
> I really think you should let it go. The C standard for Linux is for all
> practical purposes GCC C, not C99 C.
>
> Trying to impose a stricter standard will just make sparse a less useful
> tool.

I understand that kernel is C stander gcc. But the whole point of sparse is
stricter than gcc. Otherwise we will just use gcc instead.

I agree that we should probably let the place use void* + offset go.

It all boils down to do we care about place directly use sizeof(void) or not.

Another aspect is that, inside sparse, it become very hard to distinguish
void vs char, other than compare it is &void_ctype or not. If we decide go
with sizeof(void) == 1. Those place that assume only uncompleted ctype
will have bit_size == 0 need to be fixed as well.

Chris
