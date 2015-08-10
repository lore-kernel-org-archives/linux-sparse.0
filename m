From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC 00/13] improve constexpr handling
Date: Sun, 9 Aug 2015 20:06:45 -0400
Message-ID: <CANeU7Qmx3ttWHzwSprPDZ3YdoVcun9VWLmk2wHfzCf2FyiA5wQ@mail.gmail.com>
References: <87y4i7kdlq.fsf@gmail.com>
	<20150723003757.GA28528@cloud>
	<871tfzi6cq.fsf@gmail.com>
	<20150723184723.GA1605@cloud>
	<878u9qci4o.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34071 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbbHJAGq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 9 Aug 2015 20:06:46 -0400
Received: by ykdt205 with SMTP id t205so46953003ykd.1
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2015 17:06:45 -0700 (PDT)
In-Reply-To: <878u9qci4o.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Josh Triplett <josh@joshtriplett.org>

On Wed, Aug 5, 2015 at 3:24 AM, Nicolai Stange <nicstange@gmail.com> wrote:
> Just a friendly ping to get some more reviews to consider in my next
> resend, especially on [13/13] and whether to relax the constant
> expression rules to treat pointer differences of address constants as
> (arithmetic or integer) constant expressions.

Sorry for the late reply. I am working on it. It will take me a bit of time
to think about the change. I like the generate direction you are going.

Chris
