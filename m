From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] evaluate: pointer arithmetics on plain void* (was: [PATCH]
 evaluate: reject post-ops on void*)
Date: Tue, 24 Jan 2012 02:54:45 -0800
Message-ID: <CANeU7Q=jtJ=cVcgKdidA_8Fds3qVX980M_-Q0OkiiOvvo-MRBA@mail.gmail.com>
References: <4F1C9C49.2050707@seznam.cz>
	<4F1D3741.2030604@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52127 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327Ab2AXKyq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 24 Jan 2012 05:54:46 -0500
Received: by yhoo21 with SMTP id o21so1724757yho.19
        for <linux-sparse@vger.kernel.org>; Tue, 24 Jan 2012 02:54:45 -0800 (PST)
In-Reply-To: <4F1D3741.2030604@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jan 23, 2012 at 2:32 AM, Jan Pokorn=FD <pokorny_jan@seznam.cz> =
wrote:
> Hm, I was talking about post-ops only, the example showed a failing p=
re-op
> ...both is a single case as evaluate_preop boils down to evaluate_pos=
top.
>
> I went through evaluate.c again and I think these cases should be som=
ehow
> unified (stating current state):

I am leaning towards make the explicit sizeof(void) as error.
Implicate sizeof(void) used in the pointer arithmetic are (optional) wa=
rnings.
The question is we give warning or not. Hmm.

However, forcing the type cast to get rid of the warning is very ugly.
"(void*)(++(char*)a)" is harder to read than "++a".

It is too late tonight for me to look at the patch right now. I will
take a closer look
tomorrow.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
