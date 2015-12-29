From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH RFC 00/13] improve constexpr handling
Date: Tue, 29 Dec 2015 09:34:44 +0100
Message-ID: <874mf1r6u3.fsf@gmail.com>
References: <87y4i7kdlq.fsf@gmail.com> <20150723003757.GA28528@cloud>
	<871tfzi6cq.fsf@gmail.com> <20150723184723.GA1605@cloud>
	<878u9qci4o.fsf@gmail.com>
	<CANeU7Qmx3ttWHzwSprPDZ3YdoVcun9VWLmk2wHfzCf2FyiA5wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36378 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbbL2Ier (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Dec 2015 03:34:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so30988814wmf.3
        for <linux-sparse@vger.kernel.org>; Tue, 29 Dec 2015 00:34:47 -0800 (PST)
In-Reply-To: <CANeU7Qmx3ttWHzwSprPDZ3YdoVcun9VWLmk2wHfzCf2FyiA5wQ@mail.gmail.com>
	(Christopher Li's message of "Sun, 9 Aug 2015 20:06:45 -0400")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Josh Triplett <josh@joshtriplett.org>

Christopher Li <sparse@chrisli.org> writes:

> On Wed, Aug 5, 2015 at 3:24 AM, Nicolai Stange <nicstange@gmail.com> wrote:
>> Just a friendly ping to get some more reviews to consider in my next
>> resend, especially on [13/13] and whether to relax the constant
>> expression rules to treat pointer differences of address constants as
>> (arithmetic or integer) constant expressions.
>
> Sorry for the late reply. I am working on it. It will take me a bit of time
> to think about the change. I like the generate direction you are going.
>
> Chris

Hi Chris,

do you see any way to get this one going again?

Cheers,

Nicolai
